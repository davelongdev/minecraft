# Existing vanilla Bed Wars data packs and maps (catalogue, techniques, licenses, 26.3 portability)

Researched 2026-10-26. Modrinth figures come from the Modrinth API (`api.modrinth.com/v2/project/<slug>` and `/version`), and GitHub facts from `gh api` plus reading the source tarballs (read only, nothing run). Planet Minecraft returned HTTP 403 to the fetch tool, so PMC facts come from search-result snippets only.

## Which Bed Wars data packs/maps exist, and what do they offer?

### Takeaway
Three vanilla packs are current and worth looking at: **JK's BedWars ToolPack** (jkbw; GPL-3.0; 26.2 released, and the GitHub `main` branch already declares pack format 121 = 26.3), **ACT Bedwars** (GPL-3.0; nine built-in maps; 26.2 on Modrinth, but GitHub source stops at 1.21.11), and **JuNi4/Bedwars** (MIT; 1.21.6–1.21.11, map/shop addon API). Everything else is either old (1.13–1.20), unfinished, or unlicensed.

### Cited Findings

**JK's BedWars ToolPack ("jkbw"), by JesKi13567 / "JK137"**
- Modrinth: 10,017 downloads, published 2024-11-04, updated 2026-09-08, license GPL-3.0-or-later, versions 1.20 through 26.2 — [Modrinth API / page](https://modrinth.com/datapack/jkbw)
- Latest Modrinth file is 1.2.2 (2026-09-08), for 26.2. 1.2.1 and 1.2 cover 1.21.11 and 26.1–26.1.2 — [Modrinth versions](https://modrinth.com/datapack/jkbw)
- CurseForge: 1,709 downloads, updated Sep 8 2026, GPLv3 — [CurseForge](https://www.curseforge.com/minecraft/data-packs/jkbw)
- GitHub `JesKi13567/BedWars`: 20 stars, GPL-3.0, last push 2026-10-09. The README heading reads "v1.2.3 for MC26.3", and `pack.mcmeta` on `main` is `min_format: 121, max_format: 121` (unreleased as of this research). 657 files — [GitHub](https://github.com/JesKi13567/BedWars)
- Features: Simplified Chinese and English, up to 8 teams and 64 players, items placed with spawn eggs, a Test Mode (solo play, free shopping), an admin board (Clean / Convert / Rotate maps), a "Control Panel" (shop prices, rotating items, max upgrade tiers, phase timers). Player settings cover bed type (Default/Covered/Cake), resource speed 0.5–2.0, 1.8 vs 1.9 attack speed, 2–8 teams, random or manual teams, and time of day. Resource modes are Classic / Xp / URF. Experimental modes are Blitz, No Jumps, Lilliput, Beds of Fortune, Patpat, Color Blind, Armed (guns), and Zero Friction. Overworld only. **Ships no maps**: "Server admins can start the game simply by providing maps and placing items as per in-game instructions" — [Modrinth description](https://modrinth.com/datapack/jkbw)
- Also on PMC as "jk-s-bedwars-toolpack" and on MCMOD (mcmod.cn/class/10014) — [Modrinth description links](https://modrinth.com/datapack/jkbw)

**ACT Bedwars, by atomic-cogwheel0**
- Modrinth: 2,764 downloads, published 2025-09-26, updated 2026-08-25, GPL-3.0-only, versions 1.21.8, 1.21.11, 26.2. Needs the companion "ACT Bedwars Resource Pack" (custom textures and en-US translation strings) — [Modrinth](https://modrinth.com/datapack/act-bedwars)
- Versions: v2.3 (2026-08-25) is for 26.2, and v2.2.2 (2026-02-20) for 1.21.11 (1,467 downloads) — [Modrinth versions](https://modrinth.com/datapack/act-bedwars)
- GitHub `atomic-cogwheel0/act-bedwars`: GPL-3.0, last commit 2026-02-20, `pack.mcmeta` = format 94 (1.21.11). **The 26.2 v2.3 source isn't on GitHub**, only the Modrinth zip — [GitHub](https://github.com/atomic-cogwheel0/act-bedwars)
- Features: 9 hand-built maps (Tree, Village, Crypt, Graveyard, Worlds, Moon Base, Ships, Tunnels, Mines), a prebuilt lobby with sign-based team/map selection, villager trading, spawner upgrades at an "Upgraded Trader", cracked emeralds, currency looting on kill, wind-charge double jumps, a shrinking world border that eventually breaks all beds, trial-key Vault loot boxes, exotic loot minecarts, skeleton "protectors", enchanting, mini iron golems, a hardcore mode, and a config scoreboard. Uses custom dimensions (the world shows the experimental-settings warning) — [Modrinth description](https://modrinth.com/datapack/act-bedwars)
- It's 4 teams (red/blue/green/yellow: `bed_broken/{red,blue,green,yellow}.mcfunction`) — [GitHub source](https://github.com/atomic-cogwheel0/act-bedwars/tree/main/datapack/bedwars/data/bw/function/bed_broken)

**JuNi4/Bedwars ("Bedwars in Vanilla Minecraft by JuNi & DM8AT")**
- GitHub: MIT ("Copyright (c) 2025 JuNi4"), last commit 2026-09-30. Releases: v1.2.2 (2026-09-30) ships separate zips for 1.21.6 and 1.21.11, with tiny download counts (≤17 per asset). The `pack.mcmeta` on main still says `pack_format: 74` — [GitHub](https://github.com/Juni4/Bedwars), [releases](https://github.com/Juni4/Bedwars/releases)
- README: for "1.21.6 and up". Use a Void superflat world, simulation distance ≥ 16, at least 2 players, `/function bedwars:setup`, a settings menu for the team count, and a start button. It auto-resets 10 s after the game ends. The pack "will DELETE an area around 0 0" — [README](https://github.com/Juni4/Bedwars)
- Ships maps as 45 structure `.nbt` files (maps default, fortress, planetoid, resin_rush, shapes, skyblock, snow_globe) and a separate `Bedwars_Extras` addon (FNAF-style "animatronics" maps, a math library) — [GitHub tree](https://github.com/Juni4/Bedwars)

**Older or smaller vanilla packs**
- **Bedwars Datapack** (DEMnetwork / Arthur Yoshikasu Arakaki): Modrinth, 1,312 downloads, updated 2024-01-27, MIT, 1.19.4–1.20, "INDEV", support for 1.20 "THEORICAL" — [Modrinth](https://modrinth.com/datapack/bedwars-datapack), [GitHub](https://github.com/DEM-Network-Corporation/bedwars)
- **Barrel Shops** (dark-ember): a shop-only pack "designed for bedwars", 110 downloads, 1.21, All Rights Reserved — [Modrinth](https://modrinth.com/datapack/barrel-shops)
- **Throwable Fire Charges** (o-Peepo): a Hypixel-style fireball item only, 20,026 downloads, up to 26.2, All Rights Reserved — [Modrinth](https://modrinth.com/datapack/throwable-fire-charges)
- **LeeCom BedWars** (LeeLux): 8 teams, 26 settings, a multi-page custom shop, map cloning and auto clearing, stats. The README says it's "unfinished and kind of broken", with the 1.21 conversion incomplete and only 1.19.2 fully working. `pack_format: 26` in the `functions/` (plural) layout. License CC BY-NC-SA 4.0. Maps and resource pack live in separate repos — [GitHub](https://github.com/LeeLux/LeeCom-BedWars)
- **Bedwars 1v1** (bobbydeveloper), a CurseForge *world*: 12,382 downloads, main file 1.21.8, updated 2025-08-17, Apache-2.0. Two islands, iron/gold/diamond/emerald generators, an item shop, upgrades, "designed to run entirely with a datapack, no plugins required" — [CurseForge](https://www.curseforge.com/minecraft/worlds/bedwars1v1)
- **Working Bedwars Datapack** (TBC_Miles, PMC): Minecraft 1.13, about 28k downloads, forges, generators, shop NPCs with GUI, team upgrades with GUI, spawn-egg setup (search-snippet info only; page blocked) — [PMC](https://www.planetminecraft.com/data-pack/working-bedwars-datapack/)
- **BedWars creator** (PMC): 1.21, last updated 2025-09-23, WIP, "code is a mess", shop unfinished, island protection described as likely infeasible. Uses spawn eggs to detect bed breaks (snippet) — [PMC](https://www.planetminecraft.com/data-pack/bedwars-creator/)
- **Bedwars** (PMC id 4700358): places beds via a spawn egg over two coloured carpets (snippet) — [PMC](https://www.planetminecraft.com/data-pack/bedwars-4700358/)
- GitHub search (`gh search repos bedwars datapack`, `--language=mcfunction`) also turns up small or unlicensed repos: `dvdcd/bedwars-datapack` (GPL-3.0, archived, 2023, "emulate … bedwars reloaded"), `OrngJuice/Minecraft-Datapack-Bedwars-1.16` (no license), `mabino/nomod-bedwars` (2021, no license), `TapsHTS/auria-bw` (2024, no license), `spaceriku123/space-bedwars-datapack` (MIT, 2024, Japanese), `mogu6321/BedWars_datapack` (2025, no license), `jorus1133-gif/full-bedwars-datapack` (2026-10-16, no license), and `edlrod/open-bedwars` (TypeScript datapack generator, 2026-02, no license) — [GitHub search](https://github.com/search?q=bedwars+datapack&type=repositories)
- Paid map builds (schematics, need WorldEdit) are sold on BuiltByBit, e.g. "BedWars 4v4 Arenas | x3 Themed Maps", with a native 1.21.8 version — [BuiltByBit](https://builtbybit.com/resources/bedwars-4v4-arenas-x3-themed-maps.110045/)

**Plugins (brief comparison only)**
- Screaming BedWars: LGPL-3.0, 23,228 Modrinth downloads, supports 26.2/26.3, modes BedWars/EggWars/AnchorWars/CakeWars, multiple shops per arena, fast arena rebuild, Bungee/Velocity, spectators — [Modrinth](https://modrinth.com/plugin/screamingbedwars), [CurseForge](https://www.curseforge.com/minecraft/bukkit-plugins/screamingbedwars)
- BedWars1058: GPL-3.0, 44,996 downloads, last Modrinth update 2025-05-25, 1.8.8–1.21.4. Custom teams, scoreboards, shop, team upgrades. World restore works by zipping and unzipping maps (SlimeWorldManager suggested) — [Modrinth](https://modrinth.com/plugin/bedwars1058), [GitHub fork note](https://github.com/ahdg6/bedwars1058)
- A host guide (Aug 2026) calls BedWars1058 "no longer viable" on 26.2 and recommends Screaming BedWars. It lists MBedwars as paid (EUR 19.99), tested on 26.1/26.2 — [GameServerKings](https://www.gameserverkings.com/knowledge-base/minecraft/start-a-bedwars-server/)
- Newer 26.2/26.3 plugins: "New Bedwars" (GPL-3.0, updated 2026-10-21), Wueffi's MiniGameCore "BedWars" (PolyForm Noncommercial), "L-Bedwars" (AGPL-3.0) — [Modrinth plugin search](https://modrinth.com/plugins?q=bedwars)

### Inferences
- jkbw is the most complete and the only one already targeting 26.3 on its default branch. But it's a *toolkit*: you build or supply the map, then mark points with its spawn eggs. ACT is the only one that ships a full set of ready maps in the pack.
- The plugin feature set (multi-arena, holograms, Vault rewards, proxies) mostly matters for public networks. The vanilla packs cover the core loop (teams, generators, shop, upgrades, bed break, reset).

### Gaps
- PMC pages (jkbw's PMC entry, TBC_Miles, BedWars creator) couldn't be fetched (HTTP 403), so their exact versions, dates, and licenses are unverified beyond search snippets.
- minecraftmaps.com didn't appear in any search, so I found no Java Bed Wars maps there.
- No CurseForge world search beyond bedwars1v1 (the CurseForge API needs a key). Other CurseForge Bed Wars worlds may exist.

## How do they implement the key pieces?

### Takeaway
They all detect bed breaks with a `minecraft.mined:minecraft.<colour>_bed` stat plus a per-tick "is the block still a bed?" check at a marker. Generators are timed `summon item` at markers. Shops are villager trades (ACT, JuNi4) or a chest/ender-chest item GUI (jkbw, LeeCom). Armour is `leather_*[dyed_color=…]`. Protection is adventure mode with `can_place_on`/`can_break` item components plus clearing a block tag. Reset is either `place template` of shipped structures (ACT, JuNi4) or `fill air replace #placeable_tag` (jkbw).

### Cited Findings
- **Bed-break detection (jkbw)**: per-team objectives `scoreboard objectives add jkbw.Player.Break.Bed.blue mined:blue_bed` (who broke it). A per-tick macro `execute ... at @n[type=text_display, tag=jkbw_bed_$(team)] unless block ~ ~ ~ #jkbw:bed run scoreboard players set $$(team) jkbw.Bed.State 2` marks a team bedless, then counts alive players and eliminates. A break by your own team routes to `bed/break/2` — [jkbw source](https://github.com/JesKi13567/BedWars/tree/main/data/jkbw/function/state/1/bed)
- **Bed-break detection (ACT)**: `scoreboard objectives add redBedsBroken minecraft.mined:minecraft.red_bed`. The tick runs `execute at @e[type=armor_stand,tag=RedBed] unless block ~ ~ ~ red_bed unless block ~ ~ ~ end_portal_frame run function bw:bed_broken/red`. If the breaker is on red, `replace_bed/red` restores the bed with "You can't break your own bed!". Otherwise it broadcasts, plays a sound, replaces the bed with an end portal frame, gives the team a `trial_key`, and kills dropped bed items — [ACT bed_broken/red](https://github.com/atomic-cogwheel0/act-bedwars/blob/main/datapack/bedwars/data/bw/function/bed_broken/red.mcfunction)
- JuNi4 also uses `minecraft.mined:minecraft.{red,blue,lime,yellow}_bed`, and overrides `loot_table/blocks/<colour>_bed.json` so beds drop nothing — [JuNi4 source](https://github.com/Juni4/Bedwars/tree/main/Bedwars/data)
- **Generators (jkbw)**: a per-team countdown `jkbw.Res.CD.Iron`. On 0 it runs `summon item ~ ~ ~ {Age:-32768, PickupDelay:18, Invulnerable:True, Item:{id:"iron_ingot",count:4}, Tags:["jkbw_res","jkbw_res_iron"]}` (count 8 at upgrade tier 4+). It caps the pile by merging into one 48-stack once ≥ 12 items are present. If an adventure-mode player stands within 2 blocks, it `give`s ingots directly (tagged `can_break`). Items are `ride`-mounted on the marker so explosions can't knock them away — [jkbw res/team/iron/1](https://github.com/JesKi13567/BedWars/blob/main/data/jkbw/function/state/1/res/team/iron/1.mcfunction)
- **Generators (JuNi4)**: macro `execute as @e[tag=$(spawner)_spawner] if score @s spawn_cooldown matches ..0 at @s run summon item ~ ~1 ~ {Invulnerable:1b,Item:{id:"$(item)",count:$(count)},Age:$(age)}`, then reset to `spawn_cooldown_max` — [JuNi4 spawners/spawn](https://github.com/Juni4/Bedwars/blob/main/Bedwars/data/bedwars/function/spawners/spawn.mcfunction)
- **Shop = villager trades (ACT)**: `setvillagers_unified` clears `Offers.Recipes`, then appends trades per team spawn, e.g. `{maxUses:1600000, buy:{id:"iron_ingot",count:4}, sell:{id:"red_wool",count:16}}`, with components in the sell item (attribute modifiers, enchantments, fireworks, custom names). Map-specific trade sets are switched by a `villagerType` score — [ACT setvillagers_unified](https://github.com/atomic-cogwheel0/act-bedwars/blob/main/datapack/bedwars/data/bw/function/setvillagers_unified.mcfunction)
- **Shop = villager (JuNi4)**: macro `summon villager ~ ~ ~ {NoGravity, Invulnerable, VillagerData:{level:5,profession:"minecraft:weaponsmith"}, Tags:["$(team)_item_shop"], Offers:{Recipes:$(items)}}`, with the trade list built from a `shop_item_registry` function tag so addons can add items, plus a marker anchor that keeps it in place — [JuNi4 shop/summon_item_shop](https://github.com/Juni4/Bedwars/blob/main/Bedwars/data/bedwars/function/shop/summon_item_shop.mcfunction)
- **Shop = ender-chest GUI (jkbw)**: a shop ender chest block (marked by a `text_display`) has its `Items` set from the opening player's `EnderItems` (per-player pages). Shop items carry `custom_data={jkbw:["shop"]}`. Each tick `clear @s *[custom_data~{jkbw:["shop"]}] 0` detects that a player pulled one out, runs `shop/buy`, then clears it. Currency is counted with `execute store result score ... run clear @s iron_ingot 0`. An XP-level currency mode also exists — [jkbw shop/global](https://github.com/JesKi13567/BedWars/blob/main/data/jkbw/function/state/1/shop/global.mcfunction), [chest/player/common](https://github.com/JesKi13567/BedWars/blob/main/data/jkbw/function/state/1/shop/gui/chest/player/common.mcfunction)
- **Barrel Shops** encodes price and result in the display item's components, e.g. `dirt[custom_data={shop:{bought:false},iron_price:2,gold_price:1,resultitem:{…}}]`, inside a storage block — [Modrinth](https://modrinth.com/datapack/barrel-shops)
- LeeCom uses an inventory GUI (`invgui/page1..3`) and a multi-page custom shop — [LeeCom tree](https://github.com/LeeLux/LeeCom-BedWars)
- **Team armour**: jkbw uses macro `item replace entity @s armor.head with leather_helmet[custom_data={jkbw:["clean"]}, enchantments={aqua_affinity:1, binding_curse:1}, attribute_modifiers=[], unbreakable={}, dyed_color=$(color)]` (binding curse stops removal) — [jkbw team/loop/armor/equip](https://github.com/JesKi13567/BedWars/blob/main/data/jkbw/function/state/1/team/loop/armor/equip.mcfunction). ACT uses `item replace entity @a[team=red] armor.head with leather_helmet[dyed_color=16718602]` — [ACT source](https://github.com/atomic-cogwheel0/act-bedwars)
- **Teams**: vanilla `/team` (`team add jkbw.red {text:"红队", color:"red"}`), with up to 8 colours in jkbw — [jkbw _install](https://github.com/JesKi13567/BedWars/blob/main/data/jkbw/function/state/0/init/_install.mcfunction)
- **Block protection (jkbw)**: players are in adventure mode. Every bought block, tool, and generator item gets `can_place_on={blocks:"#jkbw:canplaceon"}` / `can_break={blocks:"#jkbw:candestroy"}` with `tooltip_display={hidden_components:[can_break,can_place_on]}`. Tags list wool, terracotta, stained glass, end stone, etc. The pack also overrides vanilla block loot tables (e.g. `loot_table/blocks/blue_wool.json`) and filters out vanilla recipes, advancements, and loot tables in `pack.mcmeta` — [jkbw pack.mcmeta](https://github.com/JesKi13567/BedWars/blob/main/pack.mcmeta), [tags](https://github.com/JesKi13567/BedWars/tree/main/data/jkbw/tags/block)
- **Map reset (jkbw)**: "Clean" runs a macro `fill ~-$(r1) ~ ~-$(r1) ~$(r1) ~ ~$(r1) air replace #jkbw:candestroy` around the map point. Only player-placeable block types are removed and the admin's map stays. "Convert" swaps any such blocks in the original map to other blocks first — [jkbw _clean](https://github.com/JesKi13567/BedWars/blob/main/data/jkbw/function/state/0/panel/contents/map/point/_clean.mcfunction), [Modrinth admin board table](https://modrinth.com/datapack/jkbw)
- **Map reset (ACT)**: each `load_map/<map>` wipes the custom `bw:bedwars` dimension (`air_fills`), then rebuilds from structures shipped in the pack (68 `.nbt` files), e.g. `place template ships:emerald_island -20 1 -23`, `place template ships:ship_red -50 15 24 clockwise_90`. It then fixes waterlogged trapdoors, kills items, and resets villagers — [ACT load_map/ships](https://github.com/atomic-cogwheel0/act-bedwars/blob/main/datapack/bedwars/data/bw/function/load_map/ships.mcfunction)
- **Map reset (JuNi4)**: `reset` → `setup/delete_islands`, then the maps are rebuilt from 45 structure files via a `map_registry` function tag API (`maps/api/create_base_island`, `create_diamond_island`, `create_middle_island`) — [JuNi4 reset](https://github.com/Juni4/Bedwars/blob/main/Bedwars/data/bedwars/function/reset.mcfunction)
- **Point placement**: jkbw, PMC packs, and TBC_Miles place bed, generator, and shop points with spawn eggs carrying `entity_data` for markers. jkbw uses `minecraft.used:<x>_spawn_egg` stats to detect placement — [jkbw source](https://github.com/JesKi13567/BedWars/tree/main/data/jkbw/function/state/0/eggs), [Modrinth feature list](https://modrinth.com/datapack/jkbw)
- **World rules**: jkbw sets `gamerule keep_inventory true`, `immediate_respawn true`, `mob_griefing false`, `limited_crafting true`, `fire_spread_radius_around_player 0`, `max_block_modifications 1000000000`, and `locator_bar false` (all snake_case, i.e. already 1.21.11+ names) — [jkbw source](https://github.com/JesKi13567/BedWars)
- **ACT extras**: custom dimension types with `attributes` (`gameplay/bed_rule` `can_sleep: never`, `explodes: false`) and `timelines`, plus a `pause_screen_additions` dialog tag adding a "tp to lobby" dialog — [ACT dimension_type](https://github.com/atomic-cogwheel0/act-bedwars/tree/main/datapack/bedwars/data/bw/dimension_type)

### Inferences
- The mined-stat + block-check combo is the standard approach and maps straight onto the repo's existing marker/score patterns. The block check catches TNT and explosions, which the stat alone misses.
- ACT's "dimension + place template from pack structures" reset is the same shape as Game Forge's per-game dimensions. jkbw's "fill air replace tag" is simplest but needs the map built from non-placeable blocks.
- Villager trades are the most kid-readable shop (vanilla UI, no GUI hacks). The jkbw ender-chest GUI is cleverer but harder to follow.

### Gaps
- I didn't read the trap, upgrade, or team-chest code in depth. How each pack handles elimination and respawn timers was only skimmed.

## Which are open source, and what's their architecture?

### Takeaway
jkbw (GPL-3.0), ACT (GPL-3.0), and JuNi4 (MIT) have readable source on GitHub. jkbw is organised by game state, ACT by feature with shipped structures and dimensions, and JuNi4 as a registry/addon API.

### Cited Findings
- jkbw: a single `jkbw` namespace, `function/state/0/` (lobby/setup: `button`, `eggs`, `init`, `panel`, `shop/price`, `ticks`) and `state/1/` (in game: `bed`, `hurt`, `ppl`, `res`, `shop`, `team`, `special/item/gun`…). Settings and text are in storage `jk:bw`, heavily using macros (`function … {team:'red', color:'red'}`). Loot tables provide special items (bridge egg, tower, platform, guns, happy ghast). 657 files, bilingual comments in Chinese — [GitHub tree](https://github.com/JesKi13567/BedWars)
- ACT: the namespace `bw` plus one namespace per map holding structures (`crypt`, `graveyard`, `mines`, `moon_base`, `ships`, `tree`, `tunnels`, `village`, `worlds`). Function folders: `bed_broken`, `replace_bed`, `load_map`, `upgrade`, `border`, `entities/{bridge_egg,happy_ghast}`, `gui`, `on_death`, `map_creation` (armor-stand spawn eggs for new maps). It has predicates (`in_game`, `in_lobby`, `inside_map`), custom dimensions `bw:bedwars`/`bw:lobby`, and loot pools for vaults. The README says new maps use `/function bw:map_creation/eggs` and `/function bw:map_creation/villagers` — [GitHub](https://github.com/atomic-cogwheel0/act-bedwars)
- JuNi4: the namespace `bedwars` with folders `game`, `maps/<map>`, `maps/api`, `rotary_items`, `shop`, `shop_items/{armor,blocks,potions,tools,utilities}`, `spawners`, `team_upgrades`. Function tags `map_registry`, `shop_item_registry`, `rotary_item_registry`, `on_setup`, `on_reset`, and `item_tick` let a second pack (`Bedwars_Extras`) add maps and items — [GitHub](https://github.com/Juni4/Bedwars)
- LeeCom has readable source too, but under a NonCommercial-ShareAlike license, with generated `maps/process/clone/1-100/...` chunks — [GitHub](https://github.com/LeeLux/LeeCom-BedWars)

### Inferences
- For teaching kids, JuNi4's registry design (add a shop item = add a function to a tag) and ACT's one-file-per-team bed functions are the easiest to read. jkbw's macro-heavy, Chinese-commented code is the most capable but hardest to follow.

### Gaps
- The ACT 26.2 (v2.3) source isn't on GitHub, so what changed for 26.2 is unknown without unpacking the Modrinth zip (not done).

## Which would be easiest to port to 26.3 (pack format 121)?

### Takeaway
jkbw needs essentially no port: its `main` branch already declares `min_format/max_format 121` with snake_case gamerules and component syntax. Next easiest is ACT (1.21.11 / format 94 source, already components and snake_case, 26.2 build exists). JuNi4 (1.21.6–1.21.11) is close. LeeCom, DEMnetwork, dvdcd, OrngJuice, and mabino are pre-1.21 (`functions/` plural, `pack_format`, NBT item syntax) and would be rewrites.

### Cited Findings
- jkbw `pack.mcmeta`: `"min_format": 121, "max_format": 121`. The README is titled "v1.2.3 for MC26.3". Its gamerules are the 1.21.11+ snake_case names, and items use components (`dyed_color=`, `can_break={blocks:…}`, `tooltip_display={hidden_components:[…]}`) — [GitHub](https://github.com/JesKi13567/BedWars)
- ACT repo `pack.mcmeta`: `min_format: 94, max_format: 94` (1.21.11). Its v2.3 on Modrinth is marked 26.2. Its dimension_type uses the 1.21.11-era `attributes` + `timelines` fields, and the README warns that major versions are incompatible with upgrading an existing world — [GitHub](https://github.com/atomic-cogwheel0/act-bedwars), [Modrinth versions](https://modrinth.com/datapack/act-bedwars)
- JuNi4 ships separate 1.21.6 and 1.21.11 builds, the source `pack.mcmeta` still uses `pack_format: 74`, and the directories are singular (`function/`, `loot_table/`) — [GitHub releases](https://github.com/Juni4/Bedwars/releases)
- LeeCom: `pack_format: 26`, `data/bw/functions/`, `tags/blocks/`; its author says the 1.21 conversion is incomplete — [GitHub](https://github.com/LeeLux/LeeCom-BedWars)
- mabino/nomod-bedwars (2021) uses `data/bw/functions/` and `tags/functions/` — [GitHub](https://github.com/mabino/nomod-bedwars)

### Inferences
- For ACT, the probable 26.3 work is bumping the format and re-checking its custom dimension/dimension_type JSON against 26.3's world-clock and timeline schema (this repo's `game-forge/tools/gen_dims.py` already had to handle per-dimension `world_clock`). Shipped structure `.nbt` files load across versions via DataFixer when placed.
- Any of the three would need the Game Forge port treatment (`tools/port.py`: run in a dimension, `distance=0..` selectors, comment out gamerules). jkbw's "overworld only" and global `gamerule` lines would need patching for that, and ACT already uses its own dimensions.
- jkbw sets `gamerule pvp` and other world-wide rules that would collide with the shared Game Forge world, which is another reason to keep them per dimension or comment them out.

### Gaps
- I didn't load any pack in 26.3, so "ready for 26.3" for jkbw rests on its `pack.mcmeta` and README, not a test.

## Map-maker tutorials or YouTube series worth borrowing from

### Takeaway
I found no substantial current command-based "make Bed Wars with commands" tutorial series. The best technique sources are the open pack sources themselves. YouTube has older milesplayz "vanilla Bed Wars map" videos, and most web guides are plugin-based.

### Cited Findings
- YouTube: "How To Make A Working Bed Wars Map IN VANILLA" and "Fully Working Vanilla Bed Wars Map w/ Download" (milesplayz channel, per search snippet; content not verified) — [video 1](https://www.youtube.com/watch?v=cOsSQ5WyQwk), [video 2](https://www.youtube.com/watch?v=NhM2eEuEHQ0)
- Sportskeeda's vanilla guide only suggests building sky islands with barriers underneath. It has no step-by-step commands — [Sportskeeda](https://sportskeeda.com/minecraft/news-how-make-play-minecraft-bedwars)
- Most "how to make Bed Wars" guides are plugin setup (`/bedwars create …`, `/bw admin … pos1/pos2`) — [BedwarsRel wiki](https://bitbucket.org/STRMarius/bedwarswiki/wiki/How%20to%20create%20an%20arena), [SparkedHost](https://help.sparkedhost.com/en/article/how-to-make-a-minecraft-bedwars-server-1a3jm3c.md)
- Techniques visible across the packs and worth borrowing: spawn-egg point placement (jkbw, ACT `map_creation/eggs`, TBC_Miles), the mined-stat + `unless block` bed check, bed loot tables emptied, generators as invulnerable `summon item` with `Age:-32768` and pile caps, villager `Offers.Recipes` built from data, adventure + `can_place_on`/`can_break`, and reset by `place template` or `fill … replace #tag` — [jkbw](https://github.com/JesKi13567/BedWars), [ACT](https://github.com/atomic-cogwheel0/act-bedwars), [JuNi4](https://github.com/Juni4/Bedwars)

### Inferences
- The milesplayz videos may be by the same creator as TBC_Miles' 1.13 PMC pack (the name is similar), which would make them outdated syntax. This is unconfirmed.

### Gaps
- I couldn't watch videos or confirm their dates and versions. Search found no 1.21+/26.x command-based Bed Wars tutorial series.

## Licensing: can we reuse code or map builds for a small nonprofit kids' program on a private LAN server?

### Takeaway
Yes for jkbw and ACT (GPL-3.0) and JuNi4/DEMnetwork/space-bedwars (MIT): running modified copies on a private server isn't "conveying" under GPLv3, and if we ever share the zip we must keep it GPL with source. LeeCom (CC BY-NC-SA) is usable for a nonprofit with attribution and share-alike. Anything with no license (OrngJuice, mabino, TapsHTS, mogu6321, jorus1133, most PMC packs) and the All-Rights-Reserved Modrinth items are all rights reserved: read for ideas only, don't copy.

### Cited Findings
- GPLv3 defines conveying as enabling others to make or receive copies, and "Mere interaction with a user through a computer network, with no transfer of a copy, is not conveying." You may run and modify privately without conditions — [GNU GPLv3 text](https://www.gnu.org/licenses/gpl-3.0.html)
- jkbw: GPL-3.0-or-later (Modrinth), GPLv3 (CurseForge), and the GitHub license file is gpl-3.0 — [Modrinth](https://modrinth.com/datapack/jkbw), [CurseForge](https://www.curseforge.com/minecraft/data-packs/jkbw)
- ACT: GPL-3.0-only, covering the repo including the map structure files in `datapack/` — [GitHub](https://github.com/atomic-cogwheel0/act-bedwars)
- JuNi4: MIT, © 2025 JuNi4 — [GitHub LICENSE](https://github.com/Juni4/Bedwars/blob/main/LICENSE)
- DEMnetwork Bedwars Datapack: MIT — [Modrinth](https://modrinth.com/datapack/bedwars-datapack)
- LeeCom BedWars: CC BY-NC-SA 4.0, © 2024 LeeLux — [GitHub](https://github.com/LeeLux/LeeCom-BedWars); NonCommercial means "not primarily intended for or directed towards commercial advantage or monetary compensation" — [CC BY-NC-SA 4.0 legal code](https://creativecommons.org/licenses/by-nc-sa/4.0/legalcode)
- Bedwars 1v1 world: Apache-2.0 (CurseForge listing) — [CurseForge](https://www.curseforge.com/minecraft/worlds/bedwars1v1)
- Barrel Shops and Throwable Fire Charges: LicenseRef-All-Rights-Reserved — [Modrinth Barrel Shops](https://modrinth.com/datapack/barrel-shops), [Modrinth Throwable Fire Charges](https://modrinth.com/datapack/throwable-fire-charges)
- No license file (GitHub API reports none): OrngJuice/Minecraft-Datapack-Bedwars-1.16, mabino/nomod-bedwars, TapsHTS/auria-bw, mogu6321/BedWars_datapack, jorus1133-gif/full-bedwars-datapack, HolyGuizhi/BEDWARS-DataPack — [GitHub search](https://github.com/search?q=bedwars+datapack&type=repositories)
- BuiltByBit map builds are paid commercial resources with their own terms — [BuiltByBit](https://builtbybit.com/resources/bedwars-4v4-arenas-x3-themed-maps.110045/)

### Inferences
- Mixing GPL code (jkbw or ACT) into our own pack makes the combined pack GPL *if distributed* (e.g. handing zips to kids' laptops or publishing). Running it only on the studio box imposes nothing. Keeping attribution and a copy of the license in the pack is cheap either way.
- ACT's maps are GPL along with its code, so the builds are reusable under the same terms. jkbw ships no maps.

### Gaps
- PMC packs' license fields couldn't be read (403). Treat them as all rights reserved unless the page says otherwise.
- I'm not a lawyer, so the GPL "private server" reading is from the license text, not legal advice.
