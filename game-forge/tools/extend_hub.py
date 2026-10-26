#!/usr/bin/env python3
"""One-off (2026-10-26, Dave: more NPC spots): stretch the hub's NPC hall 20 blocks east and write the new
east snapshot (x 16..63) for forge:___restore_hub to place.

Reads the hub as it was (x 16..41) from the world's overworld region files, then:
  - the rounded east end (x >= 34 on the north half and centre line, x >= 33 on the south half, where the
    curve starts a block earlier) moves 20 east, sign, glowstone pad, and lanterns included;
  - the gap becomes straight hall copied from the existing pattern: deepslate brick floor at y 62 with
    sea lanterns on the centre line at even x, a polished blackstone brick wall railing at y 63 on
    z -11 / z 11, lanterns on the railing at x 41 and 47;
  - five new NPC pads per side at x 35, 39, 43, 47, 51 (copies of the x 31 pads, signs "Mini Game 4..8"
    on the north side and "Tutorial 4..8" on the south side, "coming soon" underneath).

Run on a copy of the region files, after `save-all flush`:
    python3 extend_hub.py REGION_DIR OUTDIR
then copy OUTDIR/hub/east.nbt into data/forge/structure/hub/. Don't run it twice on an already
stretched hub; take later snapshots with snapshot_hub.py (its east part is x 16..63 since this change).
"""
import copy
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import snapshot_hub as sh  # noqa: E402
from make_void_world import LIST, STRING  # noqa: E402

OLD_X0, OLD_X1 = 16, 41
NEW_X1 = 63
SHIFT = 20
FLOOR, RAIL, TOP = 62, 63, 64
NEW_PADS = [35, 39, 43, 47, 51]
TEMPLATE_PAD = 31
LANTERN_X = [41, 47]

AIR = ("minecraft:air", ())
WALL = "minecraft:polished_blackstone_brick_wall"


def end_start(z):
    return 33 if z > 0 else 34


def wall_x(up):
    return (WALL, (("east", "low"), ("north", "none"), ("south", "none"),
                   ("up", "true" if up else "false"), ("waterlogged", "false"), ("west", "low")))


def main(region_dir, out_dir):
    old, bents_plain = sh.read_chunks(region_dir, OLD_X0, OLD_X1)
    raw = sh.raw_block_entities(region_dir, OLD_X0, OLD_X1, set(bents_plain) & set(old))
    blocks, bents = {}, {}

    for (x, y, z), st in old.items():
        if x >= end_start(z):
            continue
        blocks[(x, y, z)] = st
        if (x, y, z) in raw:
            bents[(x, y, z)] = raw[(x, y, z)]
    for (x, y, z), st in old.items():
        if x >= end_start(z):
            blocks[(x + SHIFT, y, z)] = st
            if (x, y, z) in raw:
                bents[(x + SHIFT, y, z)] = raw[(x, y, z)]

    # straight hall between the old curve start and the moved end
    for z in range(-11, 12):
        for x in range(end_start(z), end_start(z) + SHIFT):
            blocks[(x, FLOOR, z)] = ("minecraft:sea_lantern", ()) if (z == 0 and x % 2 == 0) else ("minecraft:deepslate_bricks", ())
            for y in range(RAIL, sh.Y1 + 1):
                blocks[(x, y, z)] = AIR
            if abs(z) == 11:
                lit = x in LANTERN_X
                blocks[(x, RAIL, z)] = wall_x(lit)
                if lit:
                    blocks[(x, TOP, z)] = ("minecraft:lantern", (("hanging", "false"), ("waterlogged", "false")))
    # the railing piece just west of the hall now runs on east instead of turning the corner
    for z in (-11, 11):
        x = end_start(z) - 1
        st = blocks.get((x, RAIL, z), AIR)
        if st[0] == WALL:
            blocks[(x, RAIL, z)] = wall_x(dict(st[1]).get("up") == "true")

    # new pads: copies of the x 31 pads (glowstone, quartz stairs, sign) with renumbered signs
    pad_cells = [(x, z) for x in range(TEMPLATE_PAD - 1, TEMPLATE_PAD + 2) for z in list(range(-8, -4)) + list(range(5, 9))]
    for i, px in enumerate(NEW_PADS):
        dx = px - TEMPLATE_PAD
        for x, z in pad_cells:
            st = old.get((x, RAIL, z), AIR)
            if st == AIR:
                continue
            blocks[(x + dx, RAIL, z)] = st
            if (x, RAIL, z) in raw:
                be = copy.deepcopy(raw[(x, RAIL, z)])
                label = f"Mini Game {4 + i}" if z < 0 else f"Tutorial {4 + i}"
                be["front_text"][1]["messages"] = (LIST, (STRING, [label, "", "coming soon", ""]))
                bents[(x + dx, RAIL, z)] = be

    n, pal, be = sh.write_structure(Path(out_dir) / "hub" / "east.nbt", OLD_X0, NEW_X1, blocks, bents)
    print(f"hub/east: {n} blocks, {pal} states, {be} block entities (x {OLD_X0}..{NEW_X1})")


if __name__ == "__main__":
    main(sys.argv[1], sys.argv[2])
