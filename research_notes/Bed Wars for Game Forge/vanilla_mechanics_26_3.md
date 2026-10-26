# Vanilla mechanics and 26.3 syntax for a Bed Wars data pack (Game Forge)

Scope: mechanics and exact command/JSON syntax for a Bed Wars minigame in a custom dimension of the Game Forge hub world (pack format 121, Minecraft Java 26.3). Researched 2026-10-26.

Verification legend used below:
- **[jar]** = checked in the 26.3 client jar (`~/.var/app/org.prismlauncher.PrismLauncher/data/PrismLauncher/libraries/com/mojang/minecraft/26.3/minecraft-26.3-client.jar`, `version.json` says `data_major 121`, build 2026-09-15) by grepping class strings or reading vanilla data files extracted with bsdtar to `/tmp/bw_jar` (read-only; nothing in the repo or instances was touched).
- **[repo]** = pattern already working in one of our 26.3 packs (playtested per `/home/dave/minecraft/CLAUDE.md`).
- **[wiki]** = minecraft.wiki statement, current page.
- **[unverified]** = from prior knowledge or inference; needs an in-game test before relying on it.

Citation convention: jar facts cite the class or data file path inside the jar as `jar:<path>`, since no URL exists for them; repo facts cite the local file.

## 1. Bed-break detection per team, explosions, and own-bed protection

### Takeaway
Detect a broken bed with a per-tick block check at each team's bed position (`execute unless block <pos> #minecraft:beds`), which catches every cause (players, TNT, fireballs, commands); use the `minecraft.mined:minecraft.<colour>_bed` stat only to name the breaker. Stop a team from breaking its own bed by keeping everyone in adventure mode and giving each team tools whose `can_break` lists only the other teams' bed colours plus the shop blocks.

