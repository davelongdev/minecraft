#!/usr/bin/env python3
"""Make Game Forge copies of the game packs, each confined to its own dimension.

The originals (one per studio server) stay untouched; this writes game-forge/ports/<pack>/
and zips/gf-<pack>.zip. Run from anywhere:  python3 game-forge/tools/port.py

What changes in a copy:
- load/tick tags point at <ns>:gf/load and <ns>:gf/tick, which run the original
  functions "in" the game's dimension, so positions and fills land there.
- every @a/@e/@p/@r/@n selector in a function (outside quoted text) gets distance=0..,
  which limits it to the dimension it runs in, so a game only touches its own players.
- world-wide settings are commented out (gamerule, setworldspawn, the sidebar slot,
  difficulty); the game-forge pack sets one shared set instead.
- the tut:clean dialog font (from the no-moon resource pack) becomes the default font.
- small per-pack PATCHES below.
"""
import pathlib
import re
import shutil
import zipfile

REPO = pathlib.Path(__file__).resolve().parents[2]
OUT = REPO / "game-forge" / "ports"

# pack dir, namespace, dimension, a position inside the game for the tick/load context
PACKS = [
    ("jump-game-2", "jumpgame2", "forge:jump", "-48 63 -16"),
    ("pvp-arena", "arena", "forge:arena", "0 80 33"),
    ("commands-tutorial", "tut", "forge:commands", "0 100 0"),
    ("npc-game", "npc", "forge:npc", "0 65 0"),
    ("one-block_2", "oneblock", "forge:oneblock", "0 65 0"),
]

# (pack, file under data/<ns>/function/, old text, new text) applied after the selector pass
PATCHES = [
    # Command Forge: "everyone else on no team" becomes the Game Forge tutorial team (its sidebar shows
    # the Leaderboard), and the medal teams get the same colour so their sidebar is the Leaderboard too.
    ("commands-tutorial", "internal/rank_teams.mcfunction",
     "team leave @a[distance=0..]",
     "team join forge_tut @a[distance=0..]\n"
     "team modify tut_gold color aqua\nteam modify tut_silver color aqua\nteam modify tut_bronze color aqua"),
]

DROP = re.compile(r"^\$?(gamerule |setworldspawn|scoreboard objectives setdisplay sidebar|difficulty )")
SEL = re.compile(r"@[aeprn](?![A-Za-z0-9_])")


def scope_selectors(line):
    """Add distance=0.. to every selector outside quoted strings."""
    out = []
    i = 0
    quote = None
    while i < len(line):
        c = line[i]
        if quote:
            out.append(c)
            if c == "\\" and i + 1 < len(line):
                out.append(line[i + 1])
                i += 2
                continue
            if c == quote:
                quote = None
            i += 1
            continue
        if c in "\"'":
            quote = c
            out.append(c)
            i += 1
            continue
        m = SEL.match(line, i)
        if not m:
            out.append(c)
            i += 1
            continue
        j = m.end()
        if j < len(line) and line[j] == "[":
            # find the matching ], skipping nested brackets/braces and quoted text
            depth, k, q = 0, j, None
            while k < len(line):
                ch = line[k]
                if q:
                    if ch == "\\":
                        k += 1
                    elif ch == q:
                        q = None
                elif ch in "\"'":
                    q = ch
                elif ch in "[{":
                    depth += 1
                elif ch in "]}":
                    depth -= 1
                    if depth == 0:
                        break
                k += 1
            inner = line[j + 1:k]
            if re.search(r"(^|,)\s*distance\s*=", inner):
                out.append(line[i:k + 1])
            else:
                sep = "," if inner.strip() else ""
                out.append(line[i:j + 1] + "distance=0.." + sep + inner + "]")
            i = k + 1
        else:
            out.append(m.group(0) + "[distance=0..]")
            i = j
    return "".join(out)


def port_function(text):
    lines = []
    for line in text.split("\n"):
        s = line.lstrip()
        if s.startswith("#") or not s:
            lines.append(line)
        elif DROP.match(s):
            lines.append("# [game-forge: set world-wide by the game-forge pack] " + line)
        else:
            lines.append(scope_selectors(line))
    return "\n".join(lines)


def main():
    OUT.mkdir(exist_ok=True)
    for pack, ns, dim, pos in PACKS:
        src = REPO / pack
        dst = OUT / pack
        if dst.exists():
            shutil.rmtree(dst)
        for f in sorted((src / "data").rglob("*")):
            if f.is_dir():
                continue
            rel = f.relative_to(src)
            target = dst / rel
            target.parent.mkdir(parents=True, exist_ok=True)
            if f.suffix in (".mcfunction", ".json"):
                text = f.read_text()
                text = text.replace("tut:clean", "minecraft:default")
                if f.suffix == ".mcfunction":
                    text = port_function(text)
                target.write_text(text)
            else:
                shutil.copy2(f, target)

        # load/tick: run the original entry points inside the game's dimension
        for kind in ("load", "tick"):
            tag = dst / "data/minecraft/tags/function" / f"{kind}.json"
            import json
            values = json.loads((src / "data/minecraft/tags/function" / f"{kind}.json").read_text())["values"]
            wrap = dst / "data" / ns / "function" / "gf" / f"{kind}.mcfunction"
            wrap.parent.mkdir(parents=True, exist_ok=True)
            wrap.write_text(
                f"# GENERATED by game-forge/tools/port.py: the original {kind} functions, run in {dim}.\n"
                + "".join(f"execute in {dim} positioned {pos} run function {v}\n" for v in values))
            tag.write_text(json.dumps({"values": [f"{ns}:gf/{kind}"]}) + "\n")

        for p, rel, old, new in PATCHES:
            if p != pack:
                continue
            f = dst / "data" / ns / "function" / rel
            text = f.read_text()
            if old not in text:
                raise SystemExit(f"patch for {pack}/{rel} no longer matches: {old!r}")
            f.write_text(text.replace(old, new))

        meta = (src / "pack.mcmeta").read_text()
        meta = re.sub(r'("description"\s*:\s*")', r"\1[Game Forge copy] ", meta, count=1)
        (dst / "pack.mcmeta").write_text(meta)

        z = REPO / "zips" / f"gf-{pack}.zip"
        with zipfile.ZipFile(z, "w", zipfile.ZIP_DEFLATED) as zf:
            for f in sorted(dst.rglob("*")):
                if f.is_file():
                    zf.write(f, f.relative_to(dst).as_posix())
        print("wrote", z.relative_to(REPO))


if __name__ == "__main__":
    main()
