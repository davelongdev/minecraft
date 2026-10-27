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
- dialog buttons/forms that run an allowed function (CUSTOM_ACTIONS) become minecraft:custom /
  dynamic/custom actions, which the server-only Dialog Actions mod (mods/dialog-actions/) runs as the
  player: no "Confirm Command Execution" screen, no op needed. Keep the mod's ALLOWED list in step.
"""
import json
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

# (pack, file under data/<ns>/function/ (or data/<ns>/dialog/...), old text, new text) applied after the selector pass
PATCHES = [
    # Command Forge: "everyone else on no team" becomes the Game Forge tutorial team (its sidebar shows
    # the Leaderboard), and the medal teams get the same colour so their sidebar is the Leaderboard too.
    ("commands-tutorial", "internal/rank_teams.mcfunction",
     "team leave @a[distance=0..]",
     "team join forge_tut @a[distance=0..]\n"
     "team modify tut_gold color aqua\nteam modify tut_silver color aqua\nteam modify tut_bronze color aqua"),
    # Command Forge's end (Dave 2026-10-26: no TP TO NEXT ISLAND in Game Forge; section 2 is the Command Blocks NPC):
    # coming back from quest 12's cage finishes Command Forge on the spot (tut_quests 12 -> points, book; not
    # internal/complete, whose section_complete would start section 2 on island 1) and shows a "you finished"
    # screen whose Continue (/trigger forge_cong, no confirmation; Esc off so it can't be skipped) brings the
    # Congratulations title (forge:internal/congrats; a title under an open screen can't be seen). The post's
    # button becomes an ALL QUESTS DONE sign, an old TP button is swapped on sight, and the button handler is gone.
    ("commands-tutorial", "internal/finish_island.mcfunction",
     "playsound minecraft:block.note_block.bell master @s ~7 ~ ~6 1 1.2",
     "execute if score @s tut_quests matches ..11 run scoreboard players set @s tut_quests 12\n"
     "function tut:internal/give_book\n"
     "scoreboard players enable @s forge_cong\n"
     'dialog show @s {type:"minecraft:notice",title:{text:"Congratulations!",color:"gold",bold:true},'
     'external_title:"Congratulations!",pause:false,can_close_with_escape:false,'
     'body:[{type:"minecraft:plain_message",width:300,contents:'
     '"You finished the Commands tutorial - all 12 quests!\\n\\nYou unlocked NPCs, Command Blocks, and your '
     'Personal Workshop.\\n\\nUse your Magic Compass to get back to the hub."}],'
     'action:{label:{text:"Continue",color:"green"},action:{type:"minecraft:run_command",command:"trigger forge_cong"}}}'),
    ("commands-tutorial", "internal/finish_post_rel.mcfunction",
     "setblock ~7 ~1 ~6 stone_button[face=floor,facing=west]\n",
     "setblock ~7 ~1 ~6 air\n"),
    ("commands-tutorial", "internal/finish_post_rel.mcfunction",
     '{"font":"minecraft:uniform","text":"TP TO","color":"gold","bold":true},'
     '{"font":"minecraft:uniform","text":"NEXT ISLAND","color":"gold","bold":true},'
     '{"font":"minecraft:uniform","text":"press the button","color":"white"}',
     '{"font":"minecraft:uniform","text":"ALL QUESTS","color":"gold","bold":true},'
     '{"font":"minecraft:uniform","text":"DONE!","color":"gold","bold":true},'
     '{"font":"minecraft:uniform","text":"Compass = hub","color":"white"}'),
    ("commands-tutorial", "internal/ensure_plot.mcfunction",
     "$execute if score @s tut_end matches 2 positioned $(px) 100 1024 if block ~12 ~-1 ~18 blue_wool run setblock ~12 ~-1 ~18 blue_concrete",
     "$execute if score @s tut_end matches 2 positioned $(px) 100 1024 if block ~12 ~-1 ~18 blue_wool run setblock ~12 ~-1 ~18 blue_concrete\n"
     "# [game-forge] islands finished before 2026-10-26 still have the TP TO NEXT ISLAND button: swap in the done sign\n"
     "$execute if score @s tut_end matches 1.. positioned $(px) 100 0 if block ~7 ~1 ~6 stone_button run function tut:internal/finish_post_rel"),
    ("commands-tutorial", "internal/buttons.mcfunction",
     "$execute positioned $(px) 100 0 if block ~7 ~1 ~6 stone_button[powered=true] unless entity @s[tag=tut_fin] if score @s tut_end matches 1.. run function tut:internal/next_island with storage tut:main args",
     "# [game-forge] no TP TO NEXT ISLAND button (finish_post_rel): section 2 is the Command Blocks NPC"),
]

# JSON-level dialog edits: (pack, file under data/<ns>/dialog/, function(dialog) -> None)
def _quest12_end(d):
    """Quest 12's last line: "Back on your island? / Press the TP TO NEXT ISLAND button..." becomes one line (Dave 2026-10-26)."""
    extra = d["body"][0]["contents"]["extra"]
    i = next(k for k, c in enumerate(extra) if isinstance(c, dict) and c.get("text") == "Back on your island? ")
    extra[i]["text"] = "When you're done, use your Magic Compass to get back to the hub."
    del extra[i + 1:]


