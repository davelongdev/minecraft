# Complete catalog of Minecraft Java Edition commands (1.21.x through 26.2 / data pack format 107)

Scope note: Java Edition only. "Current" = Java Edition 26.2 (released June 16, 2026, data pack format 107.1), the version this project targets. 26.3 (released September 15, 2026, data pack format 121.0) is also noted where it adds things, because it is already out and tutorials/wiki pages describe it. Permission levels: 0 = any player; 2 = operator / cheats (singleplayer with cheats grants level 4, so a singleplayer host can use everything except multiplayer-only commands); 3 = multiplayer-admin commands; 4 = server-owner commands.

Version shorthand used below: "1.21.11 (25w44a)" = release (snapshot where it first appeared).

## Key Question 1: What is the full command list in current Java Edition, categorized, with permission level, SP usability, syntax sketch, and version added (if 1.20+)?

### Takeaway
Java Edition 26.2 has 99 player-reachable command names (including aliases `xp`/`experience`, `tp`/`teleport`, `msg`/`tell`/`w`, `teammsg`/`tm`) plus 8 hidden debug commands that need JVM debug properties. The Minecraft Wiki "Commands" page is the canonical index; its table and the per-command pages give the permission levels and history used below. Two commands the wiki table lists, `/compute` and `/posteffect`, were added in 26.3 and are NOT in 26.2 (verified against the local 26.2 client jar's `en_us.json`, which has no `commands.compute.*` or `commands.posteffect.*` keys but does have `commands.swing.*` and `commands.unpublish.*`).

### Cited Findings

Permission-level framework (applies to every row below):
- Levels are incremental; level n allows anything a lower level allows. Level 2 ("Gamemaster") unlocks most commands, command blocks, target selectors, and F3+F4 game mode switching; level 3 ("Admin") adds multiplayer-management commands; level 4 ("Owner") adds server-management commands. — [Permission level](https://minecraft.wiki/w/Permission_level)
- A singleplayer player with cheats enabled has level 4; so does the owner of a LAN world with cheats, and all players in a command-allowed LAN world. Realm owners/operators have level 2. Everyone else is level 0. — [Permission level](https://minecraft.wiki/w/Permission_level)
- Command blocks require level 2; function parsing (including macro lines) defaults to level 2, adjustable via `function-permission-level` in server.properties (added 1.14.4 Pre-Release 4). — [Permission level](https://minecraft.wiki/w/Permission_level)
- Since 1.21.6, the generated "Command Syntax" report lists each command's permission level, and `run_command` click actions in books/chat ask for confirmation if the command needs a level above 0. — [Java Edition 1.21.6](https://minecraft.wiki/w/Java_Edition_1.21.6)
- 26.2 pre-release 4: "Open to LAN" can no longer grant the host commands, only other players (the host already has them). — [Commands, History](https://minecraft.wiki/w/Commands)

Catalog. Columns: Command | Purpose | Perm | SP w/ cheats? | Minimal syntax sketch | Added (if 1.20+; otherwise older). All names, purposes, and permission levels are from the Java Edition table on [Commands](https://minecraft.wiki/w/Commands) unless another source is cited in the row; version-added data is from the History section of that page and the per-command pages linked. Syntax sketches are abbreviated; each command's full syntax is at `https://minecraft.wiki/w/Commands/<name>`.

**A. Player and world basics**

| Command | Purpose | Perm | SP w/ cheats? | Syntax sketch | Added |
|---|---|---|---|---|---|
| help | Lists commands / shows usage | 0 | Yes (no cheats needed) | `/help [<command>]` | old |
| gamemode | Set a player's game mode | 2 | Yes | `/gamemode <survival|creative|adventure|spectator> [<targets>]` | old |
| defaultgamemode | Set the world's default game mode | 2 | Yes | `/defaultgamemode <mode>` | old |
| difficulty | Set/query difficulty | 2 | Yes | `/difficulty [peaceful|easy|normal|hard]` | old |
| gamerule | Set/query a game rule | 2 | Yes | `/gamerule <rule> [<value>]` (names are snake_case since 1.21.11, see KQ5) | old |
| time | Set/add/query world time (clock-based since 26.1) | 2 | Yes | `/time set <day|noon|night|midnight|<ticks>>`, `/time add <t>`, `/time query <daytime|gametime|day>`, 26.1 adds `/time of <clock> ...`, `pause`, `resume`, `rate <r>` | old; reworked 26.1 ([Java Edition 26.1](https://minecraft.wiki/w/Java_Edition_26.1)) |
| weather | Set weather | 2 | Yes | `/weather <clear|rain|thunder> [<duration>]` | old |
| seed | Show world seed | 0 in SP, 2 in MP | Yes (works without cheats in SP) | `/seed` | old |
| setworldspawn | Set world spawn | 2 | Yes | `/setworldspawn [<pos>] [<yaw> <pitch>]` (two rotation values in 26.x per this project's CLAUDE.md) | old |
| spawnpoint | Set a player's spawn point | 2 | Yes | `/spawnpoint [<targets>] [<pos>] [<angle>]` | old |
| worldborder | Manage world border | 2 | Yes | `/worldborder set <size> [<time>]`, `center`, `damage`, `warning`, `get`, `add` (1.21.11: `time` now in ticks, `s`/`d` suffixes accepted) | old; changed 1.21.11 ([Java Edition 1.21.11](https://minecraft.wiki/w/Java_Edition_1.21.11)) |
| forceload | Force chunks loaded | 2 | Yes | `/forceload add <from> [<to>]`, `remove`, `query` | old (1.13.1 replaced `/chunk`) |
| fillbiome | Fill region with a biome | 2 | Yes | `/fillbiome <from> <to> <biome> [replace <filter>]` | 1.19.3 (22w46a) |
| locate | Find nearest structure/biome/POI | 2 | Yes | `/locate structure <s>`, `/locate biome <b>`, `/locate poi <p>` | old; `biome`/`structure` subcommands 1.19 (22w19a) |
| tick | Control tick rate / freeze / step | 3 | Yes (SP = level 4); not from command blocks | `/tick query`, `rate <1..10000>`, `freeze`, `unfreeze`, `step [<time>|stop]`, `sprint [<time>|stop]` | 1.20.3 (23w43a) — [Commands/tick](https://minecraft.wiki/w/Commands/tick) |
| stopwatch | Real-time stopwatches (run while paused) | 2 | Yes | `/stopwatch create <id>`, `query <id> [scale]`, `restart <id>`, `remove <id>` | 1.21.11 — [Java Edition 1.21.11](https://minecraft.wiki/w/Java_Edition_1.21.11) |

**B. Items and inventory**

| Command | Purpose | Perm | SP w/ cheats? | Syntax sketch | Added |
|---|---|---|---|---|---|
| give | Give an item | 2 | Yes | `/give <targets> <item>[components] [<count>]` | old |
| clear | Remove items from inventory | 2 | Yes | `/clear [<targets>] [<item>] [<maxCount>]` | old |
| item | Replace/modify items in slots | 2 | Yes | `/item replace (block <pos>|entity <targets>) <slot> with <item> [<count>]`, `... from (block|entity) ... <slot> [<modifier>]`, `/item modify ... <slot> <modifier>`; 26.3 adds `override`/`fill` | 1.17 (20w46a) replacing `/replaceitem` — [Commands/item](https://minecraft.wiki/w/Commands/item) |
| loot | Drop/give items from loot tables, kills, mining | 2 | Yes | `/loot (give <players>|insert <pos>|spawn <pos>|replace block <pos> <slot>|replace entity <t> <slot>) (fish <table> <pos> [tool]|loot <table>|kill <target>|mine <pos> [tool])`; 1.20.5 allows inline SNBT loot tables | 1.14 — [Commands/loot](https://minecraft.wiki/w/Commands/loot) |
| enchant | Enchant held item | 2 | Yes | `/enchant <targets> <enchantment> [<level>]` | old |
| recipe | Give/take recipes | 2 | Yes | `/recipe (give|take) <targets> (*|<recipe>)` | old |
| experience / xp | Add/set/query XP | 2 | Yes | `/xp add <targets> <amount> [points|levels]`, `set`, `query` | old |
| fetchprofile | Look up a player profile (for heads/mannequins) | 2 | Yes | `/fetchprofile name <name>`, `id <uuid>`, `entity <entity>` (entity form 26.1) | 1.21.9 (25w34a) — [Commands/fetchprofile](https://minecraft.wiki/w/Commands/fetchprofile) |

**C. Movement and teleport**

| Command | Purpose | Perm | SP w/ cheats? | Syntax sketch | Added |
|---|---|---|---|---|---|
| teleport / tp | Teleport entities | 2 | Yes | `/tp <destination>`, `/tp <targets> <pos> [<rot>|facing <pos>|facing entity <e> [eyes|feet]]` | old |
| spreadplayers | Scatter entities randomly | 2 | Yes | `/spreadplayers <center> <spreadDistance> <maxRange> [under <maxHeight>] <respectTeams> <targets>` | old |
| rotate | Set an entity's rotation | 2 (was 0 in snapshot, changed in 1.21.2-pre1) | Yes | `/rotate <target> <rot>`, `/rotate <target> facing <pos>`, `facing entity <e> [anchor]` | 1.21.2 (24w40a) |
| ride | Mount/dismount entities | 2 | Yes | `/ride <target> mount <vehicle>`, `/ride <target> dismount` | 1.19.4 (23w03a) |
| spectate | Make a spectator watch an entity | 2 | Yes | `/spectate [<target>] [<player>]` | old (1.15) |
| transfer | Send player to another server | 3 | No (MP only) | `/transfer <hostname> [<port>] [<players>]` | 1.20.5 (24w04a) |

**D. Entities**

| Command | Purpose | Perm | SP w/ cheats? | Syntax sketch | Added |
|---|---|---|---|---|---|
| summon | Spawn an entity | 2 | Yes | `/summon <entity> [<pos>] [<nbt>]` | old |
| kill | Kill entities | 2 | Yes | `/kill [<targets>]` | old |
| damage | Deal damage | 2 | Yes | `/damage <target> <amount> [<damageType>] [at <pos>|by <entity> [from <cause>]]` | 1.19.4 (23w06a) |
| effect | Status effects | 2 | Yes | `/effect give <targets> <effect> [<seconds>|infinite] [<amplifier>] [<hideParticles>]`, `/effect clear [<targets>] [<effect>]` | old |
| attribute | Query/set attributes & modifiers | 2 | Yes | `/attribute <target> <attr> get [scale]`, `base get|set <v>|reset`, `modifier add <id> <value> (add_value|add_multiplied_base|add_multiplied_total)`, `modifier remove <id>`, `modifier value get <id>` | 1.16; ops renamed 1.20.5 (24w09a); UUID+name merged into `id` 1.21 (24w21b); `base reset` 1.21.4 (24w44a) — [Commands/attribute](https://minecraft.wiki/w/Commands/attribute) |
| tag | Entity string tags | 2 | Yes | `/tag <targets> (add|remove) <tag>`, `/tag <targets> list` | old |
| team | Teams | 2 | Yes | `/team add <team> [<displayName>]`, `join`, `leave`, `modify <team> color <color>` (26.2: lowercase names only, e.g. `dark_purple`) | old |
| swing | Play arm-swing animation | 2 | Yes | `/swing [<targets>] [mainhand|offhand]` | 26.1 (Snapshot 1) — [Java Edition 26.1](https://minecraft.wiki/w/Java_Edition_26.1) |
| particle | Spawn particles | 2 | Yes | `/particle <particle> [<pos>] [<delta> <speed> <count>] [force|normal] [<viewers>]` | old |
| playsound / stopsound | Play/stop sounds | 2 | Yes | `/playsound <sound> [<source>] [<targets>] [<pos>] [<volume>] [<pitch>] [<minVolume>]`; `ui` source category added 1.21.6 | old |

**E. Blocks and building**

| Command | Purpose | Perm | SP w/ cheats? | Syntax sketch | Added |
|---|---|---|---|---|---|
| setblock | Place one block | 2 | Yes | `/setblock <pos> <block> [destroy|keep|replace] [strict]` | old |
| fill | Fill a region | 2 | Yes | `/fill <from> <to> <block> [destroy|hollow|keep|outline|replace [<filter>]] [strict]` | old |
| clone | Copy a region | 2 | Yes | `/clone [from <dim>] <begin> <end> [to <dim>] <dest> [replace|masked|filtered <filter>] [force|move|normal]` | old |
| place | Place features/jigsaws/structures/templates | 2 | Yes | `/place feature <f> [<pos>]`, `/place jigsaw <pool> <target> <depth> [<pos>]`, `/place structure <s> [<pos>]`, `/place template <t> [<pos>] [<rot>] [<mirror>] [<integrity>] [<seed>] [strict]` | 1.19 (22w18a) replacing `/placefeature` — [Commands/place](https://minecraft.wiki/w/Commands/place) |
| test | GameTest framework (test blocks/structures) | 2 | Yes | `/test run <tests>`, `runthese`, `runclosest`, `create <id>`, `clearall`, `pos`, `reset*`, `stop`, `verify`, `export*` (IDE only) | 1.15 IDE-only; usable in normal play since 1.21.5 (25w03a) — [Commands/test](https://minecraft.wiki/w/Commands/test) |

**F. Scoreboard and data**

| Command | Purpose | Perm | SP w/ cheats? | Syntax sketch | Added |
|---|---|---|---|---|---|
| scoreboard | Objectives and scores | 2 | Yes | `/scoreboard objectives add <obj> <criterion> [<display>]`, `objectives setdisplay <slot> [<obj>]`, `players set|add|remove|get|reset|operation|enable ...` | old |
| trigger | Player-settable scoreboard trigger | 0 | Yes | `/trigger <objective> [add|set <value>]` | old |
| data | Read/write NBT | 2 | Yes | `/data get|merge|modify|remove (block <pos>|entity <t>|storage <id>) [<path>] ...` | old (1.13, replaced blockdata/entitydata) |
| bossbar | Boss bars | 2 | Yes | `/bossbar add <id> <name>`, `set <id> (value|max|color|style|players|visible|name) ...`, `get`, `remove`, `list` | old |
| random | Random numbers / sequences | 0 (`value`/`roll` without sequence); 2 with a sequence or for `reset` | Yes | `/random value <min..max>` (private), `/random roll <range>` (broadcast), `/random (value|roll) <range> <sequence>`, `/random reset (*|<sequence>) [<seed> ...]` | 1.20.2 (23w31a) — [Commands/random](https://minecraft.wiki/w/Commands/random) |
| compute | Evaluate a number provider | 2 | **Not in 26.2** | `/compute <default|block <pos>|entity <e>> integer <int_provider>` / `float <float_provider> [<scale>]` | **26.3 (Snapshot 10)** — [Java Edition 26.3](https://minecraft.wiki/w/Java_Edition_26.3) |

**G. Execution and logic**

| Command | Purpose | Perm | SP w/ cheats? | Syntax sketch | Added |
|---|---|---|---|---|---|
| execute | Change context, test conditions, store results, run commands | 2 | Yes | `/execute [as|at|positioned|rotated|facing|align|anchored|in|on|summon ...] [if|unless ...] [store result|success ...] run <command>` — full subcommand list in KQ5 | reworked 1.13 |
| function | Run a function (with optional macro args) | 2 | Yes | `/function <name>`, `/function <name> {k:v}`, `/function <name> with (block <pos>|entity <e>|storage <id>) [<path>]` | 1.12; macros 1.20.2 (23w31a) — [Commands/function](https://minecraft.wiki/w/Commands/function) |
| return | Return value / early exit from a function | 2 | Yes | `/return <int>`, `/return fail`, `/return run <command>` | 1.20 (23w16a); `run` 1.20.2 (23w31a); `fail` 1.20.3 (23w44a) — [Commands/return](https://minecraft.wiki/w/Commands/return); [23w16a](https://minecraft.wiki/w/Java_Edition_23w16a) |
| schedule | Delay a function | 2 | Yes | `/schedule function <name> <time> [append|replace]`, `/schedule clear <name>` | old |

**H. Messaging and UI**

| Command | Purpose | Perm | SP w/ cheats? | Syntax sketch | Added |
|---|---|---|---|---|---|
| msg / tell / w | Private message | 0 | Yes | `/msg <targets> <message>` | old |
| me | Emote-style message | 0 | Yes | `/me <action>` | old |
| teammsg / tm | Message your team | 0 | Yes | `/teammsg <message>` | old |
| say | Broadcast as "[name] msg" | 2 | Yes | `/say <message>` | old |
| tellraw | Send text component | 2 | Yes | `/tellraw <targets> <textComponent>` | old |
| title | Title/subtitle/actionbar | 2 | Yes | `/title <targets> (title|subtitle|actionbar) <text>`, `times <fadeIn> <stay> <fadeOut>`, `clear`, `reset` | old |
| dialog | Show/clear dialog screens | 2 | Yes | `/dialog show <targets> <dialog|inline>`, `/dialog clear <targets>` | 1.21.6 — [Java Edition 1.21.6](https://minecraft.wiki/w/Java_Edition_1.21.6) |
| waypoint | Locator-bar waypoints | 2 | Yes | `/waypoint list`, `/waypoint modify <entity> color <color|hex RRGGBB|reset>`, `style set <style>|reset` | 1.21.6 (25w15a experiment, standalone 25w17a) |
| posteffect | Client post-processing shaders | 2 | **Not in 26.2** | `/posteffect add <player> <effect>`, `clear`, `list`, `remove` | **26.3 (Snapshot 3)** — [Java Edition 26.3](https://minecraft.wiki/w/Java_Edition_26.3) |
| list | List online players | 0 | Yes | `/list [uuids]` | old |
| version | Print server version info | 2 | Yes ("available in singleplayer or for server operators") | `/version` | 1.21.6 (25w15a) — [Commands/version](https://minecraft.wiki/w/Commands/version) |

**I. Datapacks, functions, advancements**

| Command | Purpose | Perm | SP w/ cheats? | Syntax sketch | Added |
|---|---|---|---|---|---|
| datapack | Enable/disable/list packs; create empty pack | 2 | Yes | `/datapack list [available|enabled]`, `enable <pack> [first|last|before|after <pack>]`, `disable <pack>`, `create <id> <name>` (1.21.6, owners only) | old; `create` 1.21.6 |
| reload | Reload data packs | 2 | Yes | `/reload` | old |
| advancement | Grant/revoke advancements | 2 | Yes | `/advancement (grant|revoke) <targets> (everything|only <adv> [<criterion>]|from|through|until <adv>)` | old |

**J. Server admin and debug**

| Command | Purpose | Perm | SP w/ cheats? | Syntax sketch | Added |
|---|---|---|---|---|---|
| op / deop | Grant/revoke operator | 3 | No (MP only) | `/op <player>`, `/deop <player>` | old |
| kick | Kick a player | 3 | Listed as not MP-only | `/kick <targets> [<reason>]` | old |
| ban / ban-ip / pardon / pardon-ip / banlist | Ban management | 3 | No (MP only) | `/ban <targets> [<reason>]`, `/ban-ip <target>`, `/pardon <targets>`, `/pardon-ip <ip>`, `/banlist [ips|players]` | old |
| whitelist | Whitelist management | 3 | No (MP only) | `/whitelist (on|off|list|add <p>|remove <p>|reload)` | old |
| setidletimeout | Idle kick timer | 3 | No (MP only) | `/setidletimeout <minutes>` | old |
| save-all / save-off / save-on | Server saving | 4 | No (MP only) | `/save-all [flush]`, `/save-off`, `/save-on` | old |
| stop | Stop the server | 4 | No (MP only) | `/stop` | old |
| publish | Open SP world to LAN | 4 | SP only | `/publish [<allowCommands>] [<gamemode>] [<port>]` | old |
| unpublish | Close the LAN server | 4 | SP only | `/unpublish` | 26.2 (Snapshot 8) — [Java Edition 26.2](https://minecraft.wiki/w/Java_Edition_26.2) |
| debug | Profiling session | 3 | Yes | `/debug start`, `/debug stop`, `/debug function <name>` | old |
| perf | 10-second performance capture | 4 | No (MP only) | `/perf start`, `/perf stop` | 1.17 (pre1) |
| jfr | Java Flight Recorder profiling | 4 | Yes | `/jfr start`, `/jfr stop` | 1.18 (21w37a) |

Hidden debug commands (require JVM debug properties; "should not be used during normal play"): `warden_spawn_tracker` (2), `debugpath` (2), `debugmobspawning` (2), `raid` (3), `serverpack` (2), `spawn_armor_trims` (2), `debugconfig` (3, MP), `chase` (0, needs `CHASE_COMMAND`). — [Commands](https://minecraft.wiki/w/Commands)

### Inferences
- For the one-block / jump-game teaching context on 26.2, the realistic set to teach is categories A–I; J is server-only except `/publish`, `/unpublish`, `/debug`, and `/jfr`.
- Because singleplayer-with-cheats is level 4, "SP w/ cheats?" is effectively "yes" for every command that is not flagged multiplayer-only (op/deop/ban*/pardon*/whitelist/setidletimeout/save-*/stop/transfer/perf). `/kick` is listed without the multiplayer-only flag but is only meaningful on a server.
- Wiki table rows for `/compute` and `/posteffect` reflect 26.3; a 26.2 world will report "Unknown command" for them (confirmed by their absence from the 26.2 jar's translation keys).

### Gaps
- Syntax sketches for the long-standing commands (clone, fill, scoreboard, etc.) are condensed from general knowledge of the per-command wiki pages, not re-fetched this session; verify argument order against `https://minecraft.wiki/w/Commands/<name>` before publishing a cheat sheet.
- The wiki's permission level for `/kick` (3, not MP-only) could not be cross-checked against another source.

## Key Question 2: Which commands can a normal player use without operator permissions?

### Takeaway
Level-0 commands in 26.2 are `/help`, `/list`, `/me`, `/msg` (+`/tell`, `/w`), `/teammsg` (+`/tm`), `/trigger`, `/random value|roll <range>` (without a named sequence), and `/seed` in singleplayer only. `/version` is level 2, not 0.

### Cited Findings
- Level 0 ("OP level 0") commands in the Java table: `help`, `list`, `me`, `msg`/`tell`/`w`, `teammsg`/`tm`, `trigger`; `random` is "0 (without `sequence`), 2"; `seed` is "0 in singleplayer, 2 in multiplayer". — [Commands](https://minecraft.wiki/w/Commands)
- `/random value` shows the result only to the invoker; `/random roll` broadcasts it to all players; both are level 0 unless a `<sequence>` is given. — [Commands/random](https://minecraft.wiki/w/Commands/random)
- `/version` requires permission level 2. — [Commands/version](https://minecraft.wiki/w/Commands/version)
- `/rotate` was level 0 in snapshot 24w40a but changed to level 2 in 1.21.2 Pre-release 1. — [Commands, History](https://minecraft.wiki/w/Commands)
- The hidden `chase` debug command is level 0 but only exists when the `CHASE_COMMAND` debug property is set. — [Commands](https://minecraft.wiki/w/Commands)
- `/trigger` is the standard way for non-op players to interact with datapack logic (it sets a scoreboard objective with the `trigger` criterion that must first be enabled with `/scoreboard players enable`). — [Commands](https://minecraft.wiki/w/Commands) (purpose column: "Sets a trigger to be activated")

### Inferences
- For a classroom server where students are not ops, the only interactive hooks are `/trigger` (datapack menus), chat commands, and `/random roll` for dice games; everything else requires granting level 2 or giving each student their own singleplayer world with cheats.

### Gaps
- None significant; the level-0 list is fully specified by the wiki table.

## Key Question 3: Major command additions in 1.20.x, 1.21.x, and the 2026 releases, with version introduced

### Takeaway
The 1.19.3–1.21.11 period added `/fillbiome`, `/ride`, `/damage`, `/return`, `/random`, function macros, `/tick`, `/transfer`, `/rotate`, `/version`, `/dialog`, `/waypoint`, `/fetchprofile`, and `/stopwatch`; 26.1 added `/swing` and rebuilt `/time` around clocks; 26.2 added `/unpublish`; 26.3 (after this project's target) added `/posteffect`, `/compute`, `/item override|fill`, and `/execute if slots`.

### Cited Findings
Chronological, from the Commands page History section unless noted ([Commands](https://minecraft.wiki/w/Commands)):
- 1.17 (20w46a): `/replaceitem` removed, replaced by `/item replace`; 1.17-pre1: `/perf` added.
- 1.18 (21w37a): `/jfr` added.
- 1.18.2 (22w03a): `/placefeature` added; 1.19 (22w18a): removed and replaced by `/place feature`; 1.19 (22w19a): `/locatebiome` removed, replaced by `/locate biome` (structures now `/locate structure`).
- 1.19.3 (22w46a): `/fillbiome` added.
- 1.19.4 (23w03a): `/ride` added; (23w06a): `/damage` added.
- 1.20 (23w16a, released April 20, 2023): `/return <value>` added, "a new command that can be used to control execution flow inside functions and change their return value." — [Java Edition 23w16a](https://minecraft.wiki/w/Java_Edition_23w16a); [Commands/return](https://minecraft.wiki/w/Commands/return)
- 1.20.2 (23w31a): `/random` added; function macros (`$`-prefixed lines with `$(var)` substitution, `/function <name> {args}` and `/function <name> with ...`) added; `/return run` added (temporarily removed in 1.20.2-pre1, reinstated 1.20.3 23w41a). — [Commands/function](https://minecraft.wiki/w/Commands/function); [Commands/return](https://minecraft.wiki/w/Commands/return)
- 1.20.2 (23w31a): `/execute if|unless function <function>` added (reintroduced 1.20.3 23w41a). — [Commands/execute](https://minecraft.wiki/w/Commands/execute)
- 1.20.3 (23w43a): `/tick` added (permission level 3; `step` time optional from 23w44a); (23w44a): `/return fail` added, `return run` now propagates success. — [Commands/tick](https://minecraft.wiki/w/Commands/tick); [Commands/return](https://minecraft.wiki/w/Commands/return)
- 1.20.5 (24w04a): `/transfer` added; (24w09a): `/attribute` modifier operations renamed to `add_value`, `add_multiplied_base`, `add_multiplied_total`; (24w10a): `/execute if|unless items` added; (24w12a): `/loot` accepts inline SNBT loot tables. — [Commands/attribute](https://minecraft.wiki/w/Commands/attribute); [Commands/execute](https://minecraft.wiki/w/Commands/execute); [Commands/loot](https://minecraft.wiki/w/Commands/loot)
- 1.21 (24w21b): `/attribute modifier` UUID + name arguments replaced by a single namespaced `id`. — [Commands/attribute](https://minecraft.wiki/w/Commands/attribute)
- 1.21.2 (24w40a): `/rotate` added (level 0 → 2 in pre1).
- 1.21.4 (24w44a): `/attribute ... base reset` added. — [Commands/attribute](https://minecraft.wiki/w/Commands/attribute)
- 1.21.5 (25w03a): `/test` becomes usable in normal gameplay (previously IDE-only since 1.15). — [Commands/test](https://minecraft.wiki/w/Commands/test)
- 1.21.6 "Chase the Skies" (June 17, 2025; pack format 80): `/version`, `/dialog show|clear`, `/waypoint list|modify` added; `/datapack create <id> <name>` added; `/playsound` gains the `ui` source. — [Java Edition 1.21.6](https://minecraft.wiki/w/Java_Edition_1.21.6)
- 1.21.9 (25w34a): `/fetchprofile name|id` added; 26.1 Snapshot 8 adds `fetchprofile entity`. — [Commands/fetchprofile](https://minecraft.wiki/w/Commands/fetchprofile)
- 1.21.11 "Mounts of Mayhem" (December 9, 2025; pack format 94.1): `/stopwatch create|query|restart|remove` added (real-time, runs while paused); `/execute if|unless stopwatch <id> <range>` added; `/worldborder` time arguments switch to ticks with `s`/`d` suffixes; game rules moved to a snake_case registry (see KQ5). — [Java Edition 1.21.11](https://minecraft.wiki/w/Java_Edition_1.21.11)
- 26.1 "Tiny Takeover" (March 24, 2026; pack format 101.1): `/swing [<targets>] [mainhand|offhand]` added; `/time` reworked around world clocks (`/time of <clock>`, `pause`, `resume`, `rate <0..1000>`, `query <timeline>`, time markers `day|noon|night|midnight`; `set`/`add` now return total elapsed ticks). — [Java Edition 26.1](https://minecraft.wiki/w/Java_Edition_26.1)
- 26.2 "Chaos Cubed" (June 16, 2026; pack format 107.1): `/unpublish` added; `/team modify ... color` and `/waypoint modify ... color` accept only lowercase snake_case names (`dark_purple`, not `darkpurple`); `/execute on owner` treats vexes as owned by their evoker; host game-mode changes now update the world default. — [Java Edition 26.2](https://minecraft.wiki/w/Java_Edition_26.2)
- 26.3 "Wilderness Bound" (September 15, 2026; pack format 121.0): `/posteffect` (Snapshot 3) and `/compute` (Snapshot 10) added; `/item override` and `/item fill` added (snap1); `/execute if|unless slots` condition added (snap1). — [Java Edition 26.3](https://minecraft.wiki/w/Java_Edition_26.3); [Commands/item](https://minecraft.wiki/w/Commands/item); [Commands/execute](https://minecraft.wiki/w/Commands/execute)

### Inferences
- A tutorial that uses `/return run` with a stored success value needs 1.20.3+, not just 1.20.
- Tutorials showing `/attribute ... modifier add <uuid> <name> <value> add` are pre-1.21 and will fail on 26.2; the modern form is `modifier add <namespace:id> <value> add_value`.
- `/time set day` still works in 26.1+ but is now a "time marker" on the overworld clock rather than a hard-coded keyword.

### Gaps
- Release dates for 1.20.x minor releases were not re-verified this session (only snapshot IDs from the wiki history).
- The 26.3 "Command format" changes section was truncated in the fetch; there may be further 26.3 syntax changes beyond `if slots` and `item override|fill`.

## Key Question 4: Commands removed or renamed in recent years, and their replacements

### Takeaway
Everything removed since 1.13 has a direct replacement: `/testfor*` and `/stats` → `/execute if|unless|store`, `/blockdata`/`/entitydata` → `/data`, `/toggledownfall` → `/weather`, `/chunk` → `/forceload`, `/replaceitem` → `/item replace`, `/placefeature` → `/place feature`, `/locatebiome` → `/locate biome`. Bedrock still has several of these names, which is the main source of confusion in mixed-edition tutorials.

### Cited Findings
Removed Java commands (from the "Removed commands" table on [Commands](https://minecraft.wiki/w/Commands)):
- `/?` — removed 1.13 (17w45a); alias of `/help`.
- `/achievement` — removed 1.12 (17w13a); superseded by advancements (`/advancement`).
- `/blockdata` — removed 1.13 (17w47a); superseded by `/data`.
- `/entitydata` — removed 1.13 (17w45b); superseded by `/data`.
- `/stats` — removed 1.13 (17w45a); merged into `/execute store`.
- `/testfor`, `/testforblock`, `/testforblocks` — removed 1.13 (17w45a); merged into `/execute if|unless entity|block|blocks`.
- `/toggledownfall` — removed 1.13 (17w45a); redundant with `/weather`.
- `/chunk` — removed 1.13.1 (pre1); superseded by `/forceload`.
- `/replaceitem` — removed 1.17 (20w46a); superseded by `/item replace`. — also [Commands/item](https://minecraft.wiki/w/Commands/item)
- `/placefeature` — removed 1.19 (22w18a); superseded by `/place feature`. — also [Commands/place](https://minecraft.wiki/w/Commands/place)
- `/locatebiome` — removed 1.19 (22w19a); superseded by `/locate biome`.
- Pre-release-era removals (not relevant to modern tutorials): `banip`, `broadcast`, `home`, `setspawn`, `solid`, `unban`.
- `/drop` was the original name of `/loot` in 18w43a; renamed to `/loot` in 18w45a (1.14). — [Commands/loot](https://minecraft.wiki/w/Commands/loot)
- `/banlist` still exists in Java (level 3, multiplayer only) — it was not removed. — [Commands](https://minecraft.wiki/w/Commands)
- `/debug` still exists in Java (level 3); it "starts or stops a debugging session." — [Commands](https://minecraft.wiki/w/Commands)

Renamed arguments and syntax (not whole commands) that break old tutorials:
- `/attribute` operation names `add`/`multiply_base`/`multiply` → `add_value`/`add_multiplied_base`/`add_multiplied_total` (1.20.5), and UUID+name → `id` (1.21). — [Commands/attribute](https://minecraft.wiki/w/Commands/attribute)
- `/locate <structure>` → `/locate structure <structure>` (1.19). — [Commands, History](https://minecraft.wiki/w/Commands)
- `/worldborder` times are ticks, not seconds, since 1.21.11. — [Java Edition 1.21.11](https://minecraft.wiki/w/Java_Edition_1.21.11)
- Team/waypoint color names must be lowercase snake_case since 26.2. — [Java Edition 26.2](https://minecraft.wiki/w/Java_Edition_26.2)
- Game rules renamed to snake_case in 1.21.11 (full mapping in KQ5). — [Game rule](https://minecraft.wiki/w/Game_rule)
- Game rules `doFireTick` and `allowFireTicksAwayFromPlayer` were removed in 1.21.11, replaced by `fire_spread_radius_around_player` (int; 0 disables fire spread, -1 = unlimited). — [Java Edition 1.21.11](https://minecraft.wiki/w/Java_Edition_1.21.11)

Bedrock-only commands a learner may confuse with Java (from the Bedrock table on [Commands](https://minecraft.wiki/w/Commands)): `ability`, `camera`, `camerashake`, `dialogue` (Java uses `/dialog`), `event`, `fog`, `inputpermission`, `mobevent`, `music`, `playanimation`, `script`, `scriptevent`, `structure`, `tickingarea`, `titleraw`, `wsserver`, `alwaysday`, `daylock`, `clearspawnpoint`, `hud`, `immutableworld`, `setmaxplayers`, `permission`, `ops`, `wb`/`worldbuilder`, `connect`, `agent`, `aimassist`, `gametips`, plus `replaceitem` and `toggledownfall`, which Bedrock kept after Java removed them.

### Inferences
- The quickest "is this tutorial outdated?" tells: `/testfor`, `/replaceitem`, `/entitydata`, camelCase gamerules (`doDaylightCycle`), `/attribute ... add` with a UUID, `pack_format` in pack.mcmeta, and `/execute ... detect`.
- Anything using `/camera`, `/titleraw`, `/tickingarea`, `/structure`, or `/dialogue` is a Bedrock tutorial.

### Gaps
- The Removed-commands table lists `/home` as "superseded by `kill`", which is almost certainly a wiki error; not corroborated elsewhere.
- No source explicitly covered the 1.13 removal of `/execute ... detect` (replaced by `/execute if block`); it is implied by the 1.13 `/execute` rework entry in [Commands/execute](https://minecraft.wiki/w/Commands/execute) history.

## Key Question 5: Full /execute subcommand list and current /gamerule names (snake_case)

### Takeaway
`/execute` in 26.2 has 10 modifier subcommands (`align`, `anchored`, `as`, `at`, `facing`, `in`, `on`, `positioned`, `rotated`, `summon`), 13 condition tests (`biome`, `block`, `blocks`, `data`, `dimension`, `entity`, `function`, `items`, `loaded`, `predicate`, `score`, `stopwatch`; plus `slots` from 26.3), 5 `store` targets, and `run`. Game rules became snake_case resource locations in 1.21.11 (25w44a), with `disable…` rules inverted; 26.2's names are the snake_case ones (e.g. `advance_time`, `respawn_radius`).

### Cited Findings
`/execute` subcommands (all from [Commands/execute](https://minecraft.wiki/w/Commands/execute)):
- Modifiers: `align <axes>`; `anchored <eyes|feet>`; `as <targets>`; `at <targets>`; `facing <pos>` / `facing entity <targets> <anchor>`; `in <dimension>`; `on <relation>` (1.19.4, 23w03a; relations include attacker, controller, leasher, origin, owner, passengers, target, vehicle); `positioned <pos>` / `positioned as <targets>` / `positioned over <heightmap>` (`over` 1.19.4-pre1); `rotated <rot>` / `rotated as <targets>`; `summon <entity>` (1.19.4, 23w06a).
- Conditions (`if`/`unless`): `biome <pos> <biome>` (1.19.3, 22w46a); `block <pos> <block>`; `blocks <start> <end> <dest> (all|masked)`; `data (block <pos>|entity <t>|storage <s>) <path>` (1.14, 18w43a); `dimension <dim>` (1.19.4, 23w03a); `entity <targets>`; `function <function>` (1.20.2 23w31a, reintroduced 1.20.3 23w41a); `items (block <pos>|entity <t>) <slots> <item_predicate>` (1.20.5, 24w10a); `loaded <pos>` (1.19.4, 23w03a; became a condition in 23w06a); `predicate <predicate>` (1.15, 19w38a); `score <t> <obj> (<|<=|=|>=|>) <s> <obj>` / `score <t> <obj> matches <range>`; `stopwatch <id> <range>` (1.21.11, 25w41a); `slots` (26.3-snap1; the `items` condition also gained a slot-source argument in 26.3 — not applicable to 26.2).
- Store: `store (result|success) block <pos> <path> <type> <scale>`; `... bossbar <id> (value|max)` (1.13, 18w05a); `... entity <t> <path> <type> <scale>`; `... score <targets> <objective>`; `... storage <id> <path> <type> <scale>` (1.15, 19w38a).
- `run <command>`. The whole command was reworked in 17w45a (1.13) and store subcommands in 17w45b.
- `/execute on owner` treats vexes as owned by their evoker since 26.2. — [Java Edition 26.2](https://minecraft.wiki/w/Java_Edition_26.2)

Game rules — rename:
- "All rules were moved into a registry and renamed to resource locations in snake_case" in 1.21.11 (snapshot 25w44a); `elytra_movement_check`, `player_movement_check`, and `raids` have inverted logic relative to their `disable…` predecessors. — [Game rule](https://minecraft.wiki/w/Game_rule); corroborated by [Java Edition 1.21.11](https://minecraft.wiki/w/Java_Edition_1.21.11)
- Mapping (old → new): announceAdvancements → show_advancement_messages; commandBlocksEnabled → command_blocks_work; command_modification_block_limit → max_block_modifications; disableElytraMovementCheck → elytra_movement_check (inverted); disablePlayerMovementCheck → player_movement_check (inverted); disableRaids → raids (inverted); doDaylightCycle → advance_time; doEntityDrops → entity_drops; doImmediateRespawn → immediate_respawn; doInsomnia → spawn_phantoms; doLimitedCrafting → limited_crafting; doMobLoot → mob_drops; doMobSpawning → spawn_mobs; doPatrolSpawning → spawn_patrols; doTileDrops → block_drops; doTraderSpawning → spawn_wandering_traders; doVinesSpread → spread_vines; doWardenSpawning → spawn_wardens; doWeatherCycle → advance_weather; maxCommandChainLength → max_command_sequence_length; maxCommandForkCount → max_command_forks; naturalRegeneration → natural_health_regeneration; snowAccumulationHeight → max_snow_accumulation_height; spawnRadius → respawn_radius; spawnerBlocksEnabled → spawner_blocks_work. — [Game rule](https://minecraft.wiki/w/Game_rule); [Java Edition 1.21.11](https://minecraft.wiki/w/Java_Edition_1.21.11)
- Other camelCase rules were converted mechanically (e.g. `keepInventory` → `keep_inventory`, `mobGriefing` → `mob_griefing`, `fallDamage` → `fall_damage`); the wiki's explicit mapping only lists the non-mechanical renames. — [Game rule](https://minecraft.wiki/w/Game_rule)

Current game rule list (type, default) — [Game rule](https://minecraft.wiki/w/Game_rule):
- Chat: `command_block_output` (bool, true), `log_admin_commands` (bool, true), `send_command_feedback` (bool, true), `show_advancement_messages` (bool, true), `show_death_messages` (bool, true).
- Drops: `block_drops` (true), `block_explosion_drop_decay` (true), `entity_drops` (true), `mob_drops` (true), `mob_explosion_drop_decay` (true), `projectiles_can_break_blocks` (true), `tnt_explosion_drop_decay` (false).
- Misc: `command_blocks_work` (true), `global_sound_events` (true), `max_block_modifications` (int, 32768), `max_command_forks` (int, 65536), `max_command_sequence_length` (int, 65536), `max_minecart_speed` (int, 8; Minecart Improvements experiment), `reduced_debug_info` (false), `tnt_explodes` (true).
- Mobs: `forgive_dead_players` (true), `max_entity_cramming` (int, 24), `mob_griefing` (true), `raids` (true), `universal_anger` (false).
- Player: `allow_entering_nether_using_portals` (true), `drowning_damage` (true), `elytra_movement_check` (true), `ender_pearls_vanish_on_death` (true), `fall_damage` (true), `fire_damage` (true), `fire_spread_radius_around_player` (int, 128), `freeze_damage` (true), `immediate_respawn` (false), `keep_inventory` (false), `limited_crafting` (false), `locator_bar` (true), `natural_health_regeneration` (true), `player_movement_check` (true), `players_nether_portal_creative_delay` (int, 0), `players_nether_portal_default_delay` (int, 80), `players_sleeping_percentage` (int, 100), `pvp` (true), `respawn_radius` (int, 10), `spectators_generate_chunks` (true).
- Spawning: `spawn_mobs` (true), `spawn_monsters` (true), `spawn_patrols` (true), `spawn_phantoms` (true), `spawn_wandering_traders` (true), `spawn_wardens` (true), `spawner_blocks_work` (true).
- World updates: `advance_time` (true), `advance_weather` (true), `lava_source_conversion` (false), `max_snow_accumulation_height` (int, 1), `random_tick_speed` (int, 3), `spread_vines` (true), `water_source_conversion` (true).
- Related 26.1 UX: game rules screen reachable in-game via the new World Options pause-menu screen, with a search bar matching ID/name/description/category. — [Java Edition 26.1](https://minecraft.wiki/w/Java_Edition_26.1)

### Inferences
- The project CLAUDE.md's statement that gamerules "became snake_case in 26.x" is slightly off: the rename landed in 1.21.11 (December 2025), so it applies to 1.21.11+, including all 26.x releases.
- `/gamerule doDaylightCycle false` from an old tutorial should be taught as `/gamerule advance_time false`; `spawnRadius` → `respawn_radius`; `disableRaids true` → `raids false` (inverted).

### Gaps
- The Game rule page fetch did not state whether the `minecraft:` namespace prefix is required or optional in `/gamerule` (the 1.21.11 notes write names as `minecraft:advance_time`; this project's packs use the bare name successfully, implying it is optional, but no wiki text confirmed that).
- The current gamerule list is as of the wiki's live page (which tracks 26.3); whether any rules were added between 26.2 and 26.3 was not verified.
