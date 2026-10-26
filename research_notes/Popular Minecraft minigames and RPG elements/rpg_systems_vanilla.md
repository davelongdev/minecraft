# RPG systems in vanilla Minecraft Java 26.3 (data pack format 121)

Source key: "26.3 jar" = checked locally on 2026-10-26 by listing/extracting `~/.var/app/org.prismlauncher.PrismLauncher/data/PrismLauncher/libraries/com/mojang/minecraft/26.3/minecraft-26.3-client.jar` (its `version.json`: `"id": "26.3"`, `data_major` 121, `resource_major` 97, Java 25, built 2026-09-15). "Repo" = something this project already does, path under `/home/dave/minecraft/`. Jar checks prove an identifier exists, not its exact field layout, unless a vanilla JSON file was read.

## What do top Minecraft RPGs (Wynncraft, Hypixel SkyBlock, MCC Island, Origin Realms, adventure maps, Modrinth RPG packs) do, and what systems do they share?

### Takeaway
The big servers are all built on server-side plugins plus a server resource pack, not data packs, yet the systems they share (classes, per-skill levelling with stat rewards, point-buy stats, an unlockable ability tree, collections/milestones, pets with rarity, quests from NPCs, rarity-tiered gear, a currency) each have a workable vanilla data-pack equivalent; the one fully-vanilla example found, the Aeternum data pack, proves classes + an ability item + mana + quests are doable without mods.

