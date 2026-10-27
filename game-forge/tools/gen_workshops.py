#!/usr/bin/env python3
"""Generate the Personal Workshops: one dimension per player, unlocked by finishing Command Forge
section 1 (all 12 quests). The Workshop NPC at the east end of the hub walkway opens forge:workshop/open:
a locked notice, a terrain picker (first visit), or a menu (go to my workshop / visit a workshop).

Dimensions are a world-load registry, so they can't be made while the server runs: every kind of
terrain gets a fixed pool of COUNT, numbered in blocks of 100 per kind (kind k = forge:workshop_<100(k+1)+i>,
i = 1..COUNT), so COUNT can grow (up to 99) without renumbering anyone's world. Each player may claim up to
MAX_PER_PLAYER (Dave 2026-10-26: 5): picking a kind takes the next free one of it (fake players #next_<kind>
count the taken ones), the owner is recorded as o<n> forge_ws = the player's permanent forge_id, forge_wc counts
their workshops. Never reorder KINDS once kids have workshops; new kinds go at the end. Restart after changes.

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

COUNT = 15  # workshops per kind (block of 100 numbers each, so it can grow to 99)
MAX_PER_PLAYER = 5

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
for k, kind in enumerate(KINDS):
    for i in range(1, COUNT + 1):
        n = 100 * (k + 1) + i
        pool.append((n, k))
        write_json(f"dimension/workshop_{n}.json", {"type": "forge:workshop", "generator": kind[3]})
TOTAL = len(pool)

# --- load: objectives and counters
write_fn("workshop/load", [
    "# GENERATED by tools/gen_workshops.py. From forge:internal/load.",
    "# workshop = the dialog buttons (enabled only while one is open); forge_id = permanent player number (#next_id),",
    "# forge_wc = how many workshops a player has; forge_ws holds fake players: #next_<kind> (taken of that kind),",
    "# o<n> (owner's forge_id of workshop n), b<n> (One Block block placed)",
    "scoreboard objectives add workshop trigger",
    "scoreboard objectives add forge_ws dummy",
    "scoreboard objectives add forge_id dummy",
    "scoreboard objectives add forge_wc dummy",
    "scoreboard players add #next_id forge_id 0",
    *[f"scoreboard players add #next_{kind[0]} forge_ws 0" for kind in KINDS],
    "team add forge_ws",
    "team modify forge_ws color gray",
    "execute unless data storage forge:main workshops run data modify storage forge:main workshops set value []",
])

# --- the NPC click
picker = ",".join(button(kind[1], 101 + k, kind[2]) for k, kind in enumerate(KINDS))


def picker_dialog(text):
    return ("dialog show @s "
            f'{{type:"minecraft:multi_action",title:{TITLE},external_title:"Personal Workshop",pause:false,'
            f'after_action:"close",body:[{body(text)}],'
            f'columns:2,actions:[{picker}],exit_action:{{label:"Not now"}}}}')


write_fn("workshop/open", [
    "# GENERATED by tools/gen_workshops.py. As the player who clicked the Workshop NPC.",
    "scoreboard players enable @s workshop",
    "execute unless function forge:workshop/unlocked run return run " + notice(
        "Your own world to build anything you like! Friends can visit, but only you can change it.\n\n"
        "Finish all 12 Command Forge quests to unlock it. Talk to Commands to start."),
    "execute if score @s forge_wc matches 1.. run return run function forge:workshop/menu",
    picker_dialog(f"You unlocked your own world! Pick the land you want to build on. You can have up to "
                  f"{MAX_PER_PLAYER} workshops, so you can make more later."),
])

write_fn("workshop/picker", [
    "# GENERATED by tools/gen_workshops.py. As a player: choose the land for a new workshop.",
    "scoreboard players enable @s workshop",
    f"execute if score @s forge_wc matches {MAX_PER_PLAYER}.. run return run " + notice(
        f"You already have {MAX_PER_PLAYER} workshops - that's the most you can have."),
    picker_dialog("Pick the land for your new workshop."),
])

write_fn("workshop/menu", [
    "# GENERATED by tools/gen_workshops.py. As a player with at least one workshop: theirs, then new / visit.",
    "data modify storage forge:main ws_pick set value {actions:[]}",
    "data modify storage forge:main ws_work set from storage forge:main workshops",
    "execute if data storage forge:main ws_work[0] run function forge:workshop/mine_loop",
    f"execute unless score @s forge_wc matches {MAX_PER_PLAYER}.. run data modify storage forge:main ws_pick.actions append value "
    + button("Make a new workshop", 3, color="green"),
    "data modify storage forge:main ws_pick.actions append value " + button("Visit a workshop", 2),
    "scoreboard players enable @s workshop",
    "function forge:workshop/menu_show with storage forge:main ws_pick",
])
write_fn("workshop/mine_loop", [
    "function forge:workshop/mine_line with storage forge:main ws_work[0]",
    "data remove storage forge:main ws_work[0]",
    "execute if data storage forge:main ws_work[0] run function forge:workshop/mine_loop",
])
write_fn("workshop/mine_line", [
    "# Macro (n, v, name, kind, owner, c): one button for each of the player's own workshops",
    "$execute if score @s forge_id matches $(owner) run data modify storage forge:main ws_pick.actions append value "
    '{label:{text:"Workshop $(c): $(kind)"},action:{type:"minecraft:run_command",command:"trigger workshop set $(v)"}}',
])
write_fn("workshop/menu_show", [
    "# Macro (actions): the list is pasted in as SNBT",
    f'$dialog show @s {{type:"minecraft:multi_action",title:{TITLE},external_title:"Personal Workshop",pause:false,'
    f'after_action:"close",body:[{body("Welcome back! Which workshop do you want to go to?")}],'
    'columns:1,actions:$(actions),exit_action:{label:"Not now"}}',
])

write_fn("workshop/unlocked", [
    "# As a player: 1 if they may have a workshop (finished Command Forge section 1, or tagged ws_admin).",
    "execute if entity @s[tag=ws_admin] run return 1",
    "execute if score @s tut_quests matches 12.. run return 1",
    "execute if score @s forge_s1 matches 1 run return 1",
    "return fail",
])

# --- button presses
press = ["# GENERATED by tools/gen_workshops.py. As a player who pressed a workshop dialog button. The value is copied and the",
         "# trigger reset first: resetting a trigger also disables it, so it must happen before the next screen enables it again.",
         "scoreboard players operation #w forge_ws = @s workshop",
         "scoreboard players reset @s workshop",
         "execute if score #w forge_ws matches 2 run function forge:workshop/visit_list",
         "execute if score #w forge_ws matches 3 run function forge:workshop/picker"]
for k, kind in enumerate(KINDS):
    press.append(f"execute if score #w forge_ws matches {101 + k} run function forge:workshop/claim/{kind[0]}")
for n, _ in pool:
    press.append(f"execute if score #w forge_ws matches {1000 + n} run function forge:workshop/enter/{n}")
write_fn("workshop/press", press)

# --- claiming one
for k, kind in enumerate(KINDS):
    key, label = kind[0], kind[1]
    base = 100 * (k + 1)
    write_fn(f"workshop/claim/{key}", [
        f"# GENERATED by tools/gen_workshops.py. As a player who picked {label}: the next free one of workshops {base + 1}..{base + COUNT}.",
        "execute unless function forge:workshop/unlocked run return fail",
        f"execute if score @s forge_wc matches {MAX_PER_PLAYER}.. run return run " + notice(
            f"You already have {MAX_PER_PLAYER} workshops - that's the most you can have."),
        f"execute if score #next_{key} forge_ws matches {COUNT}.. run return run " + notice(
            f"All the {label} workshops are taken. Please pick another kind of land, or ask your teacher to add more."),
        "# a permanent player number the first time",
        "execute unless score @s forge_id matches 1.. run scoreboard players add #next_id forge_id 1",
        "execute unless score @s forge_id matches 1.. run scoreboard players operation @s forge_id = #next_id forge_id",
        f"scoreboard players operation #n forge_ws = #next_{key} forge_ws",
        f"scoreboard players add #n forge_ws {base + 1}",
        f"scoreboard players add #next_{key} forge_ws 1",
        "scoreboard players add @s forge_wc 1",
        f"function forge:workshop/record {{kind:{s(label)}}}",
        "function forge:workshop/claim_go with storage forge:main ws_new",
        'tellraw @s ["",{text:"This is your new Personal Workshop!",color:"gold"},'
        '{text:" Build anything you like. Friends can visit, but only you can change things here. '
        'The Magic Compass takes you back to the hub.",color:"white"}]',
    ])

write_fn("workshop/claim_go", [
    "# Macro (n, ...): into the workshop just claimed",
    "$function forge:workshop/enter/$(n)",
])

write_fn("workshop/record", [
    "# Macro (kind), as a player who just claimed workshop #n: owner o<n> = their forge_id, and {n, v, name, kind,",
    "# owner, c} appended to storage forge:main workshops (v = its button's trigger value, c = which of theirs it is).",
    "# The name comes from a player head filled in by a loot table.",
    '$data modify storage forge:main ws_new set value {n:0,v:0,name:"",kind:"$(kind)",owner:0,c:0}',
    "execute store result storage forge:main ws_new.n int 1 run scoreboard players get #n forge_ws",
    "execute store result storage forge:main ws_new.owner int 1 run scoreboard players get @s forge_id",
    "execute store result storage forge:main ws_new.c int 1 run scoreboard players get @s forge_wc",
    "scoreboard players operation #v forge_ws = #n forge_ws",
    "scoreboard players add #v forge_ws 1000",
    "execute store result storage forge:main ws_new.v int 1 run scoreboard players get #v forge_ws",
    "function forge:workshop/set_owner with storage forge:main ws_new",
    "execute at @s run loot spawn ~ ~ ~ loot forge:workshop_head",
    'execute at @s run data modify storage forge:main ws_new.name set from entity @n[type=item,distance=..2,nbt={Item:{id:"minecraft:player_head"}}] Item.components."minecraft:profile".name',
    'execute at @s run kill @e[type=item,distance=..2,nbt={Item:{id:"minecraft:player_head"}}]',
    'execute if data storage forge:main ws_new{name:""} run data modify storage forge:main ws_new.name set value "Someone"',
    "data modify storage forge:main workshops append from storage forge:main ws_new",
])
write_fn("workshop/set_owner", [
    "# Macro (n, ...), as the new owner",
    "$scoreboard players operation o$(n) forge_ws = @s forge_id",
])

write_json("loot_table/workshop_head.json", {
    "type": "minecraft:command",
    "pools": [{"rolls": 1, "entries": [{
        "type": "minecraft:item", "name": "minecraft:player_head",
        "modifier": {"type": "minecraft:fill_player_head", "entity": "this"}}]}],
})

# --- going in
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
    "# As a player: a screen with one button per workshop someone else owns.",
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
    "# Macro (n, v, name, kind, owner, c): one button, skipped for the player's own workshops",
    "$execute unless score @s forge_id matches $(owner) run data modify storage forge:main ws_pick.actions append value "
    '{label:{text:"$(name): $(kind)"},action:{type:"minecraft:run_command",command:"trigger workshop set $(v)"}}',
])
write_fn("workshop/visit_show", [
    "# Macro (actions): the list is pasted in as SNBT",
    f'$dialog show @s {{type:"minecraft:multi_action",title:{TITLE},external_title:"Visit a workshop",pause:false,'
    f'after_action:"close",body:[{body("Whose workshop do you want to visit? You can look around, but you can not change anything.")}],'
    'columns:2,actions:$(actions),exit_action:{label:"Not now"}}',
])

# --- every tick
tick = ["# GENERATED by tools/gen_workshops.py. From forge:internal/tick.",
        "# (no reset of everyone here: that would disable the trigger an open screen just enabled; press resets the presser)",
        "execute as @a[scores={workshop=1..}] run function forge:workshop/press",
        "# In each workshop: its owner builds (creative), visitors only look (adventure); ws_admin and spectators are left alone"]
for n, k in pool:
    dim = f"forge:workshop_{n}"
    tick += [
        f"execute in {dim} run team join forge_ws @a[distance=0..,team=!forge_ws]",
        f"execute in {dim} as @a[distance=0..,tag=!ws_admin,gamemode=!creative,gamemode=!spectator] if score @s forge_id = o{n} forge_ws run gamemode creative @s",
        f"execute in {dim} as @a[distance=0..,tag=!ws_admin,gamemode=!adventure,gamemode=!spectator] unless score @s forge_id = o{n} forge_ws run gamemode adventure @s",
    ]
    if KINDS[k][0] == "one_block":
        tick.append(f"execute unless score b{n} forge_ws matches 1 in {dim} if entity @a[distance=0..] store success score b{n} forge_ws run setblock 0 64 0 grass_block")

write_fn("workshop/tick", tick)
print(f"wrote {TOTAL} workshops ({len(KINDS)} kinds x {COUNT}), up to {MAX_PER_PLAYER} per player")
