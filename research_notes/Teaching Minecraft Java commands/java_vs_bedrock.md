# Java Edition vs Bedrock Edition command systems (teacher's perspective)

Scope: current versions as of the wiki snapshot read on 2026-10-10 (Java 26.3 / Bedrock 26.52 per minecraft.wiki; the project's own packs target Java 26.2). Facts are tagged **[Java]**, **[Bedrock]**, **[Edu]** (Minecraft Education), or **[Both]**. Historical notes are flagged as such.

## KQ1. Which commands exist only in Java, only in Bedrock, or in both (with different syntax/behaviour)?

### Takeaway
Roughly 50 "core" commands are shared by name, but Java has a large exclusive set built around data manipulation (`/data`, `/item`, `/attribute`, `/return`, `/dialog`, `/team`, `/trigger`, `/bossbar`, `/advancement`, ...), while Bedrock's exclusives are mostly presentation/world-control tools (`/camera`, `/dialogue`, `/fog`, `/hud`, `/music`, `/playanimation`, `/structure`, `/tickingarea`, `/titleraw`, `/inputpermission`, `/scriptevent`, `/event`, `/replaceitem`, `/testfor*`). Even shared commands differ in argument order, success-count semantics, and error reporting.

### Cited Findings

**Availability table** (compiled from the wiki's edition-availability tables — [Commands](https://minecraft.wiki/w/Commands)):

| Command | Java | Bedrock | Edu-only | Notes |
|---|---|---|---|---|
| clear, clone, damage, deop, difficulty, effect, enchant, execute, fill, function, gamemode, gamerule, give, help, kick, kill, list, locate, loot, me, msg/tell/w, op, particle, place, playsound, recipe, reload, ride, say, schedule, scoreboard, setblock, setworldspawn, spawnpoint, spreadplayers, stop, stopsound, summon, tag, teleport/tp, tellraw, time, title, transfer, weather, whitelist, xp | Yes | Yes | | Shared "core set" — [Commands](https://minecraft.wiki/w/Commands). Syntax still differs for many (see execute, give, summon, title/titleraw below). |
| advancement, attribute, ban, ban-ip, banlist, bossbar, compute, data, datapack, debug, defaultgamemode, dialog, experience, fetchprofile, fillbiome, forceload, item, jfr, pardon, pardon-ip, perf, posteffect, publish, random, return, rotate, save-all/save-off/save-on, seed, setidletimeout, spectate, stopwatch, swing, team, teammsg/tm, test, tick, trigger, unpublish, version, waypoint, worldborder | Yes | No | | Java-only — [Commands](https://minecraft.wiki/w/Commands). |
| ability, aimassist, alwaysday/daylock, camera, camerashake, changesetting, clearspawnpoint, connect/wsserver, controlscheme, dedicatedwsserver, dialogue, editor-allowlist, event, fog, gametest, gametips, hud, immutableworld, inputpermission, mobevent, music, ops/permission, party, playanimation, project, reloadconfig, reloadpacketlimitconfig, replaceitem, save, script, scriptevent, sendshowstoreoffer, set_movement_authority, setmaxplayers, structure, testfor, testforblock, testforblocks, tickingarea, titleraw, toggledownfall, wb/worldbuilder | No | Yes (Bedrock + Edu) | | Bedrock/Education-only — [Commands](https://minecraft.wiki/w/Commands). `/ability` and `/immutableworld` in Bedrock proper require the "Minecraft Education features" cheat toggle — [Commands/ability](https://minecraft.wiki/w/Commands/ability), [Commands/immutableworld](https://minecraft.wiki/w/Commands/immutableworld). |
| classroommode, code, codebuilder, geteduclientinfo, lesson, spawnitem | No | No | Yes | Education-only — [Commands](https://minecraft.wiki/w/Commands). (The `/immutableworld` wiki page lists `spawnitem` under "Developer" rather than Education — [Commands/immutableworld](https://minecraft.wiki/w/Commands/immutableworld).) |
| agent, closechat, closewebsocket, enableencryption, getchunkdata, getchunks, getlocalplayername, getspawnpoint, gettopsolidblock, globalpause, listd, querytarget | No | Hidden | | Bedrock/Edu "hidden" commands, mostly reachable only via WebSocket servers, NPCs, the Scripting API, or cheats — [Commands](https://minecraft.wiki/w/Commands). |
| detect, executeasself, mixer | — | Removed | | Removed from Bedrock — [Commands](https://minecraft.wiki/w/Commands). |
| achievement, blockdata, stats | Removed | — | | Removed from Java — [Commands](https://minecraft.wiki/w/Commands). |

**Cross-cutting syntax/behaviour differences in shared commands:**
- Notation: Java docs write `<argument name>` and `(a|b)`; Bedrock docs write `name: type` and `<a|b>` — [Commands](https://minecraft.wiki/w/Commands).
- Success count: in Java it is always 0 or 1 except for `/execute`; in Bedrock it is an integer such as the number of players or blocks affected — [Commands](https://minecraft.wiki/w/Commands).
- Java has `success` and `result` values that `/execute store` can save; Bedrock does not — [Commands](https://minecraft.wiki/w/Commands).
- Error messages: Java marks the error position with `<--[HERE]`; Bedrock shows "Unknown command" or "Syntax error" — [Commands](https://minecraft.wiki/w/Commands).
- Aliases differ: Java has `experience`, `teammsg`, `tm`; Bedrock has `allowlist`, `permission`, `ops`, `daylock`, `alwaysday`, and lacks team commands entirely — [Commands](https://minecraft.wiki/w/Commands).
- "Macros" means different things: Bedrock command macros bind commands to hotkeys (up to 10); Java has function macros instead — [Commands](https://minecraft.wiki/w/Commands).
- `/give` **[Java]** `give <targets> <item> [<count>]` where item is `item_id[data_components]`, e.g. `diamond_sword[enchantments={"minecraft:sharpness":10}]`; **[Bedrock]** `give <player: target> <itemName: Item> [amount: int] [data: int] [components: json]`, and the `components` JSON supports only `minecraft:can_place_on`, `minecraft:can_destroy`, `minecraft:item_lock`, `minecraft:keep_on_death` — [Commands/give](https://minecraft.wiki/w/Commands/give). Java data components replaced item NBT in 1.20.5 (24w09a) — [Commands/give](https://minecraft.wiki/w/Commands/give).
- `/summon` **[Java]** `summon <entity> [pos] [nbt]`; **[Bedrock]** `summon <entityType> [spawnPos] [yRot xRot] [spawnEvent] [nameTag]`, a name-tag-first overload, and `facing` overloads; none of the Bedrock overloads accepts NBT — a `spawnEvent` (e.g. `minecraft:spawn_as_patrol_captain`) is used instead — [Commands/summon](https://minecraft.wiki/w/Commands/summon). Microsoft's phrasing: "Instead of using JSON strings to customize entities, you can summon an entity with an event to fire and name it in a single command" — [Microsoft Learn: Differences](https://learn.microsoft.com/en-us/minecraft/creator/documents/differencesbetweenbedrockandjava).
- `/title` vs `/titleraw` **[Bedrock]**: `/title` takes plain text; `/titleraw <player> <title|subtitle|actionbar> <rawtext json>` takes raw JSON text. **[Java]** `/title` takes text components directly (no separate raw command) — [Commands/titleraw](https://minecraft.wiki/w/Commands/titleraw). Microsoft notes `/say`, `/tell`, `/title` do not provide translation support in Bedrock, hence `/tellraw`/`/titleraw` — [Popular Commands](https://learn.microsoft.com/en-us/minecraft/creator/documents/commandspopularcommands).
- `/tp @s ...` "will not work in a command block" **[Bedrock]** — [Popular Commands](https://learn.microsoft.com/en-us/minecraft/creator/documents/commandspopularcommands). (Java's `@s` likewise selects nothing from a command block — [Target selectors](https://minecraft.wiki/w/Target_selectors).)
- `/gamemode` **[Bedrock]** accepts full names, single letters (`s`,`c`,`a`,`d`), or numbers (0,1,2), plus `default` — [Popular Commands](https://learn.microsoft.com/en-us/minecraft/creator/documents/commandspopularcommands).
- `/testfor`, `/testforblock`, `/testforblocks` **[Bedrock]** still exist but "can generally be skipped over in favor of `/execute`" — [Popular Commands](https://learn.microsoft.com/en-us/minecraft/creator/documents/commandspopularcommands). The Bedrock Wiki says the 1.19.50 execute overhaul "replaces commands like /testfor, /testforblock, and /testforblocks" — [Bedrock Wiki: New Execute](https://wiki.bedrock.dev/commands/new-execute).
- `/replaceitem` **[Bedrock]** places items in specific slots of players, other entities, and container blocks — [Popular Commands](https://learn.microsoft.com/en-us/minecraft/creator/documents/commandspopularcommands); Java's equivalent is `/item` (Java-only) — [Commands](https://minecraft.wiki/w/Commands).
- Gamerule naming **[Bedrock]**: `commandblockoutput`, `sendcommandfeedback`, `commandblocksenabled`, `dodaylightcycle`, `doweathercycle` (all lowercase, no underscores) — [Popular Commands](https://learn.microsoft.com/en-us/minecraft/creator/documents/commandspopularcommands). **[Java 26.x]** gamerules are snake_case (`advance_time`, `respawn_radius`) — project CLAUDE.md (local knowledge, not web-sourced); the Command Block wiki page records Java's command-block switch renamed to `command_blocks_work` in 25w44a — [Command Block](https://minecraft.wiki/w/Command_Block).
- Block naming: granite is `stone 1` in Bedrock vs `granite` in Java (some Bedrock blocks grouped by data value) — [Microsoft Learn: Differences](https://learn.microsoft.com/en-us/minecraft/creator/documents/differencesbetweenbedrockandjava). Bedrock packs with `min_engine_version` 1.19.70+ require block states instead of aux values — [Bedrock Wiki: Functions](https://wiki.bedrock.dev/commands/mcfunctions).
- Bedrock functions respect `min_engine_version` for command versioning: a pack set to 1.19.10 runs the older `/fill` behaviour even on newer game versions — [Function (Bedrock Edition)](https://minecraft.wiki/w/Function_(Bedrock_Edition)).

### Inferences
- For a teacher, the "shared core" (`setblock`, `fill`, `clone`, `tp`, `give`, `effect`, `scoreboard`, `tag`, `execute as/at/if`, `tellraw`, `function`) is the transferable curriculum; everything touching entity/item data (NBT, components, `/data`, `/item`) is Java-only and should be flagged as such.
- Bedrock's integer success counts and lack of `store` mean the "chain command blocks reading success" idiom works in both, but the "store result into a scoreboard" idiom is Java-only.

### Gaps
- The wiki Commands page is ~215k characters; I read the first 100k which contained the availability tables. Per-command op-level differences beyond the examples given (`kick` 3 vs 1, `whitelist` 3 vs 4) were not enumerated.
- Bedrock `/schedule` semantics were not fetched; the Bedrock Wiki functions page describes delays via scoreboard timers and does not mention `/schedule` at all — [Bedrock Wiki: Functions](https://wiki.bedrock.dev/commands/mcfunctions). Treat "Bedrock `/schedule` is not a delay command" as unverified.

## KQ2. How do target selectors differ?

### Takeaway
Selector *variables* are nearly identical (`@p @a @r @e @s @n`, plus Bedrock-only `@initiator` and Education-only `@c`/`@v`), but selector *arguments* diverge sharply: Bedrock uses short paired min/max names (`r`/`rm`, `l`/`lm`, `rx`/`rxm`, `ry`/`rym`, `m`, `c`) where Java uses ranged long names (`distance=`, `level=`, `x_rotation=`, `y_rotation=`, `gamemode=`, `limit=`+`sort=`); Java-only arguments are `nbt`, `predicate`, `team`, `advancements`, `sort`, `limit`; Bedrock-only are `hasitem`, `haspermission`, `has_property`, `family`, `c`.

### Cited Findings
All from [Target selectors](https://minecraft.wiki/w/Target_selectors) unless noted.

**Variables**
- `@p` — both; Bedrock selects only living players.
- `@r` — both; Bedrock can pick non-players via `type=`; Java uses `@e[sort=random,limit=1]` or `@n[sort=random]` instead.
- `@a` — both, includes dead players. `@e` — both. `@s` — both; selects nothing from a command block or console.
- `@n` (nearest entity) — Java 1.21+, Bedrock 1.21.100 preview+.
- `@initiator` — Bedrock/Education only: the player who clicked an NPC dialogue button. Microsoft: "NPC Dialogue is the only place the @initiator selector is used" — [Microsoft Learn: NPC Dialogue](https://learn.microsoft.com/en-us/minecraft/creator/documents/npcdialogue).
- `@c` (player's agent) and `@v` (all agents) — Education only.

**Arguments (Java → Bedrock)**
| Concept | Java | Bedrock |
|---|---|---|
| Distance | `@e[distance=8..16]` | `@e[rm=8,r=16]` |
| Vertical rotation | `@e[x_rotation=30..60]` | `@e[rxm=30,rx=60]` |
| Horizontal rotation | `@e[y_rotation=-90..0]` | `@e[rym=-90,ry=0]` |
| XP level | `@a[level=8..16]` | `@a[lm=8,l=16]` |
| Game mode | `@a[gamemode=!spectator]` | `@a[m=!s]` (also `default`, `s/c/a/d`, 0/1/2/5) |
| Count | `@a[limit=3,sort=nearest]`, `@a[limit=4,sort=furthest]` | `@a[c=3]`, `@a[c=-4]` (negative reverses order; not valid with `@r`) |
| Volume | `dx dy dz` (same) | same |
| Scores | `@e[scores={myscore=10..12}]` | same, plus inversion `@e[scores={myscore=!10}]` |
| Tag | `tag=a`, `tag=!a`, `tag=` (none), `tag=!` (any) | same |
| Team | `team=red` | not available |
| Name | `name=Bob`, `name=!Bob` | same |
| Type | `type=creeper`, `type=!creeper`; Java also accepts entity-type tags, forbids `type` with `@a/@p/@r`, allows one positive `type=` | same basic form |
| Entity family | — | `family=skeleton`, `family=mob,family=!monster` |
| Predicate | `predicate=ns:my_predicate` | — |
| NBT | `nbt={OnGround:true}` | — |
| Held/inventory item | — | `hasitem={item=stick,location=slot.weapon.mainhand}` (keys: item, data, quantity, location, slot) |
| Entity property | — | `has_property={minecraft:has_nectar=true}` |
| Advancements | `advancements={story/smelt_iron=true}` | — |
| Input permission | — | `haspermission={camera=enabled,movement=disabled}` |
| Coordinates | `x=0` not center-corrected | use `x=0.0` to avoid center-correction of integers when distance/volume args are absent |

- Java `sort` options: `nearest`, `furthest`, `random`, `arbitrary`; defaults nearest for `@p`, random for `@r`, arbitrary for `@e`/`@a` — [Target selectors](https://minecraft.wiki/w/Target_selectors).
- Ranges: Java supports `..` for distance, level, scores, rotations; Bedrock uses paired min/max arguments except `scores`, which keeps ranges — [Target selectors](https://minecraft.wiki/w/Target_selectors).

### Inferences
- The conceptual model (filter entities by attributes) transfers 1:1; only the spelling changes. A one-page "translation card" (distance→r/rm, limit→c, gamemode→m, level→l/lm, x_rotation→rx/rxm) covers almost all learner friction.
- Java's `nbt=`/`predicate=` have no Bedrock counterpart; Bedrock's `hasitem=` covers the single most common `nbt=` use case (inventory checks) more simply than Java does.

### Gaps
- None material for this question.

## KQ3. How does Bedrock's /execute compare to Java's after the 1.19.50 rewrite?

### Takeaway
Since Bedrock 1.19.50 the `execute` subcommand grammar (`as`, `at`, `in`, `positioned`, `rotated`, `facing`, `align`, `anchored`, `if/unless block|blocks|entity|score`, `run`) is the same shape as Java's, so execute chains teach the same way on both. Bedrock still lacks `store`, `on`, `summon`, `positioned over`, and `if/unless biome|data|dimension|function|items|loaded|predicate|stopwatch`. Pre-1.19.50 tutorials using `execute @e ~ ~ ~ <command>` / `detect` are obsolete.

### Cited Findings
**Subcommand availability** — [Commands/execute](https://minecraft.wiki/w/Commands/execute):

| Subcommand | Java | Bedrock |
|---|---|---|
| align, anchored, as, at, facing, in, rotated, run | Yes | Yes |
| positioned | Yes (incl. `over <heightmap>`) | Yes (no `over`) |
| on | Yes | No |
| summon | Yes | No |
| store result/success | Yes | No |
| if/unless block, blocks, entity, score | Yes | Yes |
| if/unless biome, data, dimension, function, items, loaded, predicate, stopwatch | Yes | No |

- Microsoft's official reference lists exactly: `as`, `at`, `in`, `positioned`, `positioned as`, `rotated`, `rotated as`, `facing`, `facing entity ... <eyes|feet>`, `align`, `anchored <eyes|feet>`, `if/unless block` (with optional block states), `if/unless blocks ... <masked|all>`, `if/unless entity`, `if/unless score` (compare and `matches`), `run` — [Microsoft Learn: execute](https://learn.microsoft.com/en-us/minecraft/creator/commands/commands/execute).
- `in` dimension names: Java takes resource locations (`minecraft:the_nether`); Bedrock accepts only `overworld`, `nether`, `the_end` — [Commands/execute](https://minecraft.wiki/w/Commands/execute), [Microsoft Learn: execute](https://learn.microsoft.com/en-us/minecraft/creator/commands/commands/execute).
- `if score`: Java accepts `*`, UUIDs, any player name; Bedrock requires a player name or selector (quoted UUID for non-player entities). Same comparison operators and `matches` — [Commands/execute](https://minecraft.wiki/w/Commands/execute).
- `if blocks`: both support `all`/`masked` and the 32,768-block limit; Java returns a matching-block count in `result`, Bedrock has no output values because it lacks `store`; Bedrock also accepts floating-point coordinates — [Commands/execute](https://minecraft.wiki/w/Commands/execute).
- `run` may be omitted when the chain ends with `if`/`unless` (Bedrock) — [Bedrock Wiki: New Execute](https://wiki.bedrock.dev/commands/new-execute).
- Known Bedrock bugs: `anchored eyes` offset also affects relative coordinates (MCPE-162681); only one `anchored` per command takes effect (MCPE-165051) — [Bedrock Wiki: New Execute](https://wiki.bedrock.dev/commands/new-execute).

**Old syntax (historical, Bedrock)**
- Forms: `/execute <target> <position> <command>` and `/execute <target> <position> detect <position> <block> <data value> <command>`; "You specified a target to execute as, then the command's context would change to run as that target, and at that target" — executor and position were tied together — [Bedrock Wiki: New Execute](https://wiki.bedrock.dev/commands/new-execute).
- Conversion examples: old `/execute @p ~ ~1.62 ~ teleport @s ^ ^ ^3` → new `/execute as @p at @s positioned ~ ~1.62 ~ run teleport @s ^ ^ ^3`; old `/execute @e[type=sheep] ~ ~ ~ execute @e[type=item,r=5] ~ ~ ~ detect ~ ~-1 ~ stone kill @s` → new `/execute at @e[type=sheep] as @e[type=item,r=5] at @s if block ~ ~-1 ~ stone run kill @s` — [Bedrock Wiki: New Execute](https://wiki.bedrock.dev/commands/new-execute).
- Timeline: new syntax added in Preview 1.19.10.20 "to closer resemble that of Java Edition"; no longer behind the experimental toggle in Preview 1.19.50.23; the `data` argument was removed from `if block` in Preview 1.19.70.21 — [Commands/execute](https://minecraft.wiki/w/Commands/execute). Bedrock 1.19.50 changelog: the updated `/execute` syntax, "more similar to Java Edition", is no longer behind the "Upcoming Creator Features" toggle — [Bedrock Edition 1.19.50](https://minecraft.wiki/w/Bedrock_Edition_1.19.50).
- "Because in 1.19.50, the new execute syntax became mandatory, so you'll need to switch to that" — [r/MinecraftCommands wiki: Common Questions](https://minecraftcommands.github.io/wiki/questions). A feedback post likewise says the new syntax was "made mandatory in 1.19.50" and calls it a breaking change for command-block maps — [feedback.minecraft.net comment](https://feedback.minecraft.net/hc/en-us/community/posts/10402141845645/comments/17941627119117) (user post, not official).
- Behavior-pack functions follow the manifest's `min_engine_version`; "1.19.50 or later uses the newer execute syntax" — [Bedrock Wiki: Functions](https://wiki.bedrock.dev/commands/mcfunctions).
- `/detect` and `/executeasself` are listed among removed Bedrock commands — [Commands](https://minecraft.wiki/w/Commands).
- Microsoft's own docs title the topic "New execute command support in Minecraft version 1.19.70" (search result title) — [Microsoft Learn](https://learn.microsoft.com/en-us/minecraft/creator/documents/commandsnewexecute); the fetched URL redirected to the Popular Commands page so its body was not read. An Education support thread refers to worlds that broke when designed before "1.19.52" — [Education support](https://edusupport.minecraft.net/hc/en-us/community/posts/14989950240788-Issues-with-execute-command).
- Java's modern execute dates from 1.13 (the Microsoft differences page says Bedrock's old structure was "similar to the system used in versions of Java up to 1.13") — [Microsoft Learn: Differences](https://learn.microsoft.com/en-us/minecraft/creator/documents/differencesbetweenbedrockandjava). (Note: that Microsoft page, dated 2025-04-21, still describes Bedrock commands as pre-1.13-Java-like; this is dated relative to the 1.19.50 execute rewrite.)

### Inferences
- In chat / command blocks on current Bedrock, the new syntax is the only one; old-syntax behaviour may still be selectable for legacy behavior packs via `min_engine_version` < 1.19.50 (inferred from the Bedrock Wiki's min_engine_version note). Teachers should treat the old form as "won't work" for learners typing commands.
- Because Bedrock lacks `store`, every "read a value into a scoreboard" exercise (`execute store result score ...`) must be reframed on Bedrock as "use `if score`/`if entity` plus `scoreboard players operation`", or moved to the Script API.
- Microsoft's example `execute as @s positioned as @s if block ~ ~-1 ~ grass run say ...` shows the common Bedrock idiom replacing `detect`.

### Gaps
- Exact official changelog wording about whether the old syntax was "removed" vs "mandatory" was not retrieved (feedback.minecraft.net changelog pages were not fetched; the Microsoft "new execute" doc redirected). Sources conflict mildly on 1.19.50 vs 1.19.52 vs 1.19.70 as the breaking version.

## KQ4. What does Bedrock lack vs Java for data manipulation, and what workarounds do Bedrock mapmakers use?

### Takeaway
Bedrock has no `/data`, no NBT argument on `/give` or `/summon`, no `execute store`, no `nbt=` selector, and only four item components via `/give`/`/replaceitem`. Mapmakers compensate with behavior-pack loot tables + `/loot`, `/structure save`/`load` of pre-made item entities, container cloning tricks, `/replaceitem`, entity spawn events, and increasingly the JavaScript Script API.

### Cited Findings
- `/data` is Java-only; `/item`, `/attribute`, `/execute store` likewise — [Commands](https://minecraft.wiki/w/Commands), [Commands/execute](https://minecraft.wiki/w/Commands/execute).
- Bedrock `/give` and `/replaceitem` "only support four NBT components: can_place_on, can_destroy, keep_on_death, and item_lock"; `can_place_on`/`can_destroy` only affect adventure-mode players; a block given `can_place_on` loses it when broken and picked up — [Bedrock Wiki: Giving NBT Items](https://wiki.bedrock.dev/commands/giving-nbt-items). Wiki confirms the four — [Commands/give](https://minecraft.wiki/w/Commands/give).
- `/give` "only works for basic items. It can't set custom names, enchantments, or other alterations" **[Bedrock]** — [r/MinecraftCommands wiki: Give a special item (Bedrock)](https://minecraftcommands.github.io/wiki/questions/giveitembedrock).
- Bedrock `/summon` has no NBT argument; uses a spawn event and name tag instead — [Commands/summon](https://minecraft.wiki/w/Commands/summon).
- Entity customization in Bedrock is component/event-based rather than JSON/NBT — [Microsoft Learn: Differences](https://learn.microsoft.com/en-us/minecraft/creator/documents/differencesbetweenbedrockandjava).

**Workarounds**
1. Loot tables + `/loot` (called "best current method"): define the item in a behavior-pack loot table; loot-table functions can set amount, data, name, lore, enchantments, book contents, spawn eggs; limitation: not all custom entity data — [r/MinecraftCommands wiki: giveitembedrock](https://minecraftcommands.github.io/wiki/questions/giveitembedrock). Bedrock Wiki's loot item-functions include `specific_enchants` — [Bedrock Wiki: Item Functions](https://wiki.bedrock.dev/loot/item-functions). Caveat from the Bedrock Wiki: "it is currently not possible to set NBT" via loot or trade tables — [Bedrock Wiki: Giving NBT Items](https://wiki.bedrock.dev/commands/giving-nbt-items).
2. `/structure save`/`load`: drop the item, hold it in place with a repeating `tp @e[type=item,c=1] ~~0.5~`, then `/execute at @e[type=item,c=1] run structure save wiki:nbt_item ~~~ ~~~ true disk false`; later `/execute at @p run structure load wiki:nbt_item ~~~`; item appears at the player's feet rather than in inventory — [Bedrock Wiki: Giving NBT Items](https://wiki.bedrock.dev/commands/giving-nbt-items). Add-ons can ship the structure in `bp/structures/`; include a structure void block or the air can replace the block under the player — [r/MinecraftCommands wiki: giveitembedrock](https://minecraftcommands.github.io/wiki/questions/giveitembedrock).
3. Named shulker boxes with `/loot ... mine <xyz>`: keep the prepared box loaded with a ticking area; `/loot give @p mine <xyz>`, `/loot replace entity @p slot.hotbar 0 mine <xyz>` — [Bedrock Wiki: Giving NBT Items](https://wiki.bedrock.dev/commands/giving-nbt-items).
4. Physical chest cloning + `/setblock` destroy + `tp` items to player; or a structure block in load mode pulsed by a redstone block (no pickup delay, but loading takes a tick or two) — [r/MinecraftCommands wiki: giveitembedrock](https://minecraftcommands.github.io/wiki/questions/giveitembedrock).
5. `/replaceitem entity @p slot.hotbar 0 diamond_sword 1 0 {"minecraft:item_lock":{"mode":"lock_in_inventory"}}` for the four supported components — [Bedrock Wiki: Giving NBT Items](https://wiki.bedrock.dev/commands/giving-nbt-items).
6. Script API add-ons (e.g. "Item Editor MCBE") that edit item properties in-game — [Bedrock Wiki: Giving NBT Items](https://wiki.bedrock.dev/commands/giving-nbt-items). The Script API's `ItemStack`, inventory container `addItem`, `world.scoreboard`, `runCommand` are shown in Microsoft's tutorial — [Microsoft Learn: Scripting with TypeScript](https://learn.microsoft.com/en-us/minecraft/creator/documents/scripting/next-steps).
- Player sentiment: a feedback post says Java's command system lets you create unbreakable items, items with unobtainable enchantments, and other custom items, while "in Bedrock Edition, you can't do any of that in-game" — [feedback.minecraft.net: Better Bedrock Commands](https://feedback.minecraft.net/hc/en-us/community/posts/47899304003725-Better-Bedrock-Commands) (search snippet; page returned 403 on fetch).
- Even the Bedrock `/fog` stack is stored in NBT that commands can't fully reach: if you lose a `userProvidedId`, "only an NBT editor can remove the entry" — [Commands/fog](https://minecraft.wiki/w/Commands/fog).

### Inferences
- Teaching "data as a first-class thing you read and write" (NBT paths, `/data get`, `execute store`) is only possible on Java. On Bedrock the equivalent lesson is "data lives in scoreboards and tags; richer data lives in JSON files in a behavior pack or in JavaScript".
- Bedrock's lack of inventory-direct NBT gives (items spawn at feet) is a practical gotcha for classroom demos.

### Gaps
- No single authoritative Microsoft statement "Bedrock has no NBT access via commands" was found; the conclusion rests on the command references (no NBT arguments) plus community wikis.

## KQ5. How do Bedrock's NPC entity and /dialogue system work, and what is the Java equivalent?

### Takeaway
Bedrock's NPC is a built-in, invulnerable, non-moving villager-like entity with an in-game editor (name, 60 skins, 256-char dialogue, up to 6 command/URL buttons) and `@initiator` for per-player commands; behavior packs add branching scenes via `dialogue/*.json` driven by `/dialogue open|change`. Java has nothing built in; the closest is the 1.21.6 `/dialog` system (datapack JSON dialogs with buttons running commands) combined with interaction entities, or the Mannequin entity the wiki points to.

### Cited Findings
**NPC entity [Bedrock/Edu]** — [NPC](https://minecraft.wiki/w/NPC):
- Exclusive to Bedrock and Education; does not spawn naturally. Obtain with `/give @s spawn_egg 1 51` or `/summon npc`; spawning requires Worldbuilder permission (Creative grants it; `/worldbuilder` grants it).
- No AI, cannot move, invulnerable, turns to face players; Creative-mode attacks make it disappear.
- Editor: name up to 32 chars (default yellow `§e`), dialogue up to 256 chars, 60 skins (35 in Edu), Advanced settings with up to 6 URL/command entries used as buttons; commands up to 1024 chars; a direct command runs after the dialogue closes; button mode shows a labelled button that only runs when the player lacks Worldbuilder permission; URL buttons are Education-only (16-char labels).
- `@initiator` targets the player who interacted with the NPC.

**/dialogue [Bedrock/Edu]** — [Commands/dialogue](https://minecraft.wiki/w/Commands/dialogue):
- Added Bedrock 1.17.10 (beta 1.17.10.22), Education 1.17.30; permission level 1, cheats required.
- `dialogue open <npc> <player> [sceneName]` opens the NPC's dialogue for the player as if clicked; without a scene, the last dialogue shown is used.
- `dialogue change <npc> <sceneName> [player]` changes the NPC's dialogue/commands/name to the scene; closes any open box; takes effect on next interaction; applies to all players if none targeted.
- `npc` must resolve to exactly one entity with `minecraft:npc`; fails if scene name doesn't match a `scene_tag` in a behavior pack.

**Scene JSON** — [Microsoft Learn: NPC Dialogue](https://learn.microsoft.com/en-us/minecraft/creator/documents/npcdialogue):
- File at `<behavior pack>/dialogue/scene.json` (any number of files; all read). Format:
  `{"format_version":"1.17","minecraft:npc_dialogue":{"scenes":[{"scene_tag":"ducky_intro","npc_name":"Ducky","text":"Hello new friend","on_open_commands":["/clear @p"],"on_close_commands":["/say Farewell! "],"buttons":[{"name":"Take Gold?","commands":["/give @initiator gold_ingot"]},{"name":"Wish Luck","commands":["/say Good luck!"]}]}]}}`
- Properties: `scene_tag` (required), `npc_name` and `text` (string or rawtext, optional), `on_open_commands`, `on_close_commands`, `buttons` (`name`, `commands`).
- `/dialogue open` can be used as a "pop-up window" from a hidden NPC (must be in a loaded chunk within ticking distance); branching trees are built by putting `/dialogue open` inside a scene's button commands.
- Example invocation: `/dialogue open @e[type=npc, r=2] @p ducky_intro`; tag NPCs with `/tag` to target them.
- Microsoft's doc does not say which entity executes button commands (the wiki NPC page explicitly notes the same gap).

**Java** — [NPC](https://minecraft.wiki/w/NPC): NPCs are not part of Java Edition; the wiki points to the Mannequin ("a fake player") as the nearest equivalent. [Commands/dialog](https://minecraft.wiki/w/Commands/dialog): Java-only `/dialog`, added 1.21.6 (25w20a), permission 2, cheats; `dialog show <targets> <dialog>` (inline SNBT or `minecraft:dialog` registry entry from a datapack, e.g. `data/custom/dialog/example/test.json`), `dialog clear <targets>`; types mentioned: `notice`, `confirmation`, built-ins `minecraft:server_links`, `minecraft:custom_options`, `minecraft:quick_actions`; a confirmation "yes" button can use a `run_command` action. Java text components have a `show_dialog` click action — [Raw JSON text format](https://minecraft.wiki/w/Raw_JSON_text_format).

### Inferences
- The closest Java recreation of "click an NPC, get a dialog with buttons that run commands for *that* player" is: an interaction entity (or any entity) detected via advancement/`execute on`, then `dialog show @s <dialog>` whose buttons `run_command`. The `@initiator` role is played by `@s` inside a `/dialog` button action (the dialog is per-player). This is an inference; no fetched source states it.

### Gaps
- Who executes NPC button commands in Bedrock (the NPC? the player? server at NPC position?) is not stated by either the wiki or Microsoft doc.
- The r/MinecraftCommands "Set up dialogues for NPCs" FAQ page could not be fetched (guessed URL 404).
- Java `/dialog` `multi_action`/`dialog_list` types and input elements (text, number range, boolean, single_option) were not confirmed by the fetched page.

## KQ6. How does the JSON text format differ?

### Takeaway
Bedrock's `rawtext` is a flat array of `text` / `translate`(+`with`) / `score` / `selector` pieces with no color keys, no click or hover events, and is only consumed by `/tellraw` and `/titleraw` (styling via `§` codes in strings). Java text components (SNBT since 1.21.5) support `text`, `translatable`, `score`, `selector`, `keybind`, `nbt`, `object`, full formatting keys, `insertion`, `click_event`, `hover_event`, and are accepted by many commands and datapack files.

### Cited Findings
All from [Raw JSON text format](https://minecraft.wiki/w/Raw_JSON_text_format) unless noted.
- **[Bedrock]** JSON (not SNBT); root object holds a `rawtext` array; entries are appended in order.
- **[Bedrock]** Supported content tags: `text`, `translate` (optional `with`: array or nested rawtext), `score` (`name`, `objective`), `selector`. `score`/`selector` need server-side resolution.
- **[Bedrock]** "String formatting is still possible, but not using the text component format used in Java Edition" — colour/style come from formatting codes (`§`). Example from the titleraw page: `/titleraw @a title {"rawtext": [{"translate":"§lChapter %%s","with":["I"]}]}` — [Commands/titleraw](https://minecraft.wiki/w/Commands/titleraw).
- **[Bedrock]** The Bedrock section documents no `color`, `bold`, `click_event`, `hover_event`, `font`, `nbt`, `keybind`, `object` keys (the page does not explicitly say "unsupported", but none are documented).
- **[Bedrock]** Commands: `/tellraw`; `/titleraw` (in a footnote). Microsoft example: `/tellraw @a {"rawtext":[{"translate":"commands.testfor.success","with":["PlayerName"]}]}` — [Popular Commands](https://learn.microsoft.com/en-us/minecraft/creator/documents/commandspopularcommands). NPC scene `text`/`npc_name` also accept rawtext — [Microsoft Learn: NPC Dialogue](https://learn.microsoft.com/en-us/minecraft/creator/documents/npcdialogue).
- **[Java]** SNBT; root can be a string, list (later items become `extra`), or object. Content types `text`, `translatable`, `score`, `selector`, `keybind`, `nbt`, `object`; type inferred from tags if `type` missing.
- **[Java]** Formatting: `color` (named or `#hex`), `font`, `bold`, `italic`, `underlined`, `strikethrough`, `obfuscated`, `shadow_color`.
- **[Java]** Interactivity: `insertion`, `click_event` (`open_url`, `open_file`, `run_command`, `suggest_command`, `change_page`, `copy_to_clipboard`, `show_dialog`, `custom`), `hover_event` (`show_text`, `show_item`, `show_entity`).
- **[Java]** 1.21.5: components stored as NBT, passed as SNBT; `clickEvent`→`click_event`, `hoverEvent`→`hover_event`; `value`→`url`/`path`/`command`; `show_entity` `id`→`uuid`, `type`→`id`; `show_text` `contents`→`text`→`value` (25w03a). `/title` text components changed JSON→SNBT in 25w02a — [Commands/titleraw](https://minecraft.wiki/w/Commands/titleraw).
- **[Java]** Translation slots use `%s` / `%n$s`; **[Bedrock]** uses numbered `%%1`, `%%2` arguments.

### Inferences
- Clickable chat menus (the `click_event`/`run_command` pattern used in this project's `one-block_2` pack) have no Bedrock equivalent in chat; the Bedrock idiom for "clickable options" is the NPC dialogue buttons or Script API `@minecraft/server-ui` forms.
- Teach `§` colour codes on Bedrock, JSON/SNBT `color` keys on Java; the "translate with arguments" concept transfers.

### Gaps
- Whether Bedrock rawtext silently ignores or rejects unknown keys (e.g. `color`) was not confirmed.

## KQ7. How does the scripting ecosystem differ (datapacks vs behavior packs / Script API)? Does Bedrock have macros or /return?

### Takeaway
Java datapacks offer functions with `#load`/`#tick` tags, function macros (`$(var)`, 1.20.2), `/return` (1.20.3), predicates, loot tables, advancements, dialogs, and `/execute store` — a fully command-based "programming" stack. Bedrock behavior packs offer `.mcfunction` files (no macros, no `/return`, no conditionals except via `execute`), a `tick.json` list, loot/trade tables, entity/item/block JSON, dialogue scenes, structures, and a real JavaScript/TypeScript Script API (`@minecraft/server` etc.) with `/scriptevent` as the command→script bridge. Microsoft describes behavior packs as "equivalent to Java's data packs" but with "significant" differences.

### Cited Findings
**Java functions** — [Function (Java Edition)](https://minecraft.wiki/w/Function_(Java_Edition)):
- `.mcfunction` in `data/<namespace>/function/` (folder was `functions` before 1.21). Run via `/function`, `/execute if|unless function`, function tags `minecraft:load` (world load / reload; runs before players join) and `minecraft:tick`, advancement rewards, `/schedule`, enchantment `run_function` effects.
- `/function` can pass an NBT compound: `function foo:bar {key_1:"Example String", key_2:10}` or `with entity @s SelectedItem`.
- Macros (1.20.2): lines starting `$`, `$(key)` substituted before run; missing key or unparseable result means the whole function does not run; strings inserted unquoted, numbers without suffixes.
- `/return` (1.20.3): stops the function, sets integer return value and success/failure; `execute if function` treats non-zero as true. (The page did not describe `return run`/`return fail`.)
- Gamerule `max_command_sequence_length`, default 65,536 commands per call chain. "This feature is exclusive to Java Edition."
- `/return`, `/data`, `/datapack`, `/trigger`, `/advancement`, `/random`, `/dialog` are Java-only — [Commands](https://minecraft.wiki/w/Commands).

**Bedrock functions** — [Function (Bedrock Edition)](https://minecraft.wiki/w/Function_(Bedrock_Edition)), [Bedrock Wiki: Functions](https://wiki.bedrock.dev/commands/mcfunctions):
- `.mcfunction` files in `behavior_packs/<pack>/functions/` (subfolders allowed; `sub/foo`); one command per line without leading `/`; `#` comments; full path ≤ 80 characters (console limitation).
- `tick.json` at `functions/tick.json`: `{"values": ["wiki/function_1"]}`; listed functions run every tick at 0,0,0 in the Overworld, starting as soon as the world initializes, even before a player loads.
- Limit: 10,000 commands per call including nested calls; all run in one tick. `/reload` picks up changes to existing functions; new files need a game restart (wiki) / `/reload` or relog (Bedrock Wiki). Content Log shows file/line errors; a function missing from suggestions likely has a command error.
- "Conditional commands are not possible in functions. Conditionals still need command blocks or the 1.19.50+ execute syntax" — [Bedrock Wiki: Functions](https://wiki.bedrock.dev/commands/mcfunctions). Microsoft: execute "allows for some conditional command execution that would otherwise be missing in functions" — [Popular Commands](https://learn.microsoft.com/en-us/minecraft/creator/documents/commandspopularcommands).
- Delays: scoreboard timers; the page does not mention `/schedule` — [Bedrock Wiki: Functions](https://wiki.bedrock.dev/commands/mcfunctions).
- Neither Bedrock function page mentions macros, `/return`, or load tags; `/return` is not in the Bedrock command list — [Commands](https://minecraft.wiki/w/Commands). Bedrock "macros" are hotkey macros — [Commands](https://minecraft.wiki/w/Commands).
- Manifest: `format_version` 2, `header` (name, description, uuid, version, `min_engine_version`), `modules` of type `data`; header and module UUIDs must differ — [Bedrock Wiki: Functions](https://wiki.bedrock.dev/commands/mcfunctions).

**Behavior pack vs datapack scope** — [Microsoft Learn: Differences](https://learn.microsoft.com/en-us/minecraft/creator/documents/differencesbetweenbedrockandjava): "Bedrock's behavior packs are equivalent to Java's data packs. While they share some similarities, the differences are significant." Java can create custom fonts and GLSL shaders; Bedrock cannot. Bedrock can create custom particles and fogs; Java cannot. World formats differ (LevelDB vs Anvil), so most third-party tools are edition-specific.

**Script API [Bedrock]** — [Microsoft Learn: Introduction to Scripting](https://learn.microsoft.com/en-us/minecraft/creator/documents/scripting/introduction):
- JavaScript (often TypeScript) scripts in a behavior pack; manifest adds a module `{"type":"script","entry":"scripts/main.js",...}` and a dependency `{"module_name":"@minecraft/server","version":"1.5.0"}`; tutorial uses `min_engine_version` [1,20,30].
- Core module `@minecraft/server` with classes `World`, `System`, `Player`, `Entity`, `Block`, `Dimension`; `system.run(fn)` schedules per-tick callbacks; `world.sendMessage`, `dimension.spawnEntity`, `world.getAllPlayers`; `/reload` hot-reloads scripts.
- TypeScript tutorial shows `world.scoreboard.addObjective`, `setObjectiveAtDisplaySlot`, `player.getComponent("inventory")`, `ItemStack`, `player.teleport`, `BlockPermutation.resolve`, `block.setPermutation`, `player.runCommand("scoreboard players set @s score ...")`, `overworld.getEntities({excludeTypes:["player"]})` — [Microsoft Learn: Scripting with TypeScript](https://learn.microsoft.com/en-us/minecraft/creator/documents/scripting/next-steps).
- `/scriptevent <messageId: namespace:id> <message>` sends an event to scripts via `system.afterEvents.scriptEventReceive` (id, message, initiator, source block/entity/type); `minecraft` namespace invalid; added Preview 1.19.60.22 behind "Beta APIs", toggle requirement removed in 1.20.30 — [Commands/scriptevent](https://minecraft.wiki/w/Commands/scriptevent).
- Commands run by the server or a script work regardless of cheat status — [Commands](https://minecraft.wiki/w/Commands).
- `/gametest` and `/script` are Bedrock-only commands — [Commands](https://minecraft.wiki/w/Commands).

**Structures**: **[Bedrock]** `/structure save <name> <from> <to> [includeEntities] [memory|disk] [includeBlocks]`, `/structure load <name> <to> [rotation 0/90/180/270] [mirror x/z/xz/none] [block_by_block|layer_by_layer] [seconds] [includeEntities] [includeBlocks] [waterlogged] [integrity] [seed]`, `/structure delete`; default namespace `mystructure:`; added 1.16.100 — [Commands/structure](https://minecraft.wiki/w/Commands/structure). Add-ons can ship structures in `bp/structures/` — [r/MinecraftCommands wiki: giveitembedrock](https://minecraftcommands.github.io/wiki/questions/giveitembedrock). **[Java]** uses `/place` (both editions have `/place`) — [Commands/structure](https://minecraft.wiki/w/Commands/structure), [Commands](https://minecraft.wiki/w/Commands).

**Ticking**: **[Bedrock]** `/tickingarea add <from> <to> [name] [preload]`, `add circle <center> <radius>`, `remove`, `remove_all`, `list`, `preload`; max 10 areas, rectangle ≤ 100 chunks, circle radius 0–4 chunks; added 1.2.0; Java counterpart `/forceload` — [Commands/tickingarea](https://minecraft.wiki/w/Commands/tickingarea).

### Inferences
- "Transferable programming concepts" split: scoreboards/tags/selectors/execute chains transfer; function-level control flow (`/return`, macros, `execute store`, predicates) is Java-only; Bedrock instead hands learners a *real* general-purpose language (JavaScript) once commands hit a wall.
- A Bedrock `tick.json` is the analogue of Java's `minecraft:tick` tag; there is no clean analogue of `minecraft:load` (this project's `ob_init` guard pattern would need a tick-function-with-flag on Bedrock).

### Gaps
- Whether Bedrock's Script API runs on Realms and in Education was not confirmed by fetched pages.
- `@minecraft/server-ui` forms (the Bedrock equivalent of clickable UI) were not fetched.

## KQ8. What do experienced mapmakers say about teaching on one edition vs the other?

### Takeaway
I found no reliable primary source (survey, named mapmaker, or official guidance) addressing "which edition to teach commands on". The community and commercial guides that exist mostly restate the capability gap (Bedrock: no NBT/`/data`, so fewer options for map builders; Java: more tutorials and deeper command-based programming) and the platform argument (Bedrock reaches console/mobile/Education players).

### Cited Findings
- Microsoft (official): Bedrock "uses a component-based system for commands instead of raw JSON strings"; Bedrock is on Windows, consoles, mobile (touch/controller), Java on Windows/Mac/Linux only — [Microsoft Learn: Differences](https://learn.microsoft.com/en-us/minecraft/creator/documents/differencesbetweenbedrockandjava).
- Microsoft provides structured Bedrock lessons: Introduction to Commands, Getting Started with Command Blocks, Popular Commands, then a "Complete the Monument" project — [Popular Commands](https://learn.microsoft.com/en-us/minecraft/creator/documents/commandspopularcommands).
- r/MinecraftCommands wiki maintains separate "Bedrock Codebase Resources" (bedrock.dev, wiki.bedrock.dev, NBT editors, world converters) and a Java/PC resources page, and labels Bedrock-specific FAQ answers (e.g. "Give a special item (Bedrock)", "Why is my execute command broken (bedrock)?") — [r/MinecraftCommands wiki: bcresources](https://minecraftcommands.github.io/wiki/bcresources), [Common Questions](https://minecraftcommands.github.io/wiki/questions).
- Search-snippet-level claims from secondary guides (pages returned 403 on fetch, so treat cautiously): Bedrock lacks `/data`, "so command blocks have fewer options for map builders"; "simple commands like /time set day or /gamemode creative work when copied across editions, but more complex ones often don't"; Bedrock has exclusives like `/tickingarea`, `/music`, `/ride`, NPCs — [mctoolbox.net guide](https://mctoolbox.net/blog/minecraft-bedrock-vs-java-command-differences-guide), [craftcmd.com guide](https://www.craftcmd.com/guides/java-vs-bedrock-minecraft-commands). (Note: `/ride` is in fact in both editions per [Commands](https://minecraft.wiki/w/Commands).)
- Player feedback post: Java lets you create unbreakable/custom-enchanted items in-game; Bedrock cannot — [feedback.minecraft.net](https://feedback.minecraft.net/hc/en-us/community/posts/47899304003725-Better-Bedrock-Commands) (snippet only).

### Inferences
- For teaching *programming concepts through commands* (variables → scoreboards, conditionals → `execute if`, functions → `.mcfunction`, return values → `/return`/`store`, data structures → NBT/storage), Java offers the complete ladder; Bedrock stops at scoreboards + `execute if` and then jumps to JavaScript. This follows from the capability findings in KQ3/KQ4/KQ7, not from a sourced opinion.
- For *reach* (students on tablets, consoles, or Minecraft Education), Bedrock is the only option, and its `/camera`, NPC, `/dialogue`, `/hud`, `/inputpermission` toolkit is purpose-built for guided/cinematic classroom experiences.

### Gaps
- No Reddit threads or Discord resources could be fetched (Reddit blocked; searches returned no r/MinecraftCommands threads). No educator-authored comparison was found.

## KQ9. Education Edition's relationship to Bedrock, and Education-only commands

### Takeaway
Minecraft Education is "an educational version of Bedrock Edition" (C++ codebase). Its exclusive commands are `/classroommode`, `/code`, `/codebuilder`, `/lesson`, `/geteduclientinfo` (+ selectors `@c`/`@v`), while `/ability`, `/immutableworld`, `/wb`/`/worldbuilder`, `/agent`, and the NPC are available in Bedrock too (some only with the "Minecraft Education features" toggle).

### Cited Findings
- Education is "an educational version of Bedrock Edition specifically designed for classroom use", developed by Mojang Studios and Xbox Game Studios in C++ — [Education Edition](https://minecraft.wiki/w/Education_Edition).
- Education-specific features: unlimited students per server, NPCs that give instructions and link to references, camera and portfolio items, chalkboards (1×1, 2×1, 3×2), tutorial world, allow/deny blocks, border blocks (bypassable with ender pearls/chorus fruit), Classroom Mode companion app, Code Builder + the Agent, Chemistry Set items (ice bombs, underwater TNT, underwater torches), Immutable world gamerule — [Education Edition](https://minecraft.wiki/w/Education_Edition).
- Education-only commands: `classroommode`, `code`, `codebuilder`, `geteduclientinfo`, `lesson`, `spawnitem`; Bedrock-only `geteduserverinfo` — [Commands](https://minecraft.wiki/w/Commands). `/classroommode` and `/code` "will attempt to launch and connect you to Classroom Mode and Code Connection, provided you have them installed" — [Education support: Essential Commands](https://edusupport.minecraft.net/hc/en-us/articles/360047555451-Essential-Commands) (search snippet; page 403 on fetch).
- `/ability <player> <worldbuilder|mayfly|mute> [true|false]` (query form `ability <player> [ability]`): `worldbuilder` lets the player build including in Adventure mode, `mayfly` flight as in Creative, `mute` silences chat; permission 1, cheats; works in Education, and in Bedrock only with the "Minecraft Education features" cheat setting; added PE 0.16.0 / Education 1.7 — [Commands/ability](https://minecraft.wiki/w/Commands/ability). Educators start with worldbuilder; students do not; `/wb` is a shortcut — [Education support](https://edusupport.minecraft.net/hc/en-us/articles/360047555451-Essential-Commands) (snippet).
- `/immutableworld [true|false]`: stops non-operator players altering the world in Survival (doors/levers still work); permission 1, cheats; Education, or Bedrock with the Education features toggle; added Bedrock 1.5.0 / Education 1.7 — [Commands/immutableworld](https://minecraft.wiki/w/Commands/immutableworld).
- `/agent` (Bedrock permission 1, Education 0): subcommands `move/turn/tp/getposition`, `attack/destroy/till/place <slot> <dir>/collect <item>`, `drop/dropall/transfer/getitemcount/getitemspace/getitemdetail/setitem`, `inspect/inspectdata/detect/detectredstone`, `create`; directions `forward|back|left|right|up|down`; "Agent control is limited to the WebSocket side the player is connected to. Players can't run it directly, but an NPC can"; added PE 1.0.0 — [Commands/agent](https://minecraft.wiki/w/Commands/agent). Listed among hidden Bedrock commands — [Commands](https://minecraft.wiki/w/Commands).
- `@c` (player's agent) and `@v` (all agents) are Education-only selectors — [Target selectors](https://minecraft.wiki/w/Target_selectors).
- NPC skins: 60 in Bedrock, 35 in Education; URL buttons Education-only — [NPC](https://minecraft.wiki/w/NPC).
- Education NPC/`/dialogue`: `/dialogue` added Education 1.17.30 vs Bedrock 1.17.10 — [Commands/dialogue](https://minecraft.wiki/w/Commands/dialogue).

### Inferences
- Everything taught on Bedrock (selectors, execute, scoreboards, NPC dialogue, `/camera`, behavior packs) transfers to Education, modulo version lag; Code Builder/Agent is an Education-only layer on top.

### Gaps
- How far Education lags behind Bedrock in version, and whether the Script API is available in Education, were not found in fetched pages.
- A complete official Education command list was not retrieved (the support page says to run `/help`).

## KQ10 (extra). Cheats/permission model and command-block differences

### Takeaway
Java: op levels 0–4; cheats only set the player's level (level 4 in cheat-enabled singleplayer/LAN); command blocks need level 2 and functions default to level 2. Bedrock: roles Visitor/Member/Operator/Custom mapping to internal levels 0–4 that depend on context (1 on servers/Realms, 2 on joined LAN, 3 hosted local), most commands are "cheats only", enabling cheats or op'ing a non-host player permanently disables achievements, command blocks run at level 1 and need the "Command Blocks Enabled"/`commandblocksenabled` switch. Command blocks share the three types and conditional/redstone modes, but Bedrock adds "Delay in Ticks", "Execute on First Tick", a "Hover Note", and dropdown UI.

### Cited Findings
**Permissions** — [Permission level](https://minecraft.wiki/w/Permission_level):
- **[Java]** Levels: 0 Operator (TPS graph, command-block output), 1 Moderator (bypass spawn protection), 2 Gamemaster (command blocks, selectors, gamemode, difficulty, NBT copying), 3 Admin (multiplayer management), 4 Owner (all incl. server management). Singleplayer with cheats = level 4; "Allow Commands" LAN = everyone level 4; Realms ops/owner = 2. Functions default to level 2 (`function-permission-level` since 1.14.4 pre4). Command blocks require level 2.
- **[Java]** Cheats "only affect the player's permission level"; a player with a high enough level can use commands even if cheats are off — [Commands](https://minecraft.wiki/w/Commands).
- **[Bedrock]** Roles Visitor / Member (default) / Operator / Custom (Custom not on Realms). Internal level set by context: operators are 1 on dedicated servers and Realms, 2 on joined LAN/online games, 3 on hosted local worlds; non-ops 0. Level 1 covers most gameplay commands (`/gamemode`, `/give`, `/kick`, `/setblock`); level 2 `/op`, `/deop`, `/place`, `/reload`, `/script`, `/wsserver`; level 3 `/setmaxplayers`; level 4 `/allowlist`, `/permission`, `/save`, `/stop`, `/transfer`. Dedicated servers use `permissions.json`, `/permission`, `default-player-permission-level`. "Making any player other than the host an Operator permanently disables achievements for that world." Command blocks cited at level 2 (Command Block page says 1 — see below); functions parsed at level 1.
- **[Bedrock]** "Cheats only" restriction: commands run by the server or a script work regardless; others need cheats enabled. "Allow Cheats" vs Java's "Allow Commands"; enabling cheats in Bedrock permanently blocks achievements in that world — [Commands](https://minecraft.wiki/w/Commands).
- Op-level differences for the same command: `kick` 3 (Java) vs 1 (Bedrock); `whitelist` 3 vs 4 — [Commands](https://minecraft.wiki/w/Commands).

**Command blocks** — [Command Block](https://minecraft.wiki/w/Command_Block):
- Both: impulse/chain/repeat, conditional/unconditional, Needs Redstone/Always Active; optional leading slash accepted; operator permission to place/edit. Permission: level 2 in Java, level 1 in Bedrock.
- Obtaining: Java via Creative "Operator Utilities" tab (if "Operator Items Tab" enabled); Bedrock via `/give`/`/setblock` or pick block.
- UI: Java buttons ("Impulse/Chain/Repeat", "Conditional/Unconditional", "Always Active/Needs Redstone"), field "Console Command", "O/X" Previous Output toggle, Done/Cancel; Bedrock dropdowns ("Block Type", "Condition", "Redstone"), field "Command Input", "Delay in Ticks", "Execute on First Tick", "Hover Note" name, closing the GUI saves.
- Repeat speed: Java once per tick; Bedrock once per tick "or more". Chat name prefix: Java "@", Bedrock "!".
- Output gamerule `commandBlockOutput false` (Java camelCase on that page); Bedrock lowercase `commandblockoutput`, `sendcommandfeedback`, `commandblocksenabled` — [Popular Commands](https://learn.microsoft.com/en-us/minecraft/creator/documents/commandspopularcommands). Bedrock world option "Command Blocks Enabled"; Java's switch is now `command_blocks_work` (25w44a), previously `commandBlocksEnabled` / `enable-command-block` — [Command Block](https://minecraft.wiki/w/Command_Block).
- Java GUI access also requires `op-permission-level` ≥ 2 — [Command Block](https://minecraft.wiki/w/Command_Block).

### Inferences
- The achievement lock is the biggest "warn your students" item on Bedrock: toggling cheats to run even `/gamemode` permanently disables achievements for that world; Java has no such penalty.
- Bedrock's "Delay in Ticks" lets a single command block do what Java needs a `/schedule` or scoreboard timer for.

### Gaps
- The two wiki pages disagree on Bedrock command-block permission level (1 vs 2); not resolved.
- Education's permission model is not described on the Permission level page.
