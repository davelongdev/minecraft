#!/usr/bin/env python3
"""Generate the Personal Workshops: one dimension per player, unlocked by finishing Command Forge
section 1 (all 12 quests). The Workshop NPC at the east end of the hub walkway opens forge:workshop/open:
a locked notice, a terrain picker (first visit), or a menu (go to my workshop / visit a workshop).

Dimensions are a world-load registry, so they can't be made while the server runs: every kind of
terrain gets a fixed pool (COUNT each), numbered 1..N in KINDS order as forge:workshop_<n>. A player who
picks a kind gets the next free one of it (score forge_ws = n, permanent; fake players #next_<kind> count
the taken ones). Once kids have workshops, don't change COUNT or reorder KINDS: that renumbers the
dimensions and hands kids someone else's world. New kinds go at the end of KINDS; restart the server after.

In a workshop, its owner is in creative and everyone else in adventure (forge:workshop/tick), so
visitors can look around but can't break or place anything. Players tagged ws_admin are left alone.

Run from anywhere:  python3 game-forge/tools/gen_workshops.py
"""
import json
import pathlib

ROOT = pathlib.Path(__file__).resolve().parent.parent
VANILLA = ROOT / "tools" / "vanilla"
DATA = ROOT / "data" / "forge"
FN = DATA / "function"

COUNT = 6  # workshops per kind

VOID = {"type": "minecraft:flat", "settings": {
    "biome": "minecraft:the_void", "features": False, "lakes": False,
    "layers": [{"block": "minecraft:air", "height": 1}], "structure_overrides": []}}
SUPERFLAT = {"type": "minecraft:flat", "settings": {
    "biome": "minecraft:plains", "features": False, "lakes": False,
    "layers": [{"block": "minecraft:bedrock", "height": 1}, {"block": "minecraft:dirt", "height": 2},
               {"block": "minecraft:grass_block", "height": 1}],
    "structure_overrides": []}}
# vanilla's Tunnelers' Dream preset: 230 layers of stone with ores and mineshafts
DEEP_DIG = {"type": "minecraft:flat", "settings": {
    "biome": "minecraft:windswept_hills", "features": True, "lakes": False,
    "layers": [{"block": "minecraft:bedrock", "height": 1}, {"block": "minecraft:stone", "height": 230},
               {"block": "minecraft:dirt", "height": 5}, {"block": "minecraft:grass_block", "height": 1}],
    "structure_overrides": ["minecraft:mineshafts", "minecraft:strongholds"]}}


def noise(biome=None):
    src = ({"type": "minecraft:fixed", "biome": biome} if biome
           else {"type": "minecraft:multi_noise", "preset": "minecraft:overworld"})
    return {"type": "minecraft:noise", "biome_source": src, "settings": "minecraft:overworld"}


# key, button label, tooltip, generator, spawn: (x, y, z) for flat ones, None = spreadplayers onto the surface
KINDS = [
    ("one_block", "One Block", "Empty sky and a single grass block. Build up from nothing!", VOID, (0.5, 65, 0.5)),
    ("superflat", "Superflat", "Flat grass as far as you can see.", SUPERFLAT, (0.5, -60, 0.5)),
    ("deep_dig", "Deep Dig", "230 blocks of stone full of ores and mineshafts to dig into.", DEEP_DIG, (0.5, 173, 0.5)),
    ("normal", "Normal World", "A regular Minecraft world with hills, forests, and oceans.", noise(), None),
    ("desert", "Desert", "Sand, cactus, and desert temples.", noise("minecraft:desert"), None),
    ("snowy", "Snowy Plains", "Snow and ice everywhere.", noise("minecraft:snowy_plains"), None),
    ("cherry", "Cherry Grove", "Pink cherry trees on the hills.", noise("minecraft:cherry_grove"), None),
]

TITLE = '{text:"Personal Workshop",color:"gold",bold:true}'


def write_json(rel, obj):
    p = DATA / rel
    p.parent.mkdir(parents=True, exist_ok=True)
    p.write_text(json.dumps(obj, indent=2) + "\n")


