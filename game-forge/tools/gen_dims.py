#!/usr/bin/env python3
"""Generate the Game Forge game dimensions: one empty void world per game, each with its own
world clock (so every game keeps its own time of day) and copies of the overworld's day/moon
timelines bound to that clock (so the sky follows it).

Reads the vanilla 26.3 files kept in tools/vanilla/. Run from anywhere:
    python3 game-forge/tools/gen_dims.py
Dimensions are a world-load registry: after changing these, restart the server.
"""
import json
import pathlib

ROOT = pathlib.Path(__file__).resolve().parent.parent
VANILLA = ROOT / "tools" / "vanilla"
DATA = ROOT / "data" / "forge"

GAMES = ["jump", "oneblock", "arena", "commands", "npc"]


def write(rel, obj):
    p = DATA / rel
    p.parent.mkdir(parents=True, exist_ok=True)
    p.write_text(json.dumps(obj, indent=2) + "\n")


overworld = json.loads((VANILLA / "overworld.json").read_text())
for g in GAMES:
    clock = f"forge:{g}"
    write(f"world_clock/{g}.json", {})
    timelines = ["#minecraft:universal"]
    for t in ("day", "moon", "early_game"):
        tl = json.loads((VANILLA / f"{t}.json").read_text())
        tl["clock"] = clock
        write(f"timeline/{g}_{t}.json", tl)
        timelines.append(f"forge:{g}_{t}")
    write(f"tags/timeline/in_{g}.json", {"values": timelines})

    dt = dict(overworld)
    dt["default_clock"] = clock
    dt["timelines"] = f"#forge:in_{g}"
    write(f"dimension_type/{g}.json", dt)

    write(f"dimension/{g}.json", {
        "type": f"forge:{g}",
        "generator": {
            "type": "minecraft:flat",
            "settings": {
                "biome": "minecraft:the_void",
                "features": False,
                "lakes": False,
                "layers": [{"block": "minecraft:air", "height": 1}],
                "structure_overrides": [],
            },
        },
    })
print("wrote", len(GAMES), "dimensions")
