#!/usr/bin/env python3
"""Create a fresh Minecraft world host-side by cloning an existing void save.

Usage:
  python3 tools/make_void_world.py <source-save-dir> <dest-save-dir> <LevelName> [datapack.zip ...]

Copies the source save, drops everything that is world *content* (dimensions/, players/,
advancements/, stats/, data/ except data/minecraft/world_gen_settings.dat, datapacks/,
session.lock, level.dat_old), rewrites level.dat (gzipped NBT) with the new LevelName and an
enabled-datapack list of vanilla + the given zips, and copies the zips into datapacks/.

No third-party libraries: contains a minimal NBT reader/writer.
"""
import gzip
import shutil
import struct
import sys
from pathlib import Path

# ---------------- minimal NBT ----------------
END, BYTE, SHORT, INT, LONG, FLOAT, DOUBLE, BYTE_ARRAY, STRING, LIST, COMPOUND, INT_ARRAY, LONG_ARRAY = range(13)


class Reader:
    def __init__(self, data):
        self.d = data
        self.p = 0

    def take(self, n):
        v = self.d[self.p:self.p + n]
        self.p += n
        return v

    def num(self, fmt):
        size = struct.calcsize(fmt)
        return struct.unpack(">" + fmt, self.take(size))[0]

    def string(self):
        n = self.num("H")
        return self.take(n).decode("utf-8")

    def payload(self, tag):
        if tag == BYTE:
            return self.num("b")
        if tag == SHORT:
            return self.num("h")
        if tag == INT:
            return self.num("i")
        if tag == LONG:
            return self.num("q")
        if tag == FLOAT:
            return self.num("f")
        if tag == DOUBLE:
            return self.num("d")
        if tag == BYTE_ARRAY:
            n = self.num("i")
            return bytearray(self.take(n))
        if tag == STRING:
            return self.string()
        if tag == LIST:
            et = self.num("b")
            n = self.num("i")
            return (et, [self.payload(et) for _ in range(n)])
        if tag == COMPOUND:
            out = {}
            while True:
                t = self.num("b")
                if t == END:
                    return out
                name = self.string()
                out[name] = (t, self.payload(t))
        if tag == INT_ARRAY:
            n = self.num("i")
            return [self.num("i") for _ in range(n)]
        if tag == LONG_ARRAY:
            n = self.num("i")
            return [self.num("q") for _ in range(n)]
        raise ValueError(f"bad tag {tag}")


class Writer:
    def __init__(self):
        self.out = bytearray()

    def num(self, fmt, v):
        self.out += struct.pack(">" + fmt, v)

    def string(self, s):
        b = s.encode("utf-8")
        self.num("H", len(b))
        self.out += b

    def payload(self, tag, v):
        if tag == BYTE:
            self.num("b", v)
        elif tag == SHORT:
            self.num("h", v)
        elif tag == INT:
            self.num("i", v)
        elif tag == LONG:
            self.num("q", v)
        elif tag == FLOAT:
            self.num("f", v)
        elif tag == DOUBLE:
            self.num("d", v)
        elif tag == BYTE_ARRAY:
            self.num("i", len(v))
            self.out += bytes(v)
        elif tag == STRING:
            self.string(v)
        elif tag == LIST:
            et, items = v
            self.num("b", et)
            self.num("i", len(items))
            for it in items:
                self.payload(et, it)
        elif tag == COMPOUND:
            for name, (t, val) in v.items():
                self.num("b", t)
                self.string(name)
                self.payload(t, val)
            self.num("b", END)
        elif tag == INT_ARRAY:
            self.num("i", len(v))
            for x in v:
                self.num("i", x)
        elif tag == LONG_ARRAY:
            self.num("i", len(v))
            for x in v:
                self.num("q", x)
        else:
            raise ValueError(f"bad tag {tag}")


def read_level(path):
    r = Reader(gzip.decompress(path.read_bytes()))
    t = r.num("b")
    assert t == COMPOUND
    name = r.string()
    return name, r.payload(COMPOUND)


def write_level(path, name, root):
    w = Writer()
    w.num("b", COMPOUND)
    w.string(name)
    w.payload(COMPOUND, root)
    path.write_bytes(gzip.compress(bytes(w.out)))


# ---------------- world cloning ----------------
def main(argv):
    if len(argv) < 4:
        print(__doc__)
        return 2
    src, dst, level_name = Path(argv[1]), Path(argv[2]), argv[3]
    zips = [Path(z) for z in argv[4:]]
    if dst.exists():
        print(f"refusing to overwrite existing {dst}")
        return 1
    wgs = src / "data" / "minecraft" / "world_gen_settings.dat"
    if not wgs.exists():
        print(f"source has no {wgs}; is it a 26.x save?")
        return 1

    dst.mkdir(parents=True)
    shutil.copy2(src / "level.dat", dst / "level.dat")
    if (src / "icon.png").exists():
        shutil.copy2(src / "icon.png", dst / "icon.png")
    (dst / "data" / "minecraft").mkdir(parents=True)
    shutil.copy2(wgs, dst / "data" / "minecraft" / "world_gen_settings.dat")
    (dst / "datapacks").mkdir()
    for z in zips:
        shutil.copy2(z, dst / "datapacks" / z.name)

    root_name, root = read_level(dst / "level.dat")
    data = root["Data"][1]
    data["LevelName"] = (STRING, level_name)
    data.pop("Player", None)  # no carried-over singleplayer player
    enabled = ["vanilla"] + [f"file/{z.name}" for z in zips]
    packs = data.setdefault("DataPacks", (COMPOUND, {}))[1]
    packs["Enabled"] = (LIST, (STRING, enabled))
    packs["Disabled"] = (LIST, (STRING, []))
    write_level(dst / "level.dat", root_name, root)

    print(f"created {dst}")
    print(f"  LevelName = {level_name}")
    print(f"  DataPacks.Enabled = {enabled}")
    print("  kept: level.dat, icon.png, data/minecraft/world_gen_settings.dat")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