def write_fn(rel, lines):
    p = FN / (rel + ".mcfunction")
    p.parent.mkdir(parents=True, exist_ok=True)
    p.write_text("\n".join(lines) + "\n")


def s(text):
    return json.dumps(text)


def body(text):
    return f'{{type:"minecraft:plain_message",width:300,contents:{s(text)}}}'


def button(label, value, tooltip=None, color=None):
    lab = f"{{text:{s(label)}" + (f',color:"{color}"' if color else "") + "}"
    tip = f",tooltip:{{text:{s(tooltip)}}}" if tooltip else ""
    return (f"{{label:{lab}{tip},action:{{type:\"minecraft:run_command\","
            f"command:\"trigger workshop set {value}\"}}}}")


def notice(text):
    return (f'dialog show @s {{type:"minecraft:notice",title:{TITLE},external_title:"Personal Workshop",'
            f'pause:false,body:[{body(text)}],action:{{label:"OK"}}}}')


# --- one dimension type and one clock for all of them (the hub's advance_time is off, so it stays noon)
overworld = json.loads((VANILLA / "overworld.json").read_text())
write_json("world_clock/workshop.json", {})
timelines = ["#minecraft:universal"]
for t in ("day", "moon", "early_game"):
    tl = json.loads((VANILLA / f"{t}.json").read_text())
    tl["clock"] = "forge:workshop"
    write_json(f"timeline/workshop_{t}.json", tl)
    timelines.append(f"forge:workshop_{t}")
write_json("tags/timeline/in_workshop.json", {"values": timelines})
dt = dict(overworld)
dt["default_clock"] = "forge:workshop"
dt["timelines"] = "#forge:in_workshop"
write_json("dimension_type/workshop.json", dt)

# --- the pool
pool = []  # (n, kind index)
n = 0
for k, kind in enumerate(KINDS):
    for _ in range(COUNT):
        n += 1
        pool.append((n, k))
        write_json(f"dimension/workshop_{n}.json", {"type": "forge:workshop", "generator": kind[3]})
TOTAL = n

# --- load: objectives and counters
write_fn("workshop/load", [
    "# GENERATED by tools/gen_workshops.py. From forge:internal/load.",
    "# workshop = the dialog buttons (enabled only while one is open); forge_ws = the player's workshop number,",
    "# plus fake players #next_<kind> (how many of that kind are taken) and b<n> (One Block block placed)",
    "scoreboard objectives add workshop trigger",
    "scoreboard objectives add forge_ws dummy",
    *[f"scoreboard players add #next_{kind[0]} forge_ws 0" for kind in KINDS],
    "team add forge_ws",
    "team modify forge_ws color gray",
    "execute unless data storage forge:main workshops run data modify storage forge:main workshops set value []",
])

# --- the NPC click
picker = ",".join(button(kind[1], 101 + k, kind[2]) for k, kind in enumerate(KINDS))
write_fn("workshop/open", [
    "# GENERATED by tools/gen_workshops.py. As the player who clicked the Workshop NPC.",
    "scoreboard players enable @s workshop",
    "execute unless function forge:workshop/unlocked run return run " + notice(
        "Your own world to build anything you like! Friends can visit, but only you can change it.\n\n"
        "Finish all 12 Command Forge quests to unlock it. Talk to Commands to start."),
    "execute if score @s forge_ws matches 1.. run return run dialog show @s "
    f'{{type:"minecraft:multi_action",title:{TITLE},external_title:"Personal Workshop",pause:false,'
    f'after_action:"close",body:[{body("Welcome back!")}],columns:1,actions:['
    + button("Go to my workshop", 1, color="green") + "," + button("Visit a workshop", 2)
    + '],exit_action:{label:"Not now"}}',
    "dialog show @s "
    f'{{type:"minecraft:multi_action",title:{TITLE},external_title:"Personal Workshop",pause:false,'
    f'after_action:"close",body:[{body("You unlocked your own world! Pick the land you want to build on. You can only pick once, so choose carefully.")}],'
    f'columns:2,actions:[{picker}],exit_action:{{label:"Not now"}}}}',
])