### Cited Findings
**Wynncraft**
- Five main classes (Archer, Warrior, Mage, Assassin, Shaman), each with a reskinned counterpart (Hunter, Knight, Dark Wizard, Ninja, Skyseer); each class keeps its own progress; switch with `/class` — [Wynncraft Wiki: Class](https://wynncraft.wiki.gg/wiki/Class)
- Skill points: 2 per level, capped at 200 at level 101; spent on five element-tied stats (Strength, Dexterity, Intelligence, Defence, Agility); manual cap 100 per stat, items can raise it to 150; since 2.0 points can be reallocated freely while inside a city — [Wynncraft Wiki: Class](https://wynncraft.wiki.gg/wiki/Class), [Agility](https://wynncraft.wiki.gg/wiki/Agility), [Defense](https://wynncraft.wiki.gg/wiki/Defense)
- Ability Tree: Ability Points from combat levels (1 at level 1 up to 50 at level 120), 70+ upgrades per class, opened from the compass item; a node must connect to one you already own; right-click undoes a pick before closing; a full reset costs 3 Ability Shards — [Wynncraft Wiki: Ability Tree](https://wynncraft.wiki.gg/wiki/Ability_Tree)

**Hypixel SkyBlock**
- Thirteen skills that level automatically from actions (Combat 60, Farming 60, Fishing 50, Mining 60, Foraging 60 …); each level grants a permanent stat (e.g. Combat → crit chance, Mining → defense, Farming → health), coins, and "SkyBlock XP"; minions give reduced skill XP; a "Wisdom" stat boosts skill XP; a "skill average" excludes Social, Runecrafting, Dungeoneering — [Hypixel SkyBlock Wiki: Skills](https://hypixelskyblock.minecraft.wiki/w/Skills)
- Collections: per-item gathering milestones that unlock recipes, trades, or permanent stat buffs, grouped by skill; one wiki draft counts 86 item collections + 8 boss collections — [Hypixel SkyBlock Wiki draft: Collections](https://hypixelskyblock.minecraft.wiki/w/User:Thundercraft5/Drafts/Collections), [Boss Collections](https://hypixelskyblock.minecraft.wiki/w/Boss_Collections)
- Pets: rarity COMMON → MYTHIC, most max at level 100 (three dragons at 200); a summoned pet earns XP when you earn XP in its skill; stats/perks scale with level and rarity; each pet holds one Pet Item (free to apply, coins to remove); "Pet Score" (+1..+6 per unique pet by rarity) unlocks Magic Find thresholds; Pets Menu holds 112 by default — [Hypixel SkyBlock Wiki: Pets](https://hypixelskyblock.minecraft.wiki/w/Pets), [Pet Item](https://hypixelskyblock.minecraft.wiki/w/Pet_Item)

**MCC Island / Origin Realms**
- MCC Island's support site says it aims to be "as rich and engaging as possible in pure vanilla" (vanilla client), with client mods only an optional boost; Noxcrew's own Fabric client mod Noxesium lets the server modify the client and feeds data to other mods — [MCC Island support: performance](https://support.mccisland.net/Improving-your-Performance-1b6739c7bb4f8061840cfe91ac04d24b), [Noxesium on Modrinth](https://modrinth.com/mod/Noxesium)
- Origin Realms ships a server resource pack with custom blocks/items (community mods add middle-click pick for "custom Origin Realms blocks" and a "Server Pack Unlocker"); an officially endorsed client mod, Origin Enhanced, adds hotkeys — [OriginAddons (modpackindex)](https://www.modpackindex.com/mod/112844/originaddons), [Origin Enhanced (modpackindex)](https://www.modpackindex.com/mod/121537/origin-enhanced)

**Adventure maps**
- Diversity 3: co-op multi-genre map; you complete a monument by collecting wool from themed branches (puzzle, parkour, combat, adventure); last listed release v1.6.6 for 1.14.4 — [BoxToPlay: Diversity 3](https://www.boxtoplay.com/en/minecraft-hosting/minecraft-server/curseforge-maps/map-diversity-3-35)

**Vanilla RPG data packs (Modrinth)**
- Aeternum (data pack, "inspired by the Origins mod", 1.21.2–1.21.4 per its compatibility list): 16 classes, 400+ abilities; first class picked at a class table in plains villages (or `/loot give @s loot aeternum:class_table`); level a class to 10 to "master" it and pick another; abilities learned from class scrolls (tooltip shows required class/level); an un-droppable "ability wheel" item, right-click to cast, swap slot by pressing F (offhand swap), up to 8 slots; energy (mana) regenerates and is shown on the wheel, cost ≈ ability level; each class levels by its own action (Archer: bow kills, Druid: hoes, Alchemist: brewing); quest merchants (five quests per class) that require the matching class; loot boxes counting right-clicked emeralds on an `interaction` entity's scoreboard; settings via `/trigger aeternum.config` — [Aeternum on Modrinth](https://modrinth.com/mod/aeternum-rpg)
- "RPG skill tree" pack is a data pack for the pufferfish's skills **mod** (8 classes; 1.21.3–1.21.11), i.e. not vanilla-only — [BoxToPlay mirror of the Modrinth listing](https://www.boxtoplay.com/en-cw/minecraft-hosting/minecraft-server/modrinth-datapacks/rpg-skill-tree-81200); Skill Tree (RPG Series) and More RPG Classes are Fabric/NeoForge mods — [Modrinth: skill-tree](https://modrinth.com/mod/skill-tree/versions), [Modrinth: classes0](https://modrinth.com/mod/classes0)

### Inferences
- Shared core across all of them: (1) a class or build choice, (2) several levelled skills each tied to an action and paying out a stat, (3) a point-buy or unlock tree gated on level, (4) collections/milestones that unlock things, (5) rarity tiers on gear and pets, (6) NPC-given quests, (7) a currency + shop, (8) one "menu item" (Wynncraft compass, Aeternum wheel, Game Forge's Magic Compass) as the entry to everything.
- Aeternum's tricks map directly onto this repo: un-droppable menu item = the Magic Compass (`game-forge/`), offhand-swap (F) as a selector input, `interaction` entity + scoreboard as a clickable container, `/trigger` for player settings (already Dave's pattern in npc-game).
- Wynncraft's "only respec in a city" and the connected-node rule are cheap to copy with a location predicate and an advancement `parent` chain.
- For kids designing tabletop games first: classes ≈ character sheets, skills ≈ stat tracks, collections ≈ sticker charts, pets ≈ companion cards; each is a scoreboard or two plus a dialog.

### Gaps
- No reliable source found for Wynncraft's quest/quest-book mechanics or MCC Island's progression (fishing, badges, cosmetics) details; no official Origin Realms docs on how its items work. These servers' code is proprietary plugins (Paper/custom), so their *implementation* can't be cited, only their designs.
- No fetched source on CTM maps or Diversity's internals; Diversity 3's last listed version is 1.14.4, so its command tricks are pre-component and not reusable as-is.
- Modrinth/Planet Minecraft data packs targeting 26.3 specifically weren't found; Aeternum is listed up to 1.21.4 and would need porting (components, predicates, loot table keys all changed since).

## RPG systems and their vanilla 26.3 implementation

### Takeaway
Every listed system has a vanilla building block in 26.3: attributes (`/attribute`, `attribute_modifiers`), scoreboards/storage for levels and saves, advancement tabs for trees and quest logs, dialogs for menus/shops/quest text, item components for custom gear and consumables, loot tables + `/random` for drops and dice, data-driven enchantments with `run_function` for custom effects, structures/`place template` for dungeons; the main 26.3 trap is that loot table/predicate JSON keys changed (`modifier` / `condition` / `type`), so pre-26 tutorials' JSON won't load.

### Cited Findings
**Classes and stats (attributes)**
- `/attribute` syntax: `attribute <target> <attribute> get [<scale>]`, `… base get|set <value>|reset`, `… modifier add <id> <value> add_value|add_multiplied_base|add_multiplied_total`, `… modifier remove <id>`, `… modifier value get <id>`; `<id>` is a resource location (single `id` since 1.21, replacing uuid+name; operation names since 1.20.5; `base reset` since 1.21.4); only players, armor stands, and mobs have attributes; permission level 2 — [minecraft.wiki: Commands/attribute](https://minecraft.wiki/w/Commands/attribute)
- 26.3 jar contains attribute ids useful for class stats: `max_health`, `attack_damage`, `attack_speed`, `armor_toughness`, `movement_efficiency`, `jump_strength`, `scale`, `gravity`, `safe_fall_distance`, `entity_interaction_range`, `block_interaction_range`, `minecraft:luck`, `camera_distance`, `waypoint_transmit_range` — 26.3 jar (string grep; field-by-field registry not dumped)
- `attribute_modifiers` item component = list of `{type, id, amount, operation, slot, display}`; `slot` ∈ any/hand/armor/mainhand/offhand/head/chest/legs/feet/body/saddle; `display` type default/hidden/override; example `/give @s stick[attribute_modifiers=[{type:"minecraft:scale",slot:"hand",id:"example:grow",amount:4,operation:"add_multiplied_base"}]]` — [minecraft.wiki: Data component format](https://minecraft.wiki/w/Data_component_format)
- Repo precedent: jump-game-2 applies a temporary `jump_strength` modifier for +40% height and removes it on cooldown — repo `CLAUDE.md` (`jump-game-2/`)

**Levels / XP**
- Two options: vanilla XP (`/xp`, `/experience`; `Experience` command class present in 26.3 jar) or scoreboards. Vanilla advancement trigger list in 26.3 includes the event hooks most RPG XP sources need: `player_killed_entity`, `player_hurt_entity`, `entity_hurt_player`, `consume_item`, `inventory_changed`, `item_used_on_block`, `placed_block`, `fishing_rod_hooked`, `bred_animals`, `tame_animal`, `brewed_potion`, `enchanted_item`, `villager_trade`, `player_interacted_with_entity`, `location`, `changed_dimension`, `using_item`, `recipe_crafted`, `player_generates_container_loot`, `killed_by_arrow`, `target_hit`, `effects_changed`, `item_durability_changed`, `spear_mobs`, `tick`, `impossible` — 26.3 jar (`data/minecraft/advancement/**`, triggers actually used by vanilla files)
- Scoreboard stat criteria (`minecraft.custom:minecraft.jump`, `minecraft.used:…`) are already how this repo detects jumps, book use, and button placement; `deathCount` still camelCase — repo `CLAUDE.md` (commands-tutorial `tut_jump`, npc-game `npc_placed`, one-block_2 `ob_deaths`)
- Since 26.3, `/compute <target> integer <int_provider>` / `float <float_provider> [<scale>]` (targets `default`, `block <pos>`, `entity <selector>`) evaluates a number provider, failing on e.g. division by zero; 26.3 also added context int/float provider registries with arithmetic, random, and environment types plus `minecraft:product/minimum/maximum/average/conditional/weighted_list` number providers — [minecraft.wiki: Java Edition 26.3](https://minecraft.wiki/w/Java_Edition_26.3); `ComputeCommand` class and `command.compute.result.*` strings present — 26.3 jar; `data/minecraft/context_int_provider/` and `context_float_provider/` folders exist — 26.3 jar

**Skill trees**
- Advancements give a free, client-rendered tree UI: own tab per `root` advancement with `parent` links; `impossible` trigger + `/advancement grant` for "unlocked" nodes; `rewards.function` runs code on grant — repo npc-game's "NPC Forge" tab (`advancement/root.json` with `minecraft:tick`, `three_npcs.json` `impossible`, `rewards.function` = `internal/unlock_island`) — repo `CLAUDE.md`
- Wynncraft's tree requires connected nodes and a paid reset — [Wynncraft Wiki: Ability Tree](https://wynncraft.wiki.gg/wiki/Ability_Tree) (vanilla equivalent: check `advancements={ns:parent=true}` in a selector before granting; `advancement revoke … from ns:root` as the respec, already used by npc-game's `___reset_player`)

**Quests and quest logs**
- Dialog types in 26.3: `notice`, `confirmation`, `multi_action`, `dialog_list`, `server_links` (classes `NoticeDialog`, `ConfirmationDialog`, `MultiActionDialog`, `DialogListDialog`, `ServerLinksDialog`); inputs `text`, `boolean`, `single_option`, `number_range`; actions `run_command`, `suggest_command`, `open_url`, `copy_to_clipboard`, `change_page`, `show_dialog`, `dynamic/run_command`, `dynamic/custom`; vanilla ships `dialog/custom_options.json`, `quick_actions.json` (a `dialog_list` over tag `#minecraft:quick_actions`), `server_links.json`; `/dialog show|clear` — 26.3 jar
- Repo has a working quest engine (commands-tutorial: per-player `tut_sec`/`tut_ex`, `start/tick/check` per quest, dialog per quest, "I did it!" button → `/trigger`) and NPC dialogs built inline by macro (npc-game) — repo `CLAUDE.md`
- Written books for quest logs: commands-tutorial and npc-game regenerate a per-progress book (`book_<n>`) from Python — repo `CLAUDE.md`

**Custom items / equipment** (component names confirmed present in 26.3 jar: `custom_data`, `item_model`, `custom_name`, `item_name`, `lore`, `rarity`, `enchantment_glint_override`, `tooltip_display`, `attribute_modifiers`, `consumable`, `use_cooldown` (with `cooldown_group`), `use_remainder`, `food`, `equippable` (`asset_id`), `death_protection`, `weapon` (`item_damage_per_attack`, `disable_blocking_for_seconds`), `tool`, `blocks_attacks`, `enchantable`, `repairable`, `damage_resistant`, `glider`, `max_damage`, `max_stack_size`, `kinetic_weapon`, `piercing_weapon`, `swing_animation`, `use_effects`, `minimum_attack_charge`, `attack_range`, `damage_type`, `break_sound`) — 26.3 jar
- Formats: `custom_data` = any compound; `item_model="minecraft:diamond_sword"`; `custom_name={text:"Magic Wand",color:"light_purple",italic:false}`; `item_name` is not anvil-removable and not italic; `consumable={consume_seconds:3.0,animation:'eat',sound:'entity.generic.eat',has_consume_particles:true,on_consume_effects:[{type:'minecraft:clear_all_effects'}]}`; `equippable={slot:legs,asset_id:"minecraft:diamond"}` plus optional `equip_sound`, `allowed_entities`, `dispensable`, `swappable`, `damage_on_hurt`, `equip_on_interact`, `camera_overlay`; `death_protection={death_effects:[…]}` — [minecraft.wiki: Data component format](https://minecraft.wiki/w/Data_component_format) (wiki page tracks the current release; field lists not re-checked against 26.3 beyond the names above)
- Consume-effect types in 26.3: `apply_effects`, `remove_effects`, `clear_all_effects`, `teleport_randomly`, `play_sound` (classes under `world/item/consume_effects/`) — 26.3 jar
- New 26.3 components: `attack_animation`, `interact_animation` (`whack`/`stab`, duration), `block_transformer`, `brewing_fuel`, `cooking_fuel`, `compostable`, `mob_visibility` (`targeting_entity`, `visibility` 0–10), `sign_text_front/back`, `villager_food`, `waxed` — [minecraft.wiki: Java Edition 26.3](https://minecraft.wiki/w/Java_Edition_26.3)
- Detecting a right-click on a custom item: `carrot_on_a_stick` + `minecraft.used:minecraft.carrot_on_a_stick` stat (repo's Magic Compass); a plain compass's use can't be detected; `custom_data` sub-predicate in `execute if items entity @s weapon.* *[custom_data~{…}]` (one-block_2 keys) — repo `CLAUDE.md`. A `consumable` component on any item plus the `consume_item` advancement trigger is the other route (inferred from jar contents above, not tested).

**Loot tables and random drops**
- **26.3 loot table JSON uses new keys**: entries carry `"modifier"` (a single object or a list) whose entries are `{"type": "minecraft:set_count", …}` (old: `"functions": [{"function": …}]`) and `"condition"` objects with `"type"` (old: `"conditions": [{"condition": …}]`); across vanilla loot tables there are 0 occurrences of `functions`/`function`/`conditions`, 1098 of `modifier`, 1526 of `condition`; example `chests/simple_dungeon.json`: `{"type":"minecraft:item","modifier":{"type":"minecraft:set_count","count":{"type":"minecraft:uniform","min":1,"max":5}},"name":"minecraft:leather","weight":20}` — 26.3 jar (`data/minecraft/loot_table/**`)
- Modifier types used by vanilla 26.3 loot tables: `set_count`, `explosion_decay`, `enchanted_count_increase`, `copy_components`, `set_potion`, `enchant_randomly`, `enchant_with_levels`, `apply_bonus`, `set_damage`, `furnace_smelt`, `exploration_map`, `filtered`, `discard`, `set_enchantments`, `set_name`, `set_components`, `limit_count`, `copy_state`, `set_stew_effect`, `set_ominous_bottle_amplifier`, `set_instrument`; conditions: `survives_explosion`, `match_block`, `entity_properties`, `any_of`, `all_of`, `inverted`, `table_bonus`, `killed_by_player`, `random_chance`, `random_chance_with_enchanted_bonus`, `location_check`, `damage_source_properties`, `match_tool`; entry types `item`, `loot_table`, `alternatives`, `empty`, `dynamic`, `tag` — 26.3 jar
- 26.3 adds `minecraft:command_slot_source` loot table type (for `/item` and `/execute` slot sources) and `int_value_check`/`float_value_check` predicates — [minecraft.wiki: Java Edition 26.3](https://minecraft.wiki/w/Java_Edition_26.3); third-party mod docs mention an `item_modifier` registry being reachable from loot code in 26.3 — [LootInj on Modrinth](https://modrinth.com/mod/lootinj) (secondhand)
- `/loot give|spawn|insert … loot <table>` (`Loot` command class present) — 26.3 jar; Aeternum gives its class table via `/loot give @s loot aeternum:class_table` — [Aeternum](https://modrinth.com/mod/aeternum-rpg)

**Dice rolls**
- `/random value|roll <min>..<max> [<sequence>]`, `/random reset *|<sequence> [<seed> …]`; `roll` broadcasts, `value` shows only to the runner; range size 2..2147483646; level 0 without a sequence, level 2 with one or for reset; added 1.20.2 — [minecraft.wiki: Commands/random](https://minecraft.wiki/w/Commands/random); `commands.random.roll` strings present — 26.3 jar; repo Section 2 quest 5 "Roll the Dice" uses `random roll 1..6` in a command block — repo `CLAUDE.md`
- Store a roll: `execute store result score @s d20 run random value 1..20` (standard store pattern; not run in 26.3 for this note).

**Custom mobs / bosses**
- `Summon`, `Attribute`, `Damage`, `Rotate`, `Swing`, `Ride`, `Waypoint` command classes and `bossbar` present — 26.3 jar; 26.3 entity data adds an `invulnerable_time` tag — [minecraft.wiki: Java Edition 26.3](https://minecraft.wiki/w/Java_Edition_26.3)
- Repo pattern for persistent NPC-like mobs: villager body `NoAI`/`Invulnerable` + `interaction` + `text_display`, self-heal after 40 missing ticks, kill duplicates — repo `CLAUDE.md` (npc-game, game-forge)

**Dungeons**
- `Place` command class (template/structure/jigsaw/feature), `structure` and `worldgen` data folders present — 26.3 jar; repo uses `place template` from shipped `structure/*.nbt` (game-forge `___restore_hub`) and SAVE-mode structure blocks (one-block_2) — repo `CLAUDE.md`
- Repo warning: a structure saved by a redstone-pulsed structure block may only live in memory until restart (unverified) — repo `CLAUDE.md`
- `trial_spawner` data folder exists in 26.3 (data-driven trial spawner configs) — 26.3 jar (contents not inspected)

**Shops / economy**
- Villager trades are data-driven in 26.3: `data/minecraft/villager_trade/` and `trade_set/` folders — 26.3 jar (format not inspected; check before using). Repo NPCs use empty `Offers:{Recipes:[]}` and dialogs instead — repo `CLAUDE.md`
- Aeternum's merchant is a summoned trader that sells class scrolls/stones and replaces 60% of wandering trader spawns — [Aeternum](https://modrinth.com/mod/aeternum-rpg)

**Crafting / upgrades**
- `recipe` data folder (custom crafting/smithing recipes can output component-carrying items); `enchantable`/`repairable` components; `/enchant`; anvil `anvil_cost` on enchantments — 26.3 jar

**Parties**
- `Team`, `TeamMsg` command classes present — 26.3 jar; repo uses team prefixes for medals and team colour → `sidebar.team.<colour>` for per-game sidebars — repo `CLAUDE.md` (game-forge). Party = team + shared score; no vanilla party UI.

**Per-player saves**
- Pattern: permanent id score (`ob_id`, `npc_pid`) + list in command storage (`storage npc:main names [{pid,name}]`) read via macros (`$(pid)`) and `nbt` text components — repo `CLAUDE.md` (one-block_2, npc-game). Game Forge's merge tool copies each game's `data/<ns>` storage into the hub world — repo `CLAUDE.md`

**Custom enchantments (data-driven)**
- 26.3 ships 44 enchantment JSON files; a definition has `description`, `supported_items`, `primary_items`, `exclusive_set`, `weight`, `max_level`, `min_cost`/`max_cost`, `anvil_cost`, `slots`, `effects`; e.g. sharpness = `"minecraft:damage": [{"effect":{"type":"minecraft:add","value":{"type":"minecraft:linear","base":1.0,"per_level_above_first":0.5}}}]`; thorns = `"minecraft:post_attack"` with `affected`/`enchanted`, `all_of` of `damage_entity` + `change_item_damage`, and `requirements` `random_chance` — 26.3 jar (`data/minecraft/enchantment/*.json`)
- Effect components in 26.3: `damage`, `damage_protection`, `damage_immunity`, `knockback`, `armor_effectiveness`, `post_attack`, `post_piercing_attack`, `hit_block`, `item_damage`, `attributes`, `equipment_drops`, `location_changed`, `tick`, `ammo_use`, `projectile_*`, `block_experience`, `mob_experience`, `repair_with_xp`, `smash_damage_per_fallen_block`, `prevent_equipment_drop`, `prevent_armor_change`, crossbow/trident ones; entity-effect types seen: `damage_entity`, `apply_mob_effect`, `ignite`, `explode`, `summon_entity`, `spawn_particles`, `play_sound`, `replace_disk`, `apply_impulse`, `apply_exhaustion`, `change_item_damage`, and `run_function` exists as a string — 26.3 jar. `run_function` in `post_attack` is the hook for "on hit, run my mcfunction as the victim/attacker" (layout not read from a vanilla file; check misode).

### Inferences
- Class = a tag (`class.mage`) + a set of `attribute modifier add <ns>:class_<stat>` calls on pick and `remove` on respec; gear stats via `attribute_modifiers` so they only apply while held/worn.
- Level-up checks run cheaply off advancement triggers (e.g. `player_killed_entity` → reward function → `advancement revoke` to re-arm) instead of tick polling.
- Mana: a scoreboard regenerated by a 1 s clock (repo already has `clock tut_const`), shown on the actionbar or a `rarity`/`lore`-styled item; `use_cooldown` gives a native client cooldown overlay for ability items.
- Dice-heavy tabletop rules: `/random value` into a score, then `execute if score … matches` branching; `/compute` can fold "2d6+STR" into one number provider in 26.3 (syntax for providers not tested here).
- Loot tables give "rarity tiers" for free via `weight` + `set_components`/`set_name`/`enchant_randomly`, but every JSON must use the 26.3 `modifier`/`condition`/`type` keys; misode's generator should be set to 26.3.

### Gaps
- When exactly the loot table key rename (`functions` → `modifier`, `conditions` → `condition`, `function` → `type`) landed (26.1, 26.2, or 26.3) wasn't found in a changelog; the repo notes the predicate `condition` → `type` change as 26.2. Treat it as "true for 26.3, verified in the jar".
- Exact JSON for `run_function`, `villager_trade`/`trade_set`, `trial_spawner`, and `/compute` providers wasn't read; inspect misode (set to 26.3) or the jar before writing them.
- `use_cooldown`, `weapon`, `tooltip_display`, `lore` field layouts weren't confirmed from the wiki fetch (truncated); names exist in the jar.

## 26.x-specific features useful for RPGs (verified names)

### Takeaway
The 26.x RPG toolbox beyond classic commands is: dialogs (menus, shops, quest text, forms), data-driven enchantments and loot with the new number/context providers, the item-component system (incl. 26.3's `attack_animation`, `interact_animation`, `mob_visibility`), `/random`, `/compute`, `/stopwatch`, `/swing`, `/waypoint`, `/fetchprofile`, and new value-check predicates — all present in the 26.3 jar.

### Cited Findings
- Command classes in the 26.3 jar (full list): Attribute, Chase, Compute, Damage, DataPack, Debug…, Dialog, Difficulty, Enchant, Execute, Experience, FetchProfile, Fill, FillBiome, ForceLoad, Function, GameMode, GameRule, Give, Help, Jfr, Kick, Kill, ListPlayers, Locate, Loot, Msg, Op, Particle, Perf, Place, PlaySound, PostEffect, Publish, Raid, Random, Recipe, Reload, Return, Ride, Rotate, SaveAll/Off/On, Say, Schedule, Scoreboard, Seed, ServerPack, SetBlock, SetSpawn, SetWorldSpawn, SpawnArmorTrims, Spectate, SpreadPlayers, Stop, StopSound, Stopwatch, Summon, Swing, Tag, Team, TeamMsg, Teleport, TellRaw, Tick, Time, Title, Transfer, Trigger, Unpublish, Version, Waypoint, Weather, Whitelist, WorldBorder — 26.3 jar (`net/minecraft/server/commands/*Command.class`)
- `/stopwatch` has create/query/restart/remove (`commands.stopwatch.*`); `/swing` targets living entities — 26.3 jar (strings). Useful for speedruns/boss timers and NPC "attack" animations (inferred).
- `/compute` (26.3) and `/posteffect` (26.3, client-side, server can't verify) — [minecraft.wiki: Java Edition 26.3](https://minecraft.wiki/w/Java_Edition_26.3); repo notes `/compute`/`/posteffect` don't exist in 26.2 — repo `CLAUDE.md`
- Data registries in 26.3 `data/minecraft/`: advancement, chat_type, damage_type, dialog, dimension_type, enchantment, enchantment_provider, instrument, jukebox_song, loot_table, predicate, recipe, structure, timeline, trade_set, trial_spawner, villager_trade, world_clock, worldgen, context_float_provider, context_int_provider, block_transformer, test_environment/test_instance, plus mob variants — 26.3 jar
- New 26.3 predicates `minecraft:int_value_check` / `float_value_check` and block predicate `minecraft:height_range` — [minecraft.wiki: Java Edition 26.3](https://minecraft.wiki/w/Java_Edition_26.3)
- Dialog is a world-load registry in 26.3 (needs re-entering the world, `/reload` won't pick it up); inline `dialog show @s {…}` built by macro avoids files — repo `CLAUDE.md` (checked in `RegistryDataLoader` earlier)
- `world_clock` + `timeline` let each dimension keep its own time of day — repo `CLAUDE.md` (game-forge `gen_dims.py`)

### Inferences
- Dialog `multi_action` = shop/skill-pick menu; `dialog_list` = a "character sheet" index; `number_range`/`single_option` + digit option ids through `/trigger` = op-free point-buy (repo found only numeric `/trigger` payloads avoid the "Confirm Command Execution" screen).
- Custom `damage_type` files allow named damage ("slain by Fireball") for spells (inferred from the registry's presence).

### Gaps
- `/chase`'s purpose wasn't checked (class exists; likely a debug/dev command).
- 26.3's full data-pack changelog section (attributes, dialogs, advancements) wasn't fully read; the wiki page is ~470k characters and only parts were fetched.

## Pitfalls and performance limits

### Takeaway
Most failures are silent (bad JSON or a bad function line drops the whole file), old tutorials use pre-26 JSON and pre-1.21 syntax, and lag comes from per-tick `@e` scans and NBT reads; prefer advancement triggers, scope selectors, and keep tick functions small.

### Cited Findings
- Advice: use advancement-triggered functions instead of per-tick checks; always put `type=` in `@e`; keep anything not needing every tick out of tick functions; split work so fewer commands run each tick (forum advice from 2020, not benchmarks) — [Planet Minecraft forum: datapacks started lagging](https://www.planetminecraft.com/forums/minecraft/datapacks/datapacks-started-lagging-618305/)
- Reading entity NBT copies the whole entity's NBT (e.g. `data get entity @s Health`); the Bellows mod claims 50–60% tick-time cuts for large data packs by limiting that, and fixes chunks staying loaded when `execute if block` runs on them each tick — [Bellows on Modrinth](https://modrinth.com/project/qHxCUweJ) (mod author's claim)
- Vanilla `inventory_changed` trigger was measured at ~20% of tick time on one test server (Icterine mod brought it to 7.5%) — [Icterine on Modrinth](https://modrinth.com/mod/icterine) (single-server claim)
- Repo-learned 26.x pitfalls: function parse errors silently drop the whole function (check `latest.log`); a macro line that can't parse fails the whole call; a bad predicate breaks the whole `/reload`; dialog files need a world re-entry; dialog/click commands needing op show "Confirm Command Execution", only `/trigger` with numbers avoids it; `fill` into unloaded chunks fails silently; entities load a few ticks after blocks (self-heal must wait ~40 ticks or duplicates appear); `pause-when-empty-seconds` stops tick functions on an empty server; `#minecraft:dirt` in 26.3 lacks grass; integer `positioned` coords are centre-corrected — repo `CLAUDE.md`
- Loot table/predicate JSON keys differ from pre-26 docs (see the loot section) — 26.3 jar

### Inferences
- Use `/tick` and `Perf`/`Jfr` (both present in 26.3) or Spark to profile before optimising.
- A dozen tick-scans per player × 20 players is fine; per-entity loops over all mobs (custom mob AI) are the usual lag source — keep custom mobs few and tagged.
- Store per-player RPG data in scores where possible (cheap), storage for strings/lists (macro cost), and avoid reading player NBT every tick.

### Gaps
- No measured, current (26.x) benchmarks for data-pack command costs were found; the figures above are mod authors' claims or old forum advice.
