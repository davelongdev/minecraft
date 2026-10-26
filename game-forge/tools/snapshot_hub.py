#!/usr/bin/env python3
"""Snapshot the Game Forge hub into the pack as structures forge:hub/west and forge:hub/east,
which forge:___restore_hub places back. Every block in the hub box is saved, air included, so a
restore also removes anything built since; block entities (signs etc.) are kept, entities are not
(the lobby NPCs heal themselves).

Why offline: a structure block triggered by redstone only keeps the structure in the server's
memory (gone after a restart); only the Save button in its screen writes a file.

Run on the box after `save-all flush`, with make_void_world.py (NBT reader/writer) next to it:
    python3 snapshot_hub.py /srv/mc/game-forge/world/dimensions/minecraft/overworld/region OUTDIR
then copy OUTDIR/hub/*.nbt into game-forge/data/forge/structure/hub/ and rebuild the zip.
"""
import gzip
import struct
import sys
import zlib
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from make_void_world import COMPOUND, INT, LIST, STRING, Reader, Writer  # noqa: E402

DATA_VERSION = 5023  # 26.3
Y0, Y1, Z0, Z1 = 55, 80, -21, 21
PARTS = {"west": (-16, 15), "east": (16, 63)}  # x ranges; 48 blocks per side at most (east grew from 41 on 2026-10-26, tools/extend_hub.py)


def unwrap(v):
    """(tag, value) -> plain Python value."""
    t, val = v
    if t == COMPOUND:
        return {k: unwrap(x) for k, x in val.items()}
    if t == LIST:
        et, items = val
        return [unwrap((et, x)) for x in items]
    return val


def state_of(entry):
    """A palette entry (several 26.x encodings) -> (id, ((prop, value), ...))."""
    if isinstance(entry, str):
        return entry, ()
    if "" in entry:
        return entry[""], ()
    name = entry.get("id") or entry.get("Name")
    props = entry.get("properties") or entry.get("Properties") or {}
    return name, tuple(sorted(props.items()))


def read_chunks(region_dir, x0, x1):
    blocks, bents = {}, {}
    for rx in range(x0 >> 9, (x1 >> 9) + 1):
        for rz in range(Z0 >> 9, (Z1 >> 9) + 1):
            f = Path(region_dir) / f"r.{rx}.{rz}.mca"
            if not f.exists():
                continue
            data = f.read_bytes()
            for k in range(1024):
                off = int.from_bytes(data[k * 4:k * 4 + 3], "big")
                if not off:
                    continue
                p = off * 4096
                ln = struct.unpack(">i", data[p:p + 4])[0]
                r = Reader(zlib.decompress(data[p + 5:p + 4 + ln]))
                r.num("b")
                r.string()
                root = unwrap((COMPOUND, r.payload(COMPOUND)))
                cx, cz = root["xPos"] * 16, root["zPos"] * 16
                if cx + 15 < x0 or cx > x1 or cz + 15 < Z0 or cz > Z1:
                    continue
                for sec in root.get("sections", []):
                    bs = sec.get("block_states") or {}
                    pal = [state_of(e) for e in bs.get("palette") or []]
                    if not pal:
                        continue
                    sy = sec["Y"] * 16
                    if sy + 15 < Y0 or sy > Y1:
                        continue
                    arr = bs.get("data")
                    bits = max(4, (len(pal) - 1).bit_length())
                    per = 64 // bits
                    for idx in range(4096):
                        x, z, y = cx + (idx & 15), cz + ((idx >> 4) & 15), sy + (idx >> 8)
                        if not (x0 <= x <= x1 and Y0 <= y <= Y1 and Z0 <= z <= Z1):
                            continue
                        v = 0
                        if arr is not None:
                            w = arr[idx // per] & 0xFFFFFFFFFFFFFFFF
                            v = (w >> ((idx % per) * bits)) & ((1 << bits) - 1)
                        blocks[(x, y, z)] = pal[v]
                for be in root.get("block_entities", []) or []:
                    bents[(be["x"], be["y"], be["z"])] = be
    return blocks, bents


def raw_block_entities(region_dir, x0, x1, wanted):
    """Block entity compounds as raw (tag, value) trees, so they're written back unchanged."""
    out = {}
    for rx in range(x0 >> 9, (x1 >> 9) + 1):
        for rz in range(Z0 >> 9, (Z1 >> 9) + 1):
            f = Path(region_dir) / f"r.{rx}.{rz}.mca"
            if not f.exists():
                continue
            data = f.read_bytes()
            for k in range(1024):
                off = int.from_bytes(data[k * 4:k * 4 + 3], "big")
                if not off:
                    continue
                p = off * 4096
                ln = struct.unpack(">i", data[p:p + 4])[0]
                r = Reader(zlib.decompress(data[p + 5:p + 4 + ln]))
                r.num("b")
                r.string()
                root = r.payload(COMPOUND)
                if "block_entities" not in root:
                    continue
                et, items = root["block_entities"][1]
                for be in items:
                    pos = (be["x"][1], be["y"][1], be["z"][1])
                    if pos in wanted:
                        out[pos] = {k2: v2 for k2, v2 in be.items() if k2 not in ("x", "y", "z", "keepPacked")}
    return out


def write_structure(path, x0, x1, blocks, bents):
    palette, index, entries = [], {}, []
    for y in range(Y0, Y1 + 1):
        for z in range(Z0, Z1 + 1):
            for x in range(x0, x1 + 1):
                st = blocks.get((x, y, z), ("minecraft:air", ()))
                if st not in index:
                    index[st] = len(palette)
                    pe = {"id": (STRING, st[0])}
                    if st[1]:
                        pe["properties"] = (COMPOUND, {k: (STRING, v) for k, v in st[1]})
                    palette.append(pe)
                e = {"pos": (LIST, (INT, [x - x0, y - Y0, z - Z0])), "state": (INT, index[st])}
                if (x, y, z) in bents:
                    e["nbt"] = (COMPOUND, bents[(x, y, z)])
                entries.append(e)
    root = {
        "size": (LIST, (INT, [x1 - x0 + 1, Y1 - Y0 + 1, Z1 - Z0 + 1])),
        "entities": (LIST, (COMPOUND, [])),
        "blocks": (LIST, (COMPOUND, entries)),
        "palette": (LIST, (COMPOUND, palette)),
        "DataVersion": (INT, DATA_VERSION),
    }
    w = Writer()
    w.num("b", COMPOUND)
    w.string("")
    w.payload(COMPOUND, root)
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_bytes(gzip.compress(bytes(w.out)))
    return len(entries), len(palette), len(bents)


def main(region_dir, out_dir):
    for part, (x0, x1) in PARTS.items():
        blocks, bents_plain = read_chunks(region_dir, x0, x1)
        bents = raw_block_entities(region_dir, x0, x1, set(bents_plain) & set(blocks))
        n, pal, be = write_structure(Path(out_dir) / "hub" / f"{part}.nbt", x0, x1, blocks, bents)
        print(f"hub/{part}: {n} blocks, {pal} states, {be} block entities")


if __name__ == "__main__":
    main(sys.argv[1], sys.argv[2])