write_fn("workshop/unlocked", [
    "# As a player: 1 if they may have a workshop (finished Command Forge section 1, or tagged ws_admin).",
    "execute if entity @s[tag=ws_admin] run return 1",
    "execute if score @s tut_quests matches 12.. run return 1",
    "execute if score @s forge_s1 matches 1 run return 1",
    "return fail",
])

# --- button presses
press = ["# GENERATED by tools/gen_workshops.py. As a player who pressed a workshop dialog button.",
         "execute if score @s workshop matches 1 run function forge:workshop/go_home",
         "execute if score @s workshop matches 2 run function forge:workshop/visit_list"]
for k, kind in enumerate(KINDS):
    press.append(f"execute if score @s workshop matches {101 + k} run function forge:workshop/claim/{kind[0]}")
for n, _ in pool:
    press.append(f"execute if score @s workshop matches {1000 + n} run function forge:workshop/enter/{n}")
press.append("scoreboard players reset @s workshop")
write_fn("workshop/press", press)

# --- claiming one
for k, kind in enumerate(KINDS):
    key, label = kind[0], kind[1]
    base = k * COUNT
    write_fn(f"workshop/claim/{key}", [
        f"# GENERATED by tools/gen_workshops.py. As a player who picked {label}: the next free one of workshops {base + 1}..{base + COUNT}.",
        "execute unless function forge:workshop/unlocked run return fail",
        "execute if score @s forge_ws matches 1.. run return run function forge:workshop/go_home",
        f"execute if score #next_{key} forge_ws matches {COUNT}.. run return run " + notice(
            f"All the {label} workshops are taken. Please pick another kind of land, or ask your teacher to add more."),
        f"scoreboard players operation @s forge_ws = #next_{key} forge_ws",
        f"scoreboard players add @s forge_ws {base + 1}",
        f"scoreboard players add #next_{key} forge_ws 1",
        f"function forge:workshop/record {{kind:{s(label)}}}",
        "function forge:workshop/go_home",
        'tellraw @s ["",{text:"This is your Personal Workshop!",color:"gold"},'
        '{text:" Build anything you like. Friends can visit, but only you can change things here. '
        'The Magic Compass takes you back to the hub.",color:"white"}]',
    ])

write_fn("workshop/record", [
    "# Macro (kind), as a player who just got workshop forge_ws: add {n, v, name, kind} to storage forge:main workshops",
    "# (v = the visit button's trigger value). The name comes from a player head filled in by a loot table.",
    '$data modify storage forge:main ws_new set value {n:0,v:0,name:"",kind:"$(kind)"}',
    "execute store result storage forge:main ws_new.n int 1 run scoreboard players get @s forge_ws",
    "scoreboard players operation #v forge_ws = @s forge_ws",
    "scoreboard players add #v forge_ws 1000",
    "execute store result storage forge:main ws_new.v int 1 run scoreboard players get #v forge_ws",
    "execute at @s run loot spawn ~ ~ ~ loot forge:workshop_head",
    'execute at @s run data modify storage forge:main ws_new.name set from entity @n[type=item,distance=..2,nbt={Item:{id:"minecraft:player_head"}}] Item.components."minecraft:profile".name',
    'execute at @s run kill @e[type=item,distance=..2,nbt={Item:{id:"minecraft:player_head"}}]',
    'execute if data storage forge:main ws_new{name:""} run data modify storage forge:main ws_new.name set value "Someone"',
    "data modify storage forge:main workshops append from storage forge:main ws_new",
])

write_json("loot_table/workshop_head.json", {
    "type": "minecraft:command",
    "pools": [{"rolls": 1, "entries": [{
        "type": "minecraft:item", "name": "minecraft:player_head",
        "modifier": {"type": "minecraft:fill_player_head", "entity": "this"}}]}],
})

# --- going in
go_home = ["# GENERATED by tools/gen_workshops.py. As a player: into their own workshop."]
for n, _ in pool:
    go_home.append(f"execute if score @s forge_ws matches {n} run return run function forge:workshop/enter/{n}")
write_fn("workshop/go_home", go_home)