DIALOG_EDITS = [
    ("commands-tutorial", "s1/e11/part2.json", _quest12_end),
]


# pack -> function id prefix whose dialog run_command actions become custom actions (Dialog Actions mod)
CUSTOM_ACTIONS = {"npc-game": "npc:internal/"}
STATIC_ACTION = re.compile(
    r'action:\{type:"minecraft:run_command",command:"function ([a-z0-9_.:/-]+)(?: (\{[^}]*\}))?"\}')
DYNAMIC_ACTION = re.compile(
    r'action:\{type:"minecraft:dynamic/run_command",template:"function ([a-z0-9_.:/-]+) \{([^}]*)\}"\}')
PLACEHOLDER_ARG = re.compile(r'^([a-z_]+):\\"\$\(ph_([a-z_]+)\)\\"$')


def custom_actions(text, prefix):
    """run_command "function <prefix>..." buttons -> minecraft:custom with the function as id and its
    arguments as payload; dynamic/run_command form templates -> dynamic/custom, whose payload is the
    inputs (by key) plus the template's other arguments as additions. Inputs are renamed to the
    argument they filled (a form's key "l" feeding label:$(ph_l) becomes key "label")."""
    def static(m):
        fn, args = m.group(1), m.group(2)
        if not fn.startswith(prefix):
            return m.group(0)
        payload = f",payload:{args.replace(chr(92) + chr(34), chr(34))}" if args else ""
        return f'action:{{type:"minecraft:custom",id:"{fn}"{payload}}}'

    renames = []

    def dynamic(m):
        fn, args = m.group(1), m.group(2)
        if not fn.startswith(prefix):
            return m.group(0)
        additions = []
        for arg in args.split(","):
            ph = PLACEHOLDER_ARG.match(arg)
            if ph:
                if ph.group(1) != ph.group(2):
                    renames.append((ph.group(2), ph.group(1)))
            else:
                additions.append(arg.replace(chr(92) + chr(34), chr(34)))
        extra = f",additions:{{{','.join(additions)}}}" if additions else ""
        return f'action:{{type:"minecraft:dynamic/custom",id:"{fn}"{extra}}}'

    text = STATIC_ACTION.sub(static, text)
    text = DYNAMIC_ACTION.sub(dynamic, text)
    for old, new in renames:
        text = text.replace(f'key:"{old}"', f'key:"{new}"')
    return text


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
                    if pack in CUSTOM_ACTIONS:
                        text = custom_actions(text, CUSTOM_ACTIONS[pack])
                target.write_text(text)
            else:
                shutil.copy2(f, target)

        # load/tick: run the original entry points inside the game's dimension
        for kind in ("load", "tick"):
            tag = dst / "data/minecraft/tags/function" / f"{kind}.json"
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
            f = dst / "data" / ns / ("" if rel.startswith("dialog/") else "function") / rel
            text = f.read_text()
            if old not in text:
                raise SystemExit(f"patch for {pack}/{rel} no longer matches: {old!r}")
            f.write_text(text.replace(old, new))

        for p, rel, edit in DIALOG_EDITS:
            if p != pack:
                continue
            f = dst / "data" / ns / "dialog" / rel
            d = json.loads(f.read_text())
            edit(d)
            f.write_text(json.dumps(d, indent=2, ensure_ascii=False) + "\n")

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