### Cited Findings
- The block tag `#minecraft:beds` exists in 26.3 and lists all 16 colours (`minecraft:white_bed` … `minecraft:black_bed`) — [jar:data/minecraft/tags/block/beds.json](file:///tmp/bw_jar/data/minecraft/tags/block/beds.json) [jar]
- Scoreboard criteria are parsed as `<stat_type>:<id>` against the `STAT_TYPE` registry (`bySeparator`, `getRegistry`), so `minecraft.mined:minecraft.red_bed` is a valid criterion form — [jar:net/minecraft/world/scores/criteria/ObjectiveCriteria.class](file:///tmp/bw_jar) [jar]
- The Blocks Mined statistic "never increases for a player in Creative Mode" and increases only when the player breaks the block with a tool that would normally make it drop — [Statistics](https://minecraft.wiki/w/Statistics) [wiki]. The page does not say whether adventure-mode breaks (allowed by `can_break`), explosions, or pistons count.
- New in 26.3: a straw bed, "which can be used to sleep through the night without resetting the player's spawn point", controlled by the dimension attribute `minecraft:gameplay/straw_bed_rule` — [Java Edition 26.3](https://minecraft.wiki/w/Java_Edition_26.3) [wiki]; the rule is present in vanilla `dimension_type/overworld.json` — [jar:data/minecraft/dimension_type/overworld.json](file:///tmp/bw_jar/data/minecraft/dimension_type/overworld.json) [jar]. Whether `straw_bed` is in `#minecraft:beds` was not shown in that tag file's 16 entries (it is not listed), so it would not be caught by the tag.
- Dimension types carry `minecraft:gameplay/bed_rule` (`can_set_spawn`, `can_sleep`, optional `destroy_on_use`, `error_message`); The End uses `can_set_spawn:"never", can_sleep:"never", destroy_on_use:true` (that is the "bed explodes" behaviour) — [jar:data/minecraft/dimension_type/the_end.json](file:///tmp/bw_jar/data/minecraft/dimension_type/the_end.json) [jar]. Game Forge's dimension types are copies of the overworld one (`can_set_spawn:"always"`, `can_sleep:"when_dark"`) — [repo: game-forge/data/forge/dimension_type/arena.json](file:///home/dave/minecraft/game-forge/data/forge/dimension_type/arena.json)
- `can_break` "applies in Adventure mode" and takes one block predicate or a list; each predicate has optional `blocks` (id, `#tag`, or list), `state`, `nbt`, `components`, `predicates`. Example: `/give @s netherite_pickaxe[can_break={blocks:['black_concrete','coal_ore']}]` — [Data component format](https://minecraft.wiki/w/Data_component_format) [wiki]; the components `can_break` and `can_place_on` exist in 26.3 — [jar:net/minecraft/core/component/DataComponents.class](file:///tmp/bw_jar) [jar]
- Primed TNT stores `fuse`, `owner` and `explosion_power` — [jar:net/minecraft/world/entity/item/PrimedTnt.class](file:///tmp/bw_jar) [jar]. Damage types `player_explosion` and `explosion` exist — [jar:data/minecraft/damage_type/](file:///tmp/bw_jar/data/minecraft/damage_type) [jar]
- Gamerules in 26.3 include `tnt_explodes`, `mob_griefing`, `tnt_explosion_drop_decay`, `block_explosion_drop_decay`, `mob_explosion_drop_decay`, `projectiles_can_break_blocks` — [jar:net/minecraft/world/level/gamerules/GameRules.class](file:///tmp/bw_jar) [jar]. Game Forge sets `tnt_explodes` and `mob_griefing` to false world-wide — [repo: CLAUDE.md game-forge entry](file:///home/dave/minecraft/CLAUDE.md)

Example (per team, every tick, in the Bed Wars dimension):
```mcfunction
# bed alive flag: 1 while the head block is still a bed
execute in forge:bedwars if score red_bed bw unless block -40 65 0 #minecraft:beds run function forge:bw/bed_broken {team:"red"}
# name the breaker (best effort): whoever's mined stat moved this tick
scoreboard objectives add bw_mined_red minecraft.mined:minecraft.red_bed
execute as @a[distance=0..,scores={bw_mined_red=1..}] run tellraw @a[distance=0..] [{"selector":"@s"}," broke ",{"text":"Red","color":"red"},"'s bed!"]
scoreboard players reset @a bw_mined_red
```
Own-bed protection via the team's tools:
```mcfunction
give @a[team=bw_red] shears[can_break={blocks:["minecraft:blue_bed","minecraft:green_bed","minecraft:yellow_bed","#minecraft:wool","minecraft:end_stone","minecraft:oak_planks"]},unbreakable={}]
```

### Inferences
- A bed is two blocks (head + foot); breaking either removes both, so checking one block per bed is enough.
- Since `tnt_explodes` is false world-wide in Game Forge, TNT would need either a gamerule change (it is world-wide, so it would also affect the other game dimensions) or a fake TNT: let players place a `tnt` block, detect it, replace it with a `tnt` entity or a scripted effect, and simulate damage with `/damage` and block removal with `fill … replace #minecraft:wool` in a radius. The scripted version has the advantage that it can only ever remove shop blocks, never the map or beds, which is simpler for kids.
- If real explosions are enabled, map blocks need high blast resistance (Hypixel-style end stone/obsidian/blast glass); the block check catches a bed blown up by TNT, but nobody gets credited unless you read the TNT's `owner`.
- Using a block check also lets "bed destruction" happen by command at the end-game timer (just `setblock … air`).

### Gaps
- Whether `minecraft.mined` increments for adventure-mode breaks via `can_break` was not verified (the wiki doesn't say). Needs an in-game test; if it doesn't, use the "closest enemy player within 6 blocks" heuristic.
- I did not verify whether TNT respects `explosion_power:0` or whether `tnt_explodes false` stops TNT from priming at all in 26.3.

## 2. Block placement/breaking limits (only player-placed blocks breakable)

### Takeaway
Adventure mode plus item components is the robust vanilla approach: build the map only from block types the shop never sells, give shop blocks a `can_place_on` that lists map + shop blocks (best via a pack block tag), and give tools a `can_break` that lists only shop blocks and enemy beds. Individual placed blocks cannot be tagged in vanilla; separation by block type replaces tagging.

### Cited Findings
- `can_place_on` "controls which blocks the held block item can be placed against in Adventure mode"; example `/give @s target[can_place_on={blocks:'sandstone'}]` — [Data component format](https://minecraft.wiki/w/Data_component_format) [wiki]
- `blocks` in a block predicate accepts a block id, a `#` tag, or a list — [Data component format](https://minecraft.wiki/w/Data_component_format) [wiki]. The components are flattened since 1.21.5 (no `predicates:[…]` wrapper) — [repo: CLAUDE.md "Target version"](file:///home/dave/minecraft/CLAUDE.md)
- Gotcha already hit in this repo: 26.3's `#minecraft:dirt` tag is only dirt/coarse_dirt/rooted_dirt, so NPC Forge's island button couldn't be placed on grass until an explicit list was used — [repo: CLAUDE.md npc-game entry](file:///home/dave/minecraft/CLAUDE.md)
- 26.3 has the tags `#minecraft:wool`, `#minecraft:planks`, `#minecraft:terracotta`, `#minecraft:glazed_terracotta`, and new `wool_slabs`/`wool_stairs` tags — [jar:data/minecraft/tags/block/](file:///tmp/bw_jar/data/minecraft/tags/block) [jar]
- The `placed_block` advancement trigger with a `location` `match_block` condition exists (vanilla `husbandry/plant_seed.json` uses `{"type":"minecraft:match_block","blocks":"minecraft:beetroots"}`) — [jar:data/minecraft/advancement/husbandry/plant_seed.json](file:///tmp/bw_jar/data/minecraft/advancement/husbandry/plant_seed.json) [jar]. `minecraft.used:<block_item>` counts block placements — [Statistics](https://minecraft.wiki/w/Statistics) [wiki]
- NPC Forge already tracks a placement position via a `minecraft.used` stat plus an eye raycast (`anchored eyes positioned ^ ^ ^`, 30 × 0.25 steps) that summons a `marker` — [repo: CLAUDE.md npc-game "Achievement" paragraph](file:///home/dave/minecraft/CLAUDE.md)
- 26.3 added a `minecraft:height_range` block predicate (`min_inclusive`/`max_inclusive` vertical anchors) — [Java Edition 26.3](https://minecraft.wiki/w/Java_Edition_26.3) [wiki]; usable to stop building above a height cap if it is accepted inside `can_place_on`'s `predicates` [unverified].

Example pack tag `data/forge/tags/block/bw_build_on.json` (place against map + shop blocks):
```json
{ "values": ["minecraft:smooth_stone", "minecraft:prismarine_bricks", "minecraft:end_stone", "#minecraft:wool", "minecraft:oak_planks", "minecraft:obsidian", "minecraft:glass"] }
```
```mcfunction
give @s red_wool[can_place_on={blocks:"#forge:bw_build_on"}] 16
give @s stone_pickaxe[can_break={blocks:["#minecraft:wool","minecraft:end_stone","minecraft:oak_planks","minecraft:glass"]},unbreakable={}]
```

### Inferences
- Adventure mode makes bare-hand breaking impossible, so every player must always hold a tool with `can_break` (a starter shears/wooden pickaxe kept on death).
- `can_place_on` is checked against the block clicked, not the target cell, so the tag needs every block a kid might click (including the sides of shop blocks they just placed).
- Survival mode with protection (restoring map blocks each tick, or `fill … replace` on a template) is much heavier and races with players; not recommended.
- A predicate with no fields (`can_place_on={}`) might match every block; that would remove the tag maintenance but is [unverified].
- Shop blocks must be sold with the component already on them (in the trade's `sell` item or the `give` command); blocks picked up from the ground keep their components.

### Gaps
- Whether `predicates`/`minecraft:height_range` can be used inside `can_place_on` was not checked.
- Mining speed in adventure with `can_break` is the normal survival speed [unverified]; end stone and obsidian therefore need real pickaxes.

## 3. Respawn, final kills, killer attribution, void deaths

### Takeaway
Detect deaths with a `deathCount` objective and act once the player is alive again (`@e[type=player,scores={…}]`, as PvP Arena does); turn them into spectators for a 5 s countdown, then teleport them to their team spawn, or mark them eliminated if the bed is gone (final kill). Credit kills with `playerKillCount` / `teamkill.<colour>`, and for void deaths kill the falling player with `/damage … by <attacker>` after finding the attacker with `execute on attacker`, so the normal kill scores and death message attribute the knocker.

### Cited Findings
- Criteria in 26.3: `dummy`, `trigger`, `deathCount`, `playerKillCount`, `totalKillCount`, `health`, `food`, `air`, `armor`, `xp`, `level`, plus per-colour `teamkill.<colour>` and `killedByTeam.<colour>` — [jar:net/minecraft/world/scores/criteria/ObjectiveCriteria.class](file:///tmp/bw_jar) [jar]
- `teamkill.<team_color>`: "Player scores increment when a player kills a member of the given colored team"; `killedByTeam.<team_color>`: "when a player is killed by a member of the given colored team" — [Scoreboard](https://minecraft.wiki/w/Scoreboard) [wiki]
- PvP Arena's working pattern: `arena_deaths deathCount`; `execute as @e[type=player,scores={arena_deaths=1..}] run function …respawned` ("`@e` only selects living entities, so this waits until a dead fighter has pressed Respawn"); void catch with `execute as @a[y=-200,dy=240] …` — [repo: pvp-arena/data/arena/function/internal/tick.mcfunction](file:///home/dave/minecraft/pvp-arena/data/arena/function/internal/tick.mcfunction)
- Gamerule `immediate_respawn` exists (skips the death screen) — [jar:GameRules.class](file:///tmp/bw_jar) [jar]. Game Forge sets `keep_inventory true` and `respawn_radius 0` world-wide — [repo: game-forge/data/forge/function/internal/load.mcfunction](file:///home/dave/minecraft/game-forge/data/forge/function/internal/load.mcfunction)
- `/spawnpoint` records the dimension: its success message is "Set spawn point to %s, %s, %s [%s] in %s for %s" — [jar:assets/minecraft/lang/en_us.json](file:///tmp/bw_jar) [jar]; so `execute in forge:bedwars run spawnpoint @s …` sets a respawn point inside the custom dimension.
- `/execute on` relations in 26.3: `attacker`, `controller`, `leasher`, `origin`, `owner`, `passengers`, `target`, `vehicle` — [jar:net/minecraft/server/commands/ExecuteCommand.class](file:///tmp/bw_jar) [jar]
- Living entities store `last_hurt_by_player` and `last_hurt_by_player_memory_time` (plus `last_hurt_by_mob`, `ticks_since_last_hurt_by_mob`), and the class has `getKillCredit` / `awardKillScore` — [jar:net/minecraft/world/entity/LivingEntity.class](file:///tmp/bw_jar) [jar]
- Damage types `out_of_world`, `generic_kill`, `player_attack` exist — [jar:data/minecraft/damage_type/](file:///tmp/bw_jar/data/minecraft/damage_type) [jar]
- `CombatTracker` builds "fell … assisted" death messages (`death.fell.assist`, `death.fell.finish`, `death.fell.killer`) from the last damage entry's attacker — [jar:net/minecraft/world/damagesource/CombatTracker.class](file:///tmp/bw_jar) [jar]
- Advancement trigger `minecraft:entity_hurt_player` (vanilla `story/deflect_arrow.json`) and `minecraft:entity_killed_player` / `player_killed_entity` exist — [jar:data/minecraft/advancement/](file:///tmp/bw_jar/data/minecraft/advancement) [jar]
- I found no reliable web source describing vanilla kill credit after a knock into the void; searches returned only Skript plugin threads that store the attacker manually — [skUnity forum](https://forums.skunity.com/threads/knocked-into-the-void-by-player.3818/post-12034)

Example flow:
```mcfunction
# load
scoreboard objectives add bw_deaths deathCount
scoreboard objectives add bw_kills playerKillCount {"text":"Kills","color":"gold"}
scoreboard objectives add bw_finals dummy
# tick: void (custom dims copy the overworld, min_y -64; vanilla void damage starts far below)
execute in forge:bedwars as @a[distance=0..,y=-200,dy=230,gamemode=!spectator] run function forge:bw/void
# forge:bw/void (as the falling player)
execute on attacker run tag @s[type=player] add bw_knocker
execute if entity @a[tag=bw_knocker] run damage @s 1000 minecraft:out_of_world by @p[tag=bw_knocker]
execute unless entity @a[tag=bw_knocker] run damage @s 1000 minecraft:out_of_world
tag @a remove bw_knocker
# tick: back alive after death
execute in forge:bedwars as @e[type=player,distance=0..,scores={bw_deaths=1..}] run function forge:bw/respawned
# forge:bw/respawned
scoreboard players reset @s bw_deaths
gamemode spectator @s
tp @s 0 90 0
scoreboard players set @s bw_wait 100
# when bw_wait reaches 0: if the team bed flag is 1 -> tp to team spawn, adventure, kit; else final -> stay spectator
```

### Inferences
- `execute on attacker` uses the victim's last-hurt-by data, which vanilla keeps for a few seconds; that is the window for "knocked off" credit. Exact duration [unverified]; `last_hurt_by_player_memory_time` can be read with `data get entity @s last_hurt_by_player_memory_time` to test it.
- Because `keep_inventory` is on in the whole Game Forge world, Bed Wars must strip resources itself on death (`clear @s iron_ingot`, `gold_ingot`, `diamond`, `emerald`, shop blocks) and can hand them to the killer — closer to Hypixel's "resources go to the killer" than item drops would be.
- A final kill = a death while the victim's team bed flag is 0: run a `bw_finals` increment for the killer (found with `execute on attacker` before the death, or via the `teamkill` delta) at that moment.
- Setting each player's spawnpoint to their team's island at game start removes any need for `respawn_radius` changes; `respawn_radius 0` is already global. The death screen's Respawn button must still be pressed unless `immediate_respawn` is turned on, and that gamerule is world-wide (affects every game in the hub).
- Death messages are already attributed if the kill goes through `/damage … by`, so kids see "X was knocked into the void by Y"-style text without custom tellraw [unverified exact wording for `out_of_world` with an attacker].

### Gaps
- Not verified whether `/damage … by <player>` awards `playerKillCount`/`teamkill` to that player; the `awardKillScore`/`getKillCredit` names suggest kill credit goes through the damage source's entity or the last-hurt-by player, but code paths can't be read from strings alone. Must test in game.
- Not verified that `execute on attacker` returns a player for a player-dealt hit after several seconds of falling.

## 4. Item generators (iron/gold/diamond/emerald)

### Takeaway
Run generators off a scoreboard clock: every N ticks `summon item` (or `loot spawn` from a pack loot table) at a marker entity, skip it when the stack already lying there is at the cap, and store tier and interval per generator on the marker's own scores. Keep generator logic to a handful of markers per tick; that is cheap.

### Cited Findings
- 26.3 item entities save `Age`, `PickupDelay`, `Health`, `Thrower`, `Item`; the class has `INFINITE_LIFETIME` and `INFINITE_PICKUP_DELAY` constants — [jar:net/minecraft/world/entity/item/ItemEntity.class](file:///tmp/bw_jar) [jar]
- Item stacks use lowercase `count` and the `components` map since 1.20.5 (item cost codec fields `id`, `count`, `components`) — [jar:net/minecraft/world/item/trading/ItemCost.class](file:///tmp/bw_jar) [jar]; [Java Edition 1.20.5](https://minecraft.wiki/w/Java_Edition_1.20.5)
- `execute if items` slot names in 26.3 include `contents` (for item entities), `container.*`, `hotbar.*`, `inventory.*`, `weapon.*`, `armor.*`, `enderchest.*`, `player.cursor` — [jar:net/minecraft/world/inventory/SlotRanges.class](file:///tmp/bw_jar) [jar]
- PvP Arena already kills stuck arrows every 5 s with `kill @e[type=arrow,nbt={inGround:1b}]` on a `clock` counter — [repo: pvp-arena tick.mcfunction](file:///home/dave/minecraft/pvp-arena/data/arena/function/internal/tick.mcfunction)

Example (marker tagged `bw_gen`, scores `bw_gt` timer, `bw_gi` interval, `bw_gc` cap):
```mcfunction
execute in forge:bedwars as @e[type=marker,tag=bw_gen,distance=0..] run scoreboard players add @s bw_gt 1
execute in forge:bedwars as @e[type=marker,tag=bw_iron,distance=0..] if score @s bw_gt >= @s bw_gi at @s run function forge:bw/gen_iron
# forge:bw/gen_iron
scoreboard players set @s bw_gt 0
execute store result score #n bw_tmp run data get entity @n[type=item,distance=..1.5] Item.count
execute if score #n bw_tmp >= @s bw_gc run return 0
summon item ~ ~ ~ {Item:{id:"minecraft:iron_ingot",count:1},PickupDelay:0s,Motion:[0.0,0.0,0.0]}
```

### Inferences
- Items merge into one stack on the ground, so reading `Item.count` of the nearest item is a better cap than counting entities; when no item exists, `data get` fails and `#n` keeps its old value, so reset `#n` to 0 first.
- Upgrade tiers (Forge I/II, diamond/emerald generator tiers) are just smaller `bw_gi` values on the marker; a team upgrade sets them with `scoreboard players set @e[tag=bw_iron_red] bw_gi 10`.
- Giving resources straight to players standing on the pad (`give @a[distance=..1.5]`) avoids item entities entirely and splits like Hypixel's team generators; it also dodges merge and despawn issues.
- A pack loot table plus `loot spawn ~ ~ ~ loot forge:bw/gen_iron_t2` keeps the drop amounts in data rather than in functions [syntax from prior knowledge, unverified in 26.3].
- Performance: one marker per generator (roughly 4 teams × 2 + 4 diamond + 4 emerald) and a few `@n`/`distance` checks per tick are negligible next to the piston/fill work PvP Arena already does.

### Gaps
- The exact NBT value that makes items never despawn (`Age:-32768s`) is from prior knowledge; the jar only shows an `INFINITE_LIFETIME` constant. Test before relying on it.

## 5. Shops: villager trades vs dialogs vs chest GUIs

### Takeaway
Villager trades are the most kid-friendly and robust vanilla shop: no op, no confirmation screen, the familiar trading UI, iron/gold/emerald as price items, and outputs can carry `can_place_on`/`can_break`/`dyed_color` components. Use inline `multi_action` dialogs with `/trigger` buttons for things trades can't do (team upgrades, traps, buying for the whole team), which is the pattern Game Forge and NPC Forge already ship. Chest-GUI hacks aren't worth it.

### Cited Findings
- The trade codec in 26.3 has fields `buy`, `buyB` (lenient optional), `sell`, `uses`, `maxUses`, `rewardExp`, `xp`, `priceMultiplier`, `specialPrice`, `demand` — [jar:net/minecraft/world/item/trading/MerchantOffer.class](file:///tmp/bw_jar) [jar]; trade lists are saved under `Offers` with a `Recipes` list — [jar:net/minecraft/world/entity/npc/villager/AbstractVillager.class and trading/MerchantOffers.class](file:///tmp/bw_jar) [jar]
- Trade price items are `{id, count, components}` — [jar:net/minecraft/world/item/trading/ItemCost.class](file:///tmp/bw_jar) [jar]
- 26.3 trades are data-driven: `data/minecraft/villager_trade/<profession>/<level>/*.json` (e.g. `{"gives":{"count":2,"id":"minecraft:emerald"},"max_uses":2,"reputation_discount":0.05,"wants":{"id":"minecraft:water_bucket"}}`) and `data/minecraft/trade_set/<profession>/level_N.json` — [jar:data/minecraft/villager_trade/wandering_trader/water_bucket_emerald.json](file:///tmp/bw_jar/data/minecraft/villager_trade) [jar]. Summoned villagers with explicit `Offers` don't need these.
- NPC Forge already summons trade-less villager bodies in 26.3 with `Offers:{Recipes:[]}`, `VillagerData:{profession:"minecraft:…",level:1,type:"minecraft:plains"}`, `Invulnerable`, `Silent`, and Game Forge's lobby NPCs use `NoAI` — [repo: npc-game/data/npc/function/internal/spawn_entities.mcfunction](file:///home/dave/minecraft/npc-game/data/npc/function/internal/spawn_entities.mcfunction); [repo: CLAUDE.md game-forge entry](file:///home/dave/minecraft/CLAUDE.md)
- Dialog button commands that need op make the 26.3 client show "Confirm Command Execution"; only `/trigger` (permission-free) avoids it (checked in `ClientPacketListener.verifyCommand`) — [repo: CLAUDE.md npc-game entry](file:///home/dave/minecraft/CLAUDE.md)
- Working inline dialog shape in 26.3: `dialog show @s {type:"minecraft:multi_action",title:{…},external_title:"…",pause:false,can_close_with_escape:true,after_action:"close",body:[{type:"minecraft:plain_message",width:300,contents:"…"}],columns:1,actions:[{label:{text:"…",color:"green"},action:{type:"run_command",command:"trigger npc_choice set 101"}}],exit_action:{label:"Bye"}}` — [repo: npc-game show2.mcfunction](file:///home/dave/minecraft/npc-game/data/npc/function/internal/show2.mcfunction)
- Dialog body types in 26.3 are `plain_message` and `item` (ItemBody fields `item`, `description`, `show_decorations`, `show_tooltip`, `width`); inputs are boolean, number range, single option, text — [jar:net/minecraft/server/dialog/body/ItemBody.class](file:///tmp/bw_jar) [jar]
- Dialog JSON files on disk are a world-load registry (need a rejoin, not `/reload`); inline dialogs avoid that — [repo: CLAUDE.md commands-tutorial gotchas](file:///home/dave/minecraft/CLAUDE.md)
- Every map-made dialog shows Minecraft's yellow "custom screen" triangle, which can't be removed — [repo: CLAUDE.md](file:///home/dave/minecraft/CLAUDE.md)

Example shop villager:
```mcfunction
summon villager -38 65 6 {Tags:["bw_shop","bw_shop_red"],NoAI:1b,Invulnerable:1b,Silent:1b,PersistenceRequired:1b,CustomName:{text:"Item Shop",color:"gold"},VillagerData:{profession:"minecraft:armorer",level:5,type:"minecraft:plains"},Offers:{Recipes:[
 {buy:{id:"minecraft:iron_ingot",count:4},sell:{id:"minecraft:red_wool",count:16,components:{"minecraft:can_place_on":{blocks:"#forge:bw_build_on"}}},maxUses:9999,rewardExp:0b,xp:0,priceMultiplier:0.0f},
 {buy:{id:"minecraft:gold_ingot",count:7},sell:{id:"minecraft:iron_sword",count:1,components:{"minecraft:unbreakable":{}}},maxUses:9999,rewardExp:0b}
]}}
```
Upgrade dialog button (permission-free): `action:{type:"run_command",command:"trigger bw_buy set 3"}` → the tick checks `clear @s diamond 0` counts and applies the upgrade.

### Inferences
- Trades are per villager, not per team, so each team island needs its own villager if outputs are team-coloured (red wool, red armour). A shared middle shop would need dialogs instead.
- Villager trade price discounts (`specialPrice`, gossip, Hero of the Village) can move prices; `priceMultiplier:0.0f` and `NoAI` villagers with no gossip should keep them fixed [unverified in play].
- Trades can't take "team" resources or apply upgrades; dialogs + `/trigger` cover those, and the trigger must be enabled per player (NPC Forge enables it only while the screen is open).
- Villager trades don't trigger the confirmation screen at all since they run no command, which makes them the best fit for kids.
- The `xp` field and the `rewardExp` boolean exist; set them so trading doesn't drop XP orbs.

### Gaps
- `rewardExp` type in NBT (byte vs boolean) — codec shows BOOL; `0b`/`false` both should parse in SNBT [unverified].
- Whether `NoAI` villagers still open trades in 26.3 — very likely (Game Forge's lobby villagers are NoAI but use `interaction` boxes, not trades) — needs a test.

## 6. Teams, colours, armour, and keeping gear

### Takeaway
Use `/team` with `color`, `friendlyFire false`, `collisionRule pushOwnTeam`/`never`, `nametagVisibility hideForOtherTeams` (or `always`), and `seeFriendlyInvisibles true`; dye leather armour with `dyed_color=<int>`, and make it unremovable with `enchantments={binding_curse:1}` plus `unbreakable`. Watch the Game Forge collision: the hub already maps team colours to sidebars and re-joins everyone in a game dimension to that game's team every tick.

### Cited Findings
- 26.3 `/team modify` options: `color`, `displayName`, `friendlyFire`, `seeFriendlyInvisibles`, `nametagVisibility` (`always`, `never`, `hideForOtherTeams`, `hideForOwnTeam`), `deathMessageVisibility`, `collisionRule` (`always`, `never`, `pushOtherTeams`, `pushOwnTeam`), `prefix`, `suffix` — [jar:net/minecraft/server/commands/TeamCommand.class](file:///tmp/bw_jar) [jar]. There is no `seeFriendlyNameTags` option; the friendly option is `seeFriendlyInvisibles`.
- Team colour names are lowercase snake_case only since 26.2 — [repo: reports/Teaching Minecraft Java commands.md](file:///home/dave/minecraft/reports/Teaching%20Minecraft%20Java%20commands.md)
- `dyed_color` accepts an int `(R<<16)+(G<<8)+B`, hex `0x7FFF33`, or a list of three floats; example `/give @s leather_helmet[dyed_color=8388403]` — [Data component format](https://minecraft.wiki/w/Data_component_format) [wiki]; component name `dyed_color` present in 26.3 — [jar:DataComponents.class](file:///tmp/bw_jar) [jar]
- `enchantments` is a map `{sharpness:3,knockback:2}` — [Data component format](https://minecraft.wiki/w/Data_component_format) [wiki]
- Components `unbreakable`, `tooltip_display`, `custom_data`, `equippable`, `enchantment_glint_override`, `item_model`, `attribute_modifiers` exist in 26.3 — [jar:DataComponents.class](file:///tmp/bw_jar) [jar]
- Game Forge: `team modify forge_arena color red`, `forge_ob blue`, `forge_jump green`, `forge_tut aqua`, `forge_npc light_purple`, `forge_lobby white`; sidebars via `scoreboard objectives setdisplay sidebar.team.<colour> <objective>`; `forge:internal/tick` runs `execute in forge:<dim> run team join forge_<game> @a[distance=0..,team=!forge_<game>]` every tick — [repo: game-forge load.mcfunction](file:///home/dave/minecraft/game-forge/data/forge/function/internal/load.mcfunction); [repo: game-forge sidebars.mcfunction](file:///home/dave/minecraft/game-forge/data/forge/function/internal/sidebars.mcfunction); [repo: game-forge tick.mcfunction](file:///home/dave/minecraft/game-forge/data/forge/function/internal/tick.mcfunction)
- `sidebar.team.<color>` slots "display only to players who are on teams that use the specified color" — [Scoreboard](https://minecraft.wiki/w/Scoreboard) [wiki]

Example:
```mcfunction
team add bw_red {"text":"Red","color":"red"}
team modify bw_red color dark_red
team modify bw_red friendlyFire false
team modify bw_red collisionRule pushOtherTeams
team modify bw_red nametagVisibility always
team modify bw_red seeFriendlyInvisibles true
item replace entity @s armor.chest with leather_chestplate[dyed_color=16711680,unbreakable={},enchantments={binding_curse:1},tooltip_display={hide_tooltip:false}]
```

### Inferences
- Pick Bed Wars team colours that Game Forge doesn't already use for sidebars, or every red Bed Wars player sees the arena kills sidebar: free colours are `dark_red`, `dark_blue`, `dark_green`, `yellow`, `gold`, `dark_aqua`, `dark_purple`, `gray`, `dark_gray`, `black`. Alternatively give all four Bed Wars teams colours whose sidebar slot shows the Bed Wars objective (e.g. dark_red/dark_blue/dark_green/yellow → each `sidebar.team.<colour>` set to `bw_status`). Armour dye and wool colour are independent of team colour, so "Red team" can be `dark_red` in chat and bright red in wool.
- Game Forge's tick must not force Bed Wars players onto a single `forge_bedwars` team; the dimension needs an exception like `forge:commands` has (Command Forge's own `rank_teams` sets teams there).
- Curse of binding keeps armour on; since `keep_inventory` is world-wide, armour and tools survive deaths anyway, and only resources need clearing.
- Tool tiers that are "lost one level on death" (Hypixel) must be scripted: on respawn `clear` and re-give the lower tier.

### Gaps
- Whether `binding_curse` blocks removing armour in adventure mode as in survival [unverified, believed yes].

## 7. Map reset

### Takeaway
Keep a pristine copy of the map in a second hidden custom dimension and restore it with cross-dimension `clone … from <dim> … to <dim>` in slices under `max_block_modifications` (Game Forge sets 100000), with both areas forceloaded; or ship the map as structure `.nbt` files written offline and `place template` them. Region-file swapping needs the server stopped, so it isn't a between-rounds option.

### Cited Findings
- 26.3 `clone` has a `DimensionAndPosition` type (source and destination dimension), modes including `masked`, `filtered`, `strict`, and is capped by `MAX_BLOCK_MODIFICATIONS`; error "Too many blocks in the specified area (maximum %s, but specified %s)" — [jar:net/minecraft/server/commands/CloneCommands.class](file:///tmp/bw_jar) [jar]; `fill` is capped the same way — [jar:FillCommand.class](file:///tmp/bw_jar) [jar]
- Game Forge sets `gamerule max_block_modifications 100000` — [repo: game-forge load.mcfunction](file:///home/dave/minecraft/game-forge/data/forge/function/internal/load.mcfunction)
- `place template` has `rotation`, `mirror`, `integrity`, `seed`, `strict` arguments and checks loaded chunks (`checkLoaded`) before placing — [jar:net/minecraft/server/commands/PlaceCommand.class](file:///tmp/bw_jar) [jar]
- Structure block maximum size is 48×48×48 in Java (raised from 32 in 1.16/20w16a) — [Structure Block](https://minecraft.wiki/w/Structure_Block) [wiki]
- "A Save-mode block powered by redstone saves only to memory … Memory is cleared when the world is reloaded"; the Save button writes `saves/<world>/generated/<namespace>/structures/<name>.nbt` — [Structure Block](https://minecraft.wiki/w/Structure_Block) [wiki]; Game Forge hit the same issue and writes hub snapshots offline from region files with `tools/snapshot_hub.py` (west/east halves, ≤48 blocks per side) — [repo: game-forge/tools/snapshot_hub.py](file:///home/dave/minecraft/game-forge/tools/snapshot_hub.py)
- `fill` into not-yet-loaded chunks fails silently, and blocks filled into never-lit void chunks can stay black (stale skylight) until re-placed; PvP Arena builds in two passes a second apart for that reason, and it forceloads its area (`forceload add -48 -48 47 47`) — [repo: CLAUDE.md](file:///home/dave/minecraft/CLAUDE.md); [repo: pvp-arena load.mcfunction](file:///home/dave/minecraft/pvp-arena/data/arena/function/internal/load.mcfunction)
- Game Forge's sweep only works when the whole box is loaded; `pause-when-empty-seconds=60` stops all tick functions when nobody is online — [repo: CLAUDE.md](file:///home/dave/minecraft/CLAUDE.md)
- Game Forge already defines void flat dimensions per game with `tools/gen_dims.py` (`generator: minecraft:flat`, biome `the_void`, one air layer) — [repo: game-forge/data/forge/dimension/commands.json](file:///home/dave/minecraft/game-forge/data/forge/dimension/commands.json)

Example (master copy in `forge:bedwars_master`):
```mcfunction
execute in forge:bedwars_master run forceload add -80 -80 79 79
execute in forge:bedwars run forceload add -80 -80 79 79
# 160 x 160 x 40 = 1,024,000 blocks -> ten slices of 16 x 160 x 40 = 102,400 (just over 100000) -> use 15-wide slices
clone from forge:bedwars_master -80 50 -80 -66 89 79 to forge:bedwars -80 50 -80
# ... next slices on following ticks
kill @e[type=item,distance=0..]
```

### Inferences
- The master dimension is the easiest thing for Dave to edit: build the map once in the master dimension (or the PvP Arena Build-style creative server, then copy region files in like the other game copies) and every round clones from it; no structure-size limits and no offline tool.
- Clone slices should be spread over several ticks to avoid a lag spike; `clone` with `replace` also copies block entities (signs, chests), and `strict` avoids neighbour updates.
- Only the play volume needs resetting if players can only place inside it; a reset could also be just "`fill … replace #minecraft:wool` with air + re-set beds", far cheaper, if the map can never be broken (adventure + `can_break` only on shop blocks guarantees that). This is the strongest argument for the adventure approach.
- Forceloading both dimensions all the time costs memory/ticks; forceload only during reset or a game.

### Gaps
- Whether `place template` itself enforces a 48-block limit on larger `.nbt` files written by a tool was not checked; Game Forge stayed within 48 to be safe.
- Exact cost of a 100k-block clone on the studio box not measured.

## 8. Scoreboards and HUD

### Takeaway
One sidebar per team colour via `sidebar.team.<colour>` (fake-player lines like "Red: ✔ / ✘ / 2 left"), a `bossbar` for the phase timer (Diamond II in 2:00, Bed destruction in 5:00), and `title … actionbar` for the respawn countdown. All are standard 26.3 commands; the main constraint is Game Forge's colour-to-sidebar map.

### Cited Findings
- Display slots `sidebar.team.<color>` exist for 16 colours — [Scoreboard](https://minecraft.wiki/w/Scoreboard) [wiki]; used by Game Forge — [repo: game-forge sidebars.mcfunction](file:///home/dave/minecraft/game-forge/data/forge/function/internal/sidebars.mcfunction)
- PvP Arena creates objectives with a display name in SNBT text: `scoreboard objectives add arena_kills playerKillCount {"text":"Kills","color":"gold"}` — [repo: pvp-arena load.mcfunction](file:///home/dave/minecraft/pvp-arena/data/arena/function/internal/load.mcfunction)
- Scoreboard `numberformat` (blank / fixed / styled) has existed since 1.20.3, which lets a sidebar line show text instead of a number — [repo: reports/Teaching Minecraft Java commands.md](file:///home/dave/minecraft/reports/Teaching%20Minecraft%20Java%20commands.md)
- `/stopwatch` and `execute if stopwatch` arrived in 1.21.11; 26.3 has `StopwatchCommand` with `add`, `remove`, `query`, `restart` style strings — [repo: reports/Teaching Minecraft Java commands.md](file:///home/dave/minecraft/reports/Teaching%20Minecraft%20Java%20commands.md); [jar:net/minecraft/server/commands/StopwatchCommand.class](file:///tmp/bw_jar) [jar]
- Gamerule `locator_bar` exists in 26.3 (the HUD bar showing other players' directions) — [jar:GameRules.class](file:///tmp/bw_jar) [jar]

Example:
```mcfunction
scoreboard objectives add bw_status dummy {"text":"BED WARS","color":"yellow","bold":true}
scoreboard players set Red bw_status 4
scoreboard players display name Red bw_status {"text":"Red ✔","color":"red"}
scoreboard players display numberformat Red bw_status blank
scoreboard objectives setdisplay sidebar.team.dark_red bw_status
bossbar add forge:bw_phase "Diamond II in 6:00"
bossbar set forge:bw_phase players @a[team=bw_red]
execute store result bossbar forge:bw_phase value run scoreboard players get #phase_left bw
title @s actionbar {"text":"Respawning in 3...","color":"yellow"}
```

### Inferences
- `bossbar set … players` must use a selector limited to the Bed Wars dimension (`@a[distance=0..]` inside `execute in forge:bedwars`), or hub players see it; Game Forge's port rule already adds `distance=0..` to every selector for this reason.
- The `locator_bar` gamerule is world-wide; turning it off hides enemy positions in Bed Wars but also changes the other games [inference].

### Gaps
- `scoreboard players display name/numberformat` exact 26.3 syntax was not re-checked in the jar (from the 1.20.3 feature); test once.

## 9. Endgame: bed destruction timer, sudden death, dragons, win detection

### Takeaway
Bed destruction and sudden death are just scheduled steps on the phase timer (`setblock` the remaining beds to air with a title). Win = only one team has any non-spectator, not-eliminated player left. Ender dragons can be summoned in a custom dimension and obey `mob_griefing false` for block damage, but their flight AI centres on a fight origin; treat dragons as a test-first stretch goal.

### Cited Findings
- Dimension types have a `has_ender_dragon_fight` boolean (`true` only in `the_end.json`, `false` in Game Forge's copied types) — [jar:data/minecraft/dimension_type/the_end.json](file:///tmp/bw_jar/data/minecraft/dimension_type/the_end.json) [jar]; [repo: game-forge/data/forge/dimension_type/arena.json](file:///home/dave/minecraft/game-forge/data/forge/dimension_type/arena.json)
- The ender dragon saves `DragonPhase` and has `getFightOrigin`/`setFightOrigin`, `getPodiumLocation`, `dragonFight`, and reads `MOB_GRIEFING` — [jar:net/minecraft/world/entity/boss/enderdragon/EnderDragon.class](file:///tmp/bw_jar) [jar]
- Game Forge sets `mob_griefing false` world-wide — [repo: CLAUDE.md game-forge entry](file:///home/dave/minecraft/CLAUDE.md)

Example:
```mcfunction
# win check once a second
execute store result score #alive_red bw_tmp if entity @a[team=bw_red,gamemode=!spectator]
execute store result score #teams_left bw_tmp if score red_alive bw matches 1..
# (sum the four team flags) -> if #teams_left == 1 run function forge:bw/win
# bed destruction at 30:00
execute if score #game_time bw matches 36000 in forge:bedwars run fill -45 64 -5 45 66 5 air replace #minecraft:beds
# sudden death dragon (test first)
execute in forge:bedwars run summon ender_dragon 0 100 0 {DragonPhase:0,Tags:["bw_dragon"]}
```

### Inferences
- Setting `has_ender_dragon_fight:true` on the Bed Wars dimension type would likely make the game create End-fight machinery (exit portal, spikes, gateways) in the arena; leave it false and summon free dragons instead [inference, untested].
- A free-summoned dragon outside a fight probably circles the origin (0,0); centring the map at 0,0 is the safe bet [inference]. Its block-breaking hitbox respects `mob_griefing`, which is already off.
- Hypixel-style "dragons attack only enemies" isn't possible in vanilla; dragons hit everyone. A kid-friendlier sudden death is shrinking a world border-like zone with particles + `/damage`, or turning generators to max — both pure commands. Note `worldborder` in 26.x is per dimension [unverified].
- Win detection needs a "bed gone AND no living member" rule per team; disconnects matter (a player who logs out vanishes from `@a`), so count team members including offline via a per-player `bw_in` score, or treat leavers as eliminated.

### Gaps
- No test of dragon behaviour in a non-End dimension in 26.3 was found or done.
- Whether `/worldborder` is per-dimension in 26.3 was not checked.

## 10. 26.x additions that help

### Takeaway
The useful 26.x pieces are cross-dimension `clone`, `/damage … by` for attributed void kills, `execute on attacker`, inline dialogs with `/trigger`, `/stopwatch`, `/random`, `/compute` (26.3), per-dimension world clocks, and data-driven dimension attributes (bed rules). None of them removes the need for adventure-mode block control.

### Cited Findings
- `/compute <target> integer <int_provider>` and `/compute <target> float <float_provider> [<scale>]`, targets `default`, `block <pos>`, `entity <selector>`; "Evaluates a number provider in various contexts" — [Java Edition 26.3](https://minecraft.wiki/w/Java_Edition_26.3) [wiki]; `ComputeCommand` present — [jar:net/minecraft/server/commands/ComputeCommand.class](file:///tmp/bw_jar) [jar]
- `/posteffect add|remove|clear|list` (client post shaders from resource packs) is new in 26.3 — [Java Edition 26.3](https://minecraft.wiki/w/Java_Edition_26.3) [wiki]
- 26.3 entity data tag `invulnerable_time` makes a mob temporarily invulnerable for a number of ticks — [Java Edition 26.3](https://minecraft.wiki/w/Java_Edition_26.3) [wiki] (useful as spawn protection if it applies to players [unverified]).
- 26.3 gamerules relevant to minigames: `immediate_respawn`, `keep_inventory`, `show_death_messages`, `natural_health_regeneration`, `fall_damage`, `locator_bar`, `spectators_generate_chunks`, `ender_pearls_vanish_on_death`, `max_block_modifications`, `max_command_forks`, `max_command_sequence_length`, `tnt_explodes`, `projectiles_can_break_blocks`, `mob_griefing` — [jar:GameRules.class](file:///tmp/bw_jar) [jar]
- Each Game Forge game dimension has its own `world_clock` (default_clock) so time of day is per game — [repo: CLAUDE.md game-forge entry](file:///home/dave/minecraft/CLAUDE.md)
- Game Forge's `tools/port.py` adds `distance=0..` to every `@a/@e/@p/@r/@n` and comments out `gamerule`/`setworldspawn`/sidebar lines when porting a pack into a dimension — [repo: CLAUDE.md game-forge entry](file:///home/dave/minecraft/CLAUDE.md)

### Inferences
- Because gamerules are world-wide, Bed Wars has to live with Game Forge's settings (keep_inventory on, pvp on, TNT and mob griefing off, fall damage off); any per-game difference must be scripted. In particular `fall_damage false` world-wide removes a classic Bed Wars hazard; it can be faked by watching `fall_distance` [unverified field name] or simply left off for kids.
- Writing Bed Wars natively for Game Forge (a `forge:bedwars` dimension from the start) avoids a port; if it's written as a standalone pack first, write selectors with `distance=0..` already and avoid world-wide gamerules so `port.py` has nothing to strip.

### Gaps
- The full 26.3 changelog (100k+ characters past the first section) was not read; there may be further gamerule or team changes not covered here.