for n, k in pool:
    kind = KINDS[k]
    spawn = kind[4]
    dim = f"forge:workshop_{n}"
    lines = [f"# GENERATED by tools/gen_workshops.py. As a player: into workshop {n} ({kind[1]}). forge:workshop/tick",
             "# sets the gamemode (creative for its owner, adventure for visitors) on the next tick.",
             "function forge:internal/reset_player"]
    if spawn:
        x, y, z = spawn
        lines.append(f"execute in {dim} run tp @s {x} {y} {z} -90 0")
        if kind[0] == "one_block":
            lines.append("# the block is placed by forge:workshop/tick once the chunk has loaded; float until then")
            lines.append(f"execute unless score b{n} forge_ws matches 1 run effect give @s slow_falling 5 0 true")
    else:
        lines.append(f"execute in {dim} run spreadplayers 0 0 0 1 false @s")
        lines.append(f"execute in {dim} unless entity @s[distance=0..] run tp @s 0.5 120 0.5 -90 0")
    lines.append(f"execute in {dim} at @s run spawnpoint @s ~ ~ ~")
    write_fn(f"workshop/enter/{n}", lines)

# --- visiting
write_fn("workshop/visit_list", [
    "# As a player: a screen with one button per workshop except their own.",
    "data modify storage forge:main ws_pick set value {actions:[]}",
    "data modify storage forge:main ws_work set from storage forge:main workshops",
    "execute if data storage forge:main ws_work[0] run function forge:workshop/visit_loop",
    "scoreboard players enable @s workshop",
    "execute unless data storage forge:main ws_pick.actions[0] run return run " + notice(
        "Nobody else has a workshop yet. Check back later!"),
    "function forge:workshop/visit_show with storage forge:main ws_pick",
])
write_fn("workshop/visit_loop", [
    "function forge:workshop/visit_line with storage forge:main ws_work[0]",
    "data remove storage forge:main ws_work[0]",
    "execute if data storage forge:main ws_work[0] run function forge:workshop/visit_loop",
])
write_fn("workshop/visit_line", [
    "# Macro (n, v, name, kind): one button, skipped for the player's own workshop",
    "$execute unless score @s forge_ws matches $(n) run data modify storage forge:main ws_pick.actions append value "
    '{label:{text:"$(name)\'s workshop"},tooltip:{text:"$(kind)"},action:{type:"minecraft:run_command",command:"trigger workshop set $(v)"}}',
])
write_fn("workshop/visit_show", [
    "# Macro (actions): the list is pasted in as SNBT",
    f'$dialog show @s {{type:"minecraft:multi_action",title:{TITLE},external_title:"Visit a workshop",pause:false,'
    f'after_action:"close",body:[{body("Whose workshop do you want to visit? You can look around, but you can not change anything.")}],'
    'columns:2,actions:$(actions),exit_action:{label:"Not now"}}',
])

# --- every tick
tick = ["# GENERATED by tools/gen_workshops.py. From forge:internal/tick.",
        "execute as @a[scores={workshop=1..}] run function forge:workshop/press",
        "scoreboard players reset @a workshop",
        "# In each workshop: its owner builds (creative), visitors only look (adventure); ws_admin and spectators are left alone"]
for n, k in pool:
    dim = f"forge:workshop_{n}"
    tick += [
        f"execute in {dim} run team join forge_ws @a[distance=0..,team=!forge_ws]",
        f"execute in {dim} run gamemode creative @a[distance=0..,tag=!ws_admin,gamemode=!creative,gamemode=!spectator,scores={{forge_ws={n}}}]",
        f"execute in {dim} as @a[distance=0..,tag=!ws_admin,gamemode=!adventure,gamemode=!spectator] unless score @s forge_ws matches {n} run gamemode adventure @s",
    ]
    if KINDS[k][0] == "one_block":
        tick.append(f"execute unless score b{n} forge_ws matches 1 in {dim} if entity @a[distance=0..] store success score b{n} forge_ws run setblock 0 64 0 grass_block")

write_fn("workshop/tick", tick)
print(f"wrote {TOTAL} workshops ({len(KINDS)} kinds x {COUNT})")
