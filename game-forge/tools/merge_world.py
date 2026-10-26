#!/usr/bin/env python3
"""Merge the game servers' world-wide data into the Game Forge world (server stopped!).

Usage (on the box, as root, Game Forge stopped):
    python3 merge_world.py /srv/mc/game-forge/world jump=/srv/mc/jump-game/world arena=/srv/mc/pvp-arena/world ...

For each <game>=<world>:
- scoreboard.dat: the game's objectives, scores, and teams are added (the game's scores replace existing ones);
  display slots are dropped (the game-forge pack sets per-team sidebars).
- world_clocks.dat: the game's overworld clock becomes clock forge:<game>, so its time of day carries over.
Region files, entities, storage etc. are plain file copies done by the caller.
Needs make_void_world.py (its NBT reader/writer) next to this file.
"""
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from make_void_world import COMPOUND, LIST, LONG, read_level, write_level  # noqa: E402


def main(argv):
    dest = Path(argv[1])
    sources = [a.split("=", 1) for a in argv[2:]]

    sb_path = dest / "data/minecraft/scoreboard.dat"
    sb_name, sb = read_level(sb_path)
    data = sb["data"][1]
    objs = data.setdefault("Objectives", (LIST, (COMPOUND, [])))[1][1]
    scores = data.setdefault("PlayerScores", (LIST, (COMPOUND, [])))[1][1]
    teams = data.setdefault("Teams", (LIST, (COMPOUND, [])))[1][1]
    have_objs = {o["Name"][1] for o in objs}
    have_teams = {t["Name"][1] for t in teams}
    data.pop("DisplaySlots", None)

    clk_path = dest / "data/minecraft/world_clocks.dat"
    clk_name, clk = read_level(clk_path)
    clocks = clk["data"][1]

    for game, world in sources:
        world = Path(world)
        _, src = read_level(world / "data/minecraft/scoreboard.dat")
        sd = src["data"][1]
        # the game's objectives win: an existing one (One Block's, which Game Forge's world started with)
        # loses its old scores and takes the server's
        new = []
        for o in sd.get("Objectives", (LIST, (COMPOUND, [])))[1][1]:
            name = o["Name"][1]
            if name in have_objs:
                scores[:] = [s for s in scores if s["Objective"][1] != name]
            else:
                objs.append(o)
                have_objs.add(name)
            new.append(name)
        added = 0
        for s in sd.get("PlayerScores", (LIST, (COMPOUND, [])))[1][1]:
            if s["Objective"][1] in new:
                scores.append(s)
                added += 1
        for t in sd.get("Teams", (LIST, (COMPOUND, [])))[1][1]:
            if t["Name"][1] not in have_teams:
                teams.append(t)
                have_teams.add(t["Name"][1])
        _, sc = read_level(world / "data/minecraft/world_clocks.dat")
        ticks = sc["data"][1]["minecraft:overworld"][1]["total_ticks"][1]
        clocks[f"forge:{game}"] = (COMPOUND, {"total_ticks": (LONG, ticks)})
        print(f"{game}: {len(new)} objectives, {added} scores, clock {ticks}")

    write_level(sb_path, sb_name, sb)
    write_level(clk_path, clk_name, clk)


if __name__ == "__main__":
    main(sys.argv)
