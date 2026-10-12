# Alternative routes to "modding" Minecraft (not Java mods, not vanilla data/resource packs) — state as of 12 October 2026

Scope note: this covers every approach to changing or extending Minecraft *other than* writing a Java mod for Fabric/NeoForge and *other than* vanilla Java data packs / resource packs. Version context at time of writing: Java Edition latest release is 26.3 (26.4 in snapshots), Bedrock latest is 26.52 with 26.60 in preview — per the Minecraft Wiki version sidebar as seen on 12 Oct 2026 ([minecraft.wiki](https://minecraft.wiki/w/Minecraft_Live_2025)). Mojang's year-based numbering (26.1 = first 2026 drop, 26.1.1 = its first hotfix) was announced in December 2025 ([PaperMC 1.21.11 post, 21 Dec 2025](https://papermc.io/news/1-21-11)).

---

## 1. Server plugins: Paper / Purpur / Folia / Spigot / Bukkit API, Velocity and other proxies

### Takeaway
Server plugins are server-side-only JVM code (Java, Kotlin, Groovy, Scala) loaded into a dedicated server such as Paper; they cannot add client-side content (new blocks/items/rendering) and do not run in singleplayer. Paper, Spigot, Purpur, Skript, and Denizen all already support Minecraft 26.3 (September 2026), and Paper's docs at docs.papermc.io are the canonical learning resource.

### Cited Findings

**What Paper/Bukkit plugins are and can do**
- Paper plugins are "written in JVM-based languages such as Java, Kotlin, Groovy or Scala", packaged as a `.jar` in the server's `plugins` folder with a main class extending `JavaPlugin`; lifecycle is `onLoad` → `onEnable` → `onDisable` — [docs.papermc.io: How do plugins work](https://docs.papermc.io/paper/dev/how-do-plugins-work/)
- Plugin capabilities documented: event listeners (e.g. `PlayerJoinEvent`, some cancellable), registering commands usable by players/console/RCON/command blocks with hierarchical permissions, a YAML configuration API, a tick-based scheduler (20 ticks/sec), and rich-text via the bundled Adventure "Component" library — [docs.papermc.io: How do plugins work](https://docs.papermc.io/paper/dev/how-do-plugins-work/)
- Paper's developer docs enumerate API areas: Command, Event, Entity, Inventory, Scheduling, Recipes, Particles, Dialog API, Component API, persistent data containers, plus "Getting started" guides (project setup, plugin.yml, paperweight-userdev) — [docs.papermc.io/paper](https://docs.papermc.io/paper/)
- Paper describes itself as a Java Edition game server "designed to greatly improve performance and offer more advanced features and API" and is "a drop-in replacement for both CraftBukkit and Spigot" — [docs.papermc.io: Getting started](https://docs.papermc.io/paper/getting-started/)
- Paper 26.x "requires at least **Java 25** to run"; 1.20–1.21.11 needed Java 21, 1.17–1.19 Java 17. Run with e.g. `java -Xms4G -Xmx4G -jar paper.jar --nogui` — [docs.papermc.io: Getting started](https://docs.papermc.io/paper/getting-started/)

**26.x version support (as of Oct 2026)**
- Paper's download API lists version groups 26.3 (26.3, 26.3-rc-3), 26.2 (26.2, 26.2-rc-2), 26.1 (26.1.2, 26.1.1), then 1.21.x and older — [fill.papermc.io/v3/projects/paper](https://fill.papermc.io/v3/projects/paper)
- Paper's 26.3 announcement (26 Sep 2026): new API for player post-processing effects, new events (entity breaking, construction from block patterns, entity collisions, Sulfur Cube item swallowing), "Much of the API previously marked experimental, including most of the data component API, is now stable"; `PlayerAnimationEvent`, `PotionEffectTypeCategory`, `PotionBrewer` deprecated; a Bukkit/Spigot/Paper config merge "is for this to land in the next major release, aka 26.4"; "After upgrading your world to 26.3, you cannot downgrade back to a lower version!" — [papermc.io/news/26-3](https://papermc.io/news/26-3)
- Paper's 1.21.11 post (21 Dec 2025): with Mojang's deobfuscation, "Mojang will stop providing obfuscated server jars" from 26.1, so Paper "will **fully drop the internal remapper in 26.1**"; plugins using Spigot-mapped internal (NMS) names break on 26.1; developers were told to test with `-Dpaper.disablePluginRemapping=true` and drop the `reobfJar` step from paperweight-userdev — [papermc.io/news/1-21-11](https://papermc.io/news/1-21-11)
- Spigot 26.3 can be built via BuildTools (`java -jar BuildTools.jar --rev 26.3`); 26.3's version metadata specifies Java 25 (guide dated 18 Sep 2026) — [hub.tcno.co Spigot 26.3](https://hub.tcno.co/games/minecraft/26.3/server/spigot/); a mirror site lists a 15 Sep 2026 release date for Spigot 26.3 but claims Java 21, which conflicts with the Java 25 figure — [doomhosting](https://www.doomhosting.com/minecraft-server-download/spigot/26.3)
- Purpur is "based on Paper", supports plugins built for the Bukkit, Spigot, and Paper APIs, and aims to offer "as much configurability as possible"; docs at purpurmc.org/docs/purpur — [purpurmc.org](https://purpurmc.org/); a French host blog reported Purpur had a first 26.3 build around 16 Sep 2026 with stable builds expected days later — [minestrator.com](https://minestrator.com/blog/article/minecraft-263-comment-preparer-son-serveur-au-troisieme-drop-de-2026)
- Folia is "a fork of Paper that adds regionized multithreading to the dedicated server"; its docs page was last updated Apr 22, 2025 and has a "Supporting Paper and Folia" developer guide — [docs.papermc.io/folia](https://docs.papermc.io/folia/), [docs.papermc.io/paper](https://docs.papermc.io/paper/)

**Proxies**
- Velocity is "the ridiculously scalable, flexible Minecraft proxy"; docs cover player information forwarding, securing servers, and a plugin API (events, scheduler, commands, plugin messaging) — [docs.papermc.io/velocity](https://docs.papermc.io/velocity/)
- Waterfall (the BungeeCord fork) docs say: "We recommend you transition to Velocity", linking to a PaperMC forum announcement — [docs.papermc.io/waterfall](https://docs.papermc.io/waterfall/)

**Scripting plugins (no Java compile cycle)**
- Skript "lets server owners customize their servers without learning Java"; it "requires Paper. Spigot is not supported"; it supports "the last 18 months of Minecraft versions"; cadence is "Two major feature updates ... each year in January and July, with monthly patches"; docs at docs.skriptlang.org — [github.com/SkriptLang/Skript](https://github.com/SkriptLang/Skript)
- Skript 2.16.2 was published 1 Sep 2026 and supports Paper 1.21.4 through 26.2 — [Hangar: Skript 2.16.2](https://hangar.papermc.io/SkriptLang/Skript/versions/2.16.2); 2.16.1 was 1 Aug 2026 (same range) — [Hangar: Skript 2.16.1](https://hangar.papermc.io/SkriptLang/Skript/versions/2.16.1); 2.14.0 (15 Jan 2026) had breaking changes around visual effects and potions — [Hangar: Skript 2.14.0](https://hangar.papermc.io/SkriptLang/Skript/versions/2.14.0)
- Denizen (MIT) is "NPC and general Spigot scripting, using the Denizen Scripting Language", tied to the Citizens NPC plugin; version 1.3.4 lists compatibility with Spigot 1.17.1, 1.18.2, 1.19.4, 1.20.6, 1.21.11, 26.1.2, 26.2, and 26.3; guide at guide.denizenscript.com, reference at meta.denizenscript.com — [github.com/DenizenScript/Denizen](https://github.com/DenizenScript/Denizen)
- EternalScript is a Paper plugin that loads `.kt`/`.kts` Kotlin files at runtime without restarts (search-result description only; not independently verified) — [search summary](https://modrinth.com/mod/katton)

**Singleplayer / LAN alternatives**
- Mojang's 26.2 Snapshot 7 (May 2026) added a "Multiplayer Options" screen letting a singleplayer world be opened to online play with "Invite to world" / "Request to join world", plus a Friends List on the title screen and pause menu; Mojang called it "a first version" — [minecraft.net 26.2 Snapshot 7](https://minecraft.net/en-us/article/minecraft-26-2-snapshot-7), [feedback.minecraft.net changelog](https://feedback.minecraft.net/hc/en-us/articles/45790287863437-Minecraft-Java-Edition-26-2-Snapshot-7); GamingOnLinux: "Minecraft Java finally gets a friends list and peer to peer multiplayer" (May 2026) — [gamingonlinux.com](https://www.gamingonlinux.com/2026/05/minecraft-java-finally-gets-a-friends-list-and-peer-to-peer-multiplayer/); third-party reports say Open to LAN was replaced by the new screen and that P2P hosting needs no port forwarding or IP sharing — [neowin.net](https://www.neowin.net/news/minecraft-java-edition-is-getting-peer-to-peer-multiplayer-support-from-mojang/)
- Hosting provider comparison: Realms "don't support mods or plugins"; plugin platforms such as Paper "require a dedicated server instead" — [xgamingserver.com](https://xgamingserver.com/blog/what-are-minecraft-realms/)

### Inferences
- Plugins are strictly server-side: the Paper docs never discuss client rendering or new block/item registration, and plugin discovery is via the server's `plugins/` folder, so a plugin cannot add genuinely new blocks/items/models the way a mod can (it can only re-skin vanilla ones via resource packs + custom model data). This is an inference from the documented API surface.
- There is no singleplayer plugin path: Paper/Spigot/Purpur are dedicated-server jars; for a classroom you'd run a Paper server on the teacher's machine (localhost/LAN) and have kids connect by IP. The new vanilla P2P "Online" feature (26.2+) only shares vanilla singleplayer worlds and does not load plugins.
- Skript and Denizen are the only mainstream "no-compile" plugin routes; both are current for 26.x. Skript's 18-month support window means older-version tutorials go stale fast.
- The 26.1 remapper removal means pre-26.1 plugins that touched server internals (NMS) break; pure Bukkit/Paper-API plugins are largely unaffected.

### Gaps
- No official Paper page states that plugins "do not run in singleplayer" in those words; this is inferred from architecture.
- Could not confirm a stable (non-experimental) Purpur 26.3 build or a Folia 26.3 build from primary sources.
- The Waterfall EOL announcement text/date (forums.papermc.io/threads/1088) was not fetched.
- No primary-source learning-resource comparison (e.g., Kotlin plugin templates) beyond docs.papermc.io.

---

## 2. Scripting mods that avoid Java compile cycles

### Takeaway
Current and maintained: KubeJS (JavaScript, Fabric/Forge/NeoForge, 26.1 branch active Oct 2026), CC: Tweaked (Lua computers, 26.3 builds Sep 2026), CraftTweaker (ZenScript, still on 1.21.1 — no 26.x branch), Mineflayer (Node.js bots, 1.8–26.1), Katton (Kotlin scripts, 26.1.x). Dead or end-of-life: ScriptCraft (last commit Sep 2017), RaspberryJuice (EOL), mcpi (last release Oct 2021), original OpenComputers (1.12.2, no port planned).

### Cited Findings

**KubeJS (JavaScript on Fabric/Forge/NeoForge)**
- KubeJS "lets you write JavaScript scripts to customize a Minecraft modpack or server"; JavaScript runs on a fork of the Rhino engine that converts code to Java classes at runtime; loaders Forge and Fabric (Architectury shared code); scripts can "Manage a server", "Add new blocks and items", "Change recipes", "Add custom handlers for quest mods"; folders `startup_scripts/`, `server_scripts/`, `client_scripts/`; limits: "Registry changes need a game restart, and worldgen changes need a world restart"; versions below 1.21 are "on your own" — [kubejs.com](https://kubejs.com/)
- GitHub branches: `2601` last updated Oct 5, 2026; `2101` Sep 18, 2026; `2001` May 1, 2026; older branches (1902, 1802 …) 2023–2024 — [github.com/KubeJS-Mods/KubeJS branches](https://github.com/KubeJS-Mods/KubeJS/branches/all)
- Third-party listings show a NeoForge build "KubeJS-NeoForge-26.1.2-8.0.4" and NeoForge 1.21.1 build 2101.7.2-build.368 dated May 13, 2026; GDLauncher lists loaders as NeoForge, Forge, Fabric, Quilt — [boxtoplay listing](https://www.boxtoplay.com/en/minecraft-hosting/minecraft-server/modrinth-mods/kubejs-291), [mado-hosting](https://www.mado-hosting.com/en/minecraft-mods/kubejs), [gdlauncher](https://gdlauncher.com/mods/modrinth/kubejs)

**CraftTweaker / ZenScript**
- GitHub branches: `1.21.1` last updated Sep 2, 2026; `1.12` Jul 30, 2026; `1.16` Jul 8, 2026; `1.20.1` Mar 17, 2026; **no 26.x branch exists** — [github.com/CraftTweaker/CraftTweaker branches](https://github.com/CraftTweaker/CraftTweaker/branches/all)
- Official 1.21 migration guide notes removed `LootingLevelEvent` (NeoForge) with "no replacement", `ResourceLocation` constructor replaced by `parse`/`fromNamespaceAndPath` — [docs.blamejared.com 1.21 migration](https://docs.blamejared.com/1.21/en/1_21_migration_guide)
- GDLauncher listing (updated May 7, 2026): CraftTweaker supports 1.21.1 on Forge, Fabric, and NeoForge; 217.8M downloads — [gdlauncher.com](https://gdlauncher.com/mods/curseforge/crafttweaker)

**CC: Tweaked (Lua computers in-game)**
- CC: Tweaked "adds programmable computers, turtles and more", a fork of ComputerCraft for "better performance and stability"; programs are Lua (Cobalt runtime, Lua 5.2/5.3 feature reference); turtles move, place/break blocks, attack; peripherals include speakers, monitors, modems, printers, disk drives, inventory access; `http` module and WebSockets; installs from Modrinth for Forge and Fabric; site "Last updated on 2026-10-05" — [tweaked.cc](https://tweaked.cc/)
- GitHub releases: 1.120.3 (26.3) 28 Sep [2026] pre-release ("Fix compatibility with latest NeoForge"); 1.120.2 (26.3) 17 Sep; 1.120.2 for 26.2 / 1.21.1 / 1.20.1 on 08 Aug; 1.120.0 for 26.2, 26.1.2, 1.21.1, 1.20.1 in mid-June — [github.com/cc-tweaked/CC-Tweaked/releases](https://github.com/cc-tweaked/CC-Tweaked/releases)

**OpenComputers**
- Original OpenComputers (MightyPirates): "There are currently no active plans for porting this mod to newer Minecraft versions" (1.12.2 era) — [modrinth.com/mod/opencomputers](https://modrinth.com/mod/opencomputers); a mirror notes "this version of the mod is no longer maintained. Potential security issues may still exist" — [mado-hosting](https://www.mado-hosting.com/en/minecraft-mods/opencomputers)
- "OpenComputers: Rebooted" is a community NeoForge port for 1.21.1 "under active development" (source github.com/CaitlynMainer/OpenComputers) — [curseforge.com OpenComputers Rebooted](https://www.curseforge.com/minecraft/mc-mods/opencomputers-rebooted/); "OpenComputers II: Reimagined" is a WIP fork of OC2 — [moddex.gg](https://moddex.gg/mod/oc2r)

**ScriptCraft (JavaScript server plugin) — DEAD**
- ScriptCraft: write mods in JavaScript as `.js` files in a plugins folder, `/js` in-game prompt, Drone building object, aimed partly at young programmers; ran on SpigotMC, GlowStone, CanaryMod; install docs reference Spigot 1.10.2 — [github.com/walterhiggins/ScriptCraft](https://github.com/walterhiggins/ScriptCraft)
- Most recent commit on master: **September 23, 2017** — [ScriptCraft commits](https://github.com/walterhiggins/ScriptCraft/commits/master)

**mcpi / RaspberryJuice (Python control of a Java server) — END OF LIFE**
- mcpi is a "Python library for communicating with Minecraft: Pi edition and RaspberryJuice"; `pip3 install mcpi`; Python 2 and 3 — [github.com/martinohanlon/mcpi](https://github.com/martinohanlon/mcpi)
- mcpi PyPI release history: 1.2.1 Oct 31, 2021 (current); 1.2.0 Apr 19, 2020; 1.1.0 May 1, 2018 — [pypi.org/project/mcpi](https://pypi.org/project/mcpi/#history)
- RaspberryJuice is a Bukkit plugin implementing the Minecraft Pi Socket API over TCP port 4711 (get/set blocks, positions, chat, block-hit events, `spawnEntity`, `setSign`); latest plugin version 1.12.1; the repo says it is "end of life" with no further releases planned and pull requests no longer accepted — [github.com/zhuowei/RaspberryJuice](https://github.com/zhuowei/RaspberryJuice)
- mcpi-e is an education-oriented fork; latest listed builds are 0.3.2006.x (~2020) — [pypi.org/project/mcpi-e](https://pypi.org/project/mcpi-e); picraft is an alternative Python wrapper (docs exist, status unverified) — [picraft.readthedocs.io](https://picraft.readthedocs.io/)

**Mineflayer (Node.js bots) — ACTIVE**
- Mineflayer: "Create Minecraft bots with a powerful, stable, and high level JavaScript API"; supports Minecraft 1.8 through 26.1 (incl. 1.21.9, 1.21.11, 26.1); Node.js 18+; usable from Python; bots can track entities/blocks, move with physics, attack, ride, manage inventory/craft/chests, dig and build, chat; MIT; ~7.6k stars; third-party plugins include pathfinding, PvP, and an MCP server for LLM use — [github.com/PrismarineJS/mineflayer](https://github.com/PrismarineJS/mineflayer)
- Releases: 4.39.0 (06 Sep [2026], latest), 4.38.0 (27 Aug), 4.37.1 (03 May), 4.37.0 (31 Mar), 4.36.0 (30 Mar), 4.35.0 (13 Feb), 4.34.0 (26 Jan) — [mineflayer releases](https://github.com/PrismarineJS/mineflayer/releases)

**Kotlin script hosts on Fabric/NeoForge**
- Katton: "Kotlin scripting framework for Fabric and NeoForge", scripts hot-reload without restarting, "use Kotlin Scripts to directly interact with Java objects during the runtime of Minecraft", MIT, supports the 26.1.x line, built-in GUI for script packs — [modrinth.com/mod/katton](https://modrinth.com/mod/katton)
- Fabric Language Kotlin is the base Kotlin runtime dependency for Fabric mods; Fabric Kotlin Extensions adds Kotlin Scripting JVM/JSR223/compiler libraries — [moddex: fabric-language-kotlin](https://moddex.gg/mod/fabric-language-kotlin), [modpackindex: Fabric Kotlin Extensions](https://www.modpackindex.com/mod/109688/fabric-kotlin-extensions)

### Inferences
- For a kids' program on 26.x Java, the realistic scripting options are KubeJS (needs a mod loader and the KubeJS mod installed client+server, but script edits reload with `/reload` for server scripts) and CC: Tweaked (Lua inside the game, no external tooling). CraftTweaker is effectively a 1.21.1 tool as of Oct 2026.
- Mineflayer is a *bot* framework, not a mod: it joins a server as a fake player and does nothing a player couldn't; it never changes game rules. It does work against vanilla/Paper servers with no install on the server (inference from "bot" design).
- The whole mcpi/RaspberryJuice stack (the classic "Python + Minecraft" classroom route) is dead for modern Java servers; Minecraft Education's Code Builder (Section 5) is its practical successor.

### Gaps
- KubeJS's own site does not state current version numbers or 26.x support; 26.1 support is inferred from the active `2601` GitHub branch and a third-party listing. No Fabric 26.x KubeJS build was seen.
- Could not fetch Modrinth/CurseForge directly (JS-heavy) for exact CC: Tweaked loader-per-release info.
- No source found on whether Katton has 26.2/26.3 builds or a user base of any size.

---

## 3. No-code / low-code mod makers: MCreator, Tynker, LearnToMod, Code Kingdoms, Blockbench

### Takeaway
MCreator (GPL-3.0, Windows/Linux/macOS) is the only actively developed no-code mod maker, with releases 2026.2 (Aug 2026, "Latest") and 2026.3 EAP (Oct 2026), and its 2026.1 line pushed Bedrock add-on output hard; Tynker is alive but Bedrock-only; Code Kingdoms sells Java courses but shows no version info; LearnToMod's site appears frozen since 2016; Blockbench is a free, actively updated model/animation editor (no behavior).

### Cited Findings

**MCreator**
- MCreator is open-source software for "Minecraft Java Edition mods, Bedrock Edition add-ons, resource packs, and data packs", used by "players, aspiring mod developers, educators, and STEM workshops"; "easy-to-learn visual interface or an integrated code editor"; topic tags "blockly" and "code-generator"; licence GPL-3.0 with section-7 exceptions, copyright Pylo; "Some generators use official Minecraft mappings, which are covered by a Microsoft licence and Minecraft's EULA"; not affiliated with Mojang/Microsoft — [github.com/MCreator/MCreator](https://github.com/MCreator/MCreator)
- Releases: 2026.3.41718 (11 Oct [2026], pre-release/EAP), 2026.3.38715 (20 Sep, EAP), **2026.2.33518 (14 Aug, "Latest")**, 2026.2.33218 (11 Aug), 2026.2.30420 (23 Jul), 2026.2.29418 (16 Jul), 2026.2.27711 (05 Jul), 2026.1.14619 (04 Apr); assets include Windows (.exe, .msix), Linux, and macOS builds — [github.com/MCreator/MCreator/releases](https://github.com/MCreator/MCreator/releases)
- 2026.1 pre-release post ("The rise of Minecraft Bedrock Edition"): "This will be the biggest update overall, but also in terms of Minecraft Bedrock Edition add-on features!"; changelog lists Bedrock item/block parameters, a new "script" mod element, and importing custom structures — [mcreator.net/node/122081](https://mcreator.net/node/122081)
- 2024–2025 changelogs show NeoForge generator additions (NeoForge 1.20.4, later 1.21.4 and 1.21.8), new procedure blocks (vector math, entity position), and a 2025.2 note that generated code style improved and "regeneration no longer deletes user-provided Java files" — [softpedia changelog](https://mac.softpedia.com/progChangelog/MCreator-Changelog-141097.html), [mcreator.net/node/119803](https://mcreator.net/node/119803)
- Community (unofficial) generator plugins exist for legacy targets, e.g. a Forge 1.18.2 generator ported to MCreator 2026.1 ("not official and is not maintained by the MCreator Team") and NeoForge 1.20.4/1.20.6/1.21.4 generators — [mcreator.net/node/118523](https://mcreator.net/node/118523), [mcreator.net/comment/274907](https://mcreator.net/comment/274907/)
- One user comment on a plugin page reports a build failure caused by generated code referencing an un-imported class (anecdotal) — [mcreator.net/comment/297550](https://mcreator.net/comment/297550)

**Tynker**
- Tynker's Minecraft offering targets "Minecraft for Windows (Bedrock Edition)" and "Minecraft for iPad (Bedrock Edition)"; kids make skins, items, blocks, mobs (mobs with custom code), via block-based Mod Designer/Workshop, Resource Editor (deploys resource packs), Behavior Editor (deploys behavior packs); a "Tynker Server" connects via Bedrock's `/connect` command; Mod Creator app for ages 6–11; paid subscriptions include two 1:1 coaching sessions; footer "© 2026" — [tynker.com/minecraft/mods](https://www.tynker.com/minecraft/mods/)
- Tynker's iOS app shows an update dated April 8, 2026 — [appshunter Tynker listing](https://appshunter.io/ios/app/tynker/id805869467)

**LearnToMod — STALE**
- LearnToMod (ThoughtSTEM): browser-based mod/texture-pack/schematic creation with a private Minecraft server, "Vox-L" in-browser engine; "NOT AN OFFICIAL MINECRAFT PRODUCT"; the newest dated content is from May 2016, footer links to Google+ (defunct), no copyright year, broken navigation links — [learntomod.com](https://www.learntomod.com/)

**Code Kingdoms — ACTIVE but Java-coding, not no-code**
- Code Kingdoms: video courses + web code editor for Java Minecraft mods/games hosted on a private server friends can join; "Minecraft Java Edition on Windows or Mac", Bedrock not supported; pricing $19.99/month, $99.99/year, $249.99 lifetime; family plans +50%; claims "courses updated every month", 120+ hours, live support 7 days — [codekingdoms.com](https://codekingdoms.com/)
- TechCrunch (c. 2016) profiled Code Kingdoms as a London startup pivoting to Minecraft modding with a JavaScript subscription for kids — [techcrunch.com](https://techcrunch.com/?p=1355921)

**Blockbench (models/animation only)**
- Blockbench: "A low-poly 3D model editor", cuboid + mesh modeling, texturing with auto UVs, keyframe animation editor, plugin store; "free to use for any type of project, forever, no strings attached", GPL open source, desktop download + web app — [blockbench.net](https://www.blockbench.net/)
- Releases: 5.2.2 (08 Oct 2026, latest), 5.2.1 (21 Sep 2026), 5.2.0 "Screen-Space Update" (18 Sep 2026), 5.1.x Apr–Jul 2026; assets include Windows (.exe installer/portable/arm64), macOS arm64 .dmg, Linux AppImage/.deb/.rpm; changelogs mention Minecraft Java block/item models, Bedrock geometry and attachables, bbmodel, glTF/FBX/OBJ export; 5.2.2 added `force_translucent` for the Java block/item format — [github.com/JannisX11/blockbench/releases](https://github.com/JannisX11/blockbench/releases)

### Inferences
- MCreator is the only tool here that produces real Java mods (and now Bedrock add-ons) from a block-based editor; its GitHub release cadence (monthly 2026.2 patches, 2026.3 EAP) shows it tracks current Minecraft, though the exact Minecraft/loader versions per MCreator release could not be confirmed from a primary page (mcreator.net blocked fetching).
- Tynker is effectively a Bedrock behavior/resource-pack generator with a server bridge; it does not touch Java Edition.
- Blockbench is complementary to every other route (models for Java resource packs, Bedrock add-ons, MCreator, Fabric mods) and runs natively on Linux.

### Gaps
- mcreator.net (changelog, download, supported-generators list) returned HTTP 403, so the official list of generators shipped in 2026.2/2026.3 (which Minecraft versions, NeoForge vs Fabric vs Forge vs Bedrock vs data pack) is unverified. The pre-release post implies Bedrock add-on and Java generators both exist.
- No systematic source on MCreator's reputation in the modding community (only one anecdotal build-failure comment).
- Could not confirm whether Code Kingdoms' Java courses target a current Minecraft version.
- No 2026 primary source on LearnToMod's status beyond the stale homepage.

---

## 4. Bedrock Edition add-ons, Scripting API, Marketplace / Partner Program, Vibrant Visuals, and Java add-ons

### Takeaway
Bedrock add-ons = behavior packs (JSON) + resource packs + an official JavaScript/TypeScript Scripting API (`@minecraft/server` at stable 2.10.0, beta 2.12.0 as of Oct 2026) that can register custom commands, components, dimensions, and world clocks — a data-driven system that is "equivalent to Java's data packs" per Microsoft but with no engine access; add-ons are sold on the Marketplace via the Partner Program (business registration required) and are the only mod path on consoles. Vibrant Visuals shipped Bedrock-first with Java "to follow"; no Mojang statement promising Java add-ons was found.

### Cited Findings

**What add-ons are and where they run**
- Add-ons "are a package format and a type of downloadable content that adds custom features to Bedrock Edition … This feature is exclusive to Bedrock Edition"; behavior packs define entity behaviors, loot tables, spawn rules, recipes in JSON; resource packs change textures/models/music/text/UI; scripting uses JavaScript (TypeScript supported) via modules such as `@minecraft/server`; bundled as `.mcaddon` which the game imports into `com.mojang`; "For similar game customization in Java Edition, see Data pack and Mod" — [minecraft.wiki/w/Add-on](https://minecraft.wiki/w/Add-on)
- Platform limits: Windows and mobile can load community add-ons from third-party sites; consoles cannot import external add-ons and "can only access those add-ons through Realms" or the Marketplace — [minecraft.wiki/w/Add-on](https://minecraft.wiki/w/Add-on)
- Microsoft's Scripting intro: "Scripts can control entities, blocks, and items, manipulate the world, and even create entirely new game mechanics!"; language is JavaScript ("a lot of Minecraft scripts are written in … TypeScript"); prerequisites "a computer running Windows 10 or 11"; scripts live in a behavior pack `scripts/main.js` declared as a `"type": "script"` module with a `@minecraft/server` dependency; `/reload` hot-reloads scripts; page updated 2026-05-12 — [learn.microsoft.com Scripting intro](https://learn.microsoft.com/en-us/minecraft/creator/documents/scripting/introduction)
- `@minecraft/server` module: manifest example `"version": "2.10.0"`; "This is version 2.x.x of this module, which is the latest as of version 1.26.60-beta.30 of Minecraft"; available versions `2.12.0-beta.1.26.60-preview.30`, `2.10.0`, … `2.0.0`, prior 1.0.0–1.19.0; classes include `CustomCommandRegistry`, `BlockComponentRegistry`, `ItemComponentRegistry`, `DimensionRegistry` (custom dimensions), `WorldClockRegistry`, `StructureManager`, `Camera`, `Scoreboard`, `LootTableManager`, `PlayerInputPermissions`, aim-assist classes; page updated 2026-10-06 — [learn.microsoft.com @minecraft/server](https://learn.microsoft.com/en-us/minecraft/creator/scriptapi/minecraft/server/minecraft-server?view=minecraft-bedrock-stable)
- Community docs list additional modules including `@minecraft/server-ui`, `@minecraft/server-graphics` (Vibrant Visuals), and `@minecraft/diagnostics` (Sentry error tracking) — [jaylydev scriptapi docs](https://jaylydev.github.io/scriptapi-docs/), [wiki.bedrock.dev script modules](https://wiki.bedrock.dev/scripting/script-modules)

**Power comparison vs Java data packs (Microsoft's own words)**
- "Bedrock's behavior packs are equivalent to Java's data packs. While they share some similarities, the differences are significant": Bedrock uses one `flipbook_textures.json` vs Java per-texture `.mcmeta`; "Java can create custom fonts and GLSL shaders, while Bedrock cannot. Bedrock can create custom particles and fogs, while Java cannot." Also: "Bedrock's command structure is similar to the system used in versions of Java up to 1.13"; Bedrock lacks quasi-connectivity so BUD-style redstone differs; Bedrock worlds are LevelDB vs Java Anvil, so world tools don't cross over; "Java is currently available on Windows, Mac, and Linux PCs" while Bedrock is Windows/consoles/mobile (page dated 2025-04-21) — [learn.microsoft.com Differences between Bedrock and Java](https://learn.microsoft.com/en-us/minecraft/creator/documents/differencesbetweenbedrockandjava)
- Secondary: Bedrock add-ons "can modify existing game assets and behaviors, but they cannot fundamentally alter the game's core code" and must be compatible across all platforms players connect from — [gameserverkings](https://www.gameserverkings.com/knowledge-base/minecraft/bedrock-addons.md), [CurseForge blog](https://blog.curseforge.com/java-mods-vs-bedrock-add-ons-whats-the-difference/)

**Marketplace / Partner Program**
- Add-ons are sold on the Marketplace for Minecoins; creators "must be in the Minecraft Partner Program and be approved by the Minecraft Content Team"; on February 20, 2024 individual add-ons became sellable on their own (previously bundled with a world) — [minecraft.wiki/w/Add-on](https://minecraft.wiki/w/Add-on)
- Partner Program page: portfolio of "maps, skin packs, texture packs, hosted servers, add-ons, or Realms content"; partners are "expected to operate like a business and submit key art, screenshots, trailers, and descriptions"; "Every new submission is reviewed for quality and suitability" — [minecraft.net/partner](https://www.minecraft.net/en-us/partner); a Noxcrew help page says "Applicants must be a registered business … provide business and tax details" and products not maintained across updates are removed — [noxcrew.com](https://noxcrew.com/help/minecraft-marketplace-community-creators)
- Feb 2024 launch coverage: add-ons "built by official Minecraft partners and creators, vetted by Mojang Studios to ensure safety and quality, and offered through the cross-platform Minecraft Marketplace"; the team "stresses that support for third-party sideloaded mods isn't going anywhere" — [Windows Central](https://www.windowscentral.com/gaming/minecraft/minecraft-bedrock-edition-marketplace-mods-announcement), [Press Start](https://press-start.com.au/?p=152557)

**Vibrant Visuals**
- Announced at Minecraft LIVE March 2025 (Xbox Wire, 25 Mar 2025): directional lighting, volumetric fog; optional toggle; "won't affect gameplay" — [news.xbox.com](https://news.xbox.com/en-us/2025/03/25/minecraft-vibrant-visuals/)
- Official Minecraft.net: Vibrant Visuals "is launching first on Bedrock Edition, and Mojang is working on bringing it to Java Edition", shipping piecemeal "starting with snapshots and then full releases"; no Java date — [minecraft.net Vibrant Visuals Java Edition](https://www.minecraft.net/en-us/article/vibrant-visuals-java-edition)
- Minecraft LIVE Sept 2026 promoted Minecraft on Nintendo Switch 2 "featuring support for Vibrant Visuals" — [minecraft.wiki LIVE Sept 2026](https://minecraft.wiki/w/Minecraft_Live_%E2%80%93_September_2026)

**Java add-ons — official position**
- The Minecraft Wiki Add-on page "contains no official Mojang statement about add-ons for Java Edition" and redirects Java users to data packs and mods — [minecraft.wiki/w/Add-on](https://minecraft.wiki/w/Add-on)
- Windows Central FAQ: "Minecraft: Java Edition Realms cannot use add-ons or mods" — [windowscentral Realms FAQ](https://windowscentral.com/gaming/minecraft-realms-faq-how-to-setup-price-and-other-questions-answered)
- Community feedback threads request Java-mod porting and a free in-game mod browser; these are player requests, not Mojang commitments — [feedback.minecraft.net](https://feedback.minecraft.net/hc/en-us/community/posts/44194483726221/comments/44253983004301)

### Inferences
- The Bedrock Scripting API has grown well past Java data packs in *programmability* (real JS with events, custom commands, custom block/item components, custom dimensions, UI forms via `server-ui`) while staying inside a sandbox: no rendering changes, no new engine systems. Java data packs remain ahead on fonts/shaders and on the richer `/execute`-style command grammar; Java mods remain the only route to engine-level change.
- Add-ons are the only cross-platform (console, mobile) customization route; everything in this document for Java is PC-only by definition.
- Bedrock add-on authoring officially assumes Windows 10/11 (the docs' stated prerequisite); on Linux you'd need the unofficial Bedrock Linux launcher (not researched) or a Windows VM.

### Gaps
- No official Mojang statement found either promising or ruling out add-ons for Java Edition; absence of evidence only.
- Exact current Marketplace revenue-share or Partner Program acceptance criteria for 2026 not found on a dated primary page.
- Did not verify whether Vibrant Visuals has reached a Java snapshot by October 2026 (the official article is undated and gives no Java date).
- `@minecraft/server-ui` current version and the `server-graphics` module's stable status not pulled from primary docs.

---

## 5. Minecraft Education Edition: Code Builder, the Agent, Classroom Mode, licensing for a community program, Linux

### Takeaway
Minecraft Education is a Bedrock-based edition (current release 26.32) with built-in Code Builder (MakeCode blocks/JavaScript/Python, plus Tynker and Azure-Notebooks Python options) driving a programmable Agent; non-school organisations (camps, clubs, after-school programs, nonprofits, individuals) can buy a Commercial license at $36/user/year; it runs on Windows, macOS, ChromeOS, iPadOS, iOS, and Android — there is no Linux build.

### Cited Findings
- Minecraft Education is "an educational version of Bedrock Edition specifically designed for classroom use", by Mojang Studios and Xbox Game Studios; announced 19 Jan 2016, released 1 Nov 2016; current Release 26.32, Preview 26.30.0; platforms: Windows, macOS, ChromeOS, Android, iOS, iPadOS (Linux not listed); Code Builder is "a companion program where students 'write code in a code editor,' and the Agent then executes that code in the game"; Classroom Mode gives educators a map master view with player locations, chat monitoring, and world-setting toggles (page last edited 9 Oct 2026) — [minecraft.wiki/w/Minecraft_Education](https://minecraft.wiki/w/Minecraft_Education)
- Pricing per the wiki: accredited academic institutions $5.04/user/year ($4.99 App Store); non-eligible users "a Commercial License costs $36 per user per year or $3 per user per month"; Microsoft 365 Education A3/A5 include it free for students; eligibility: educators, accredited schools, public libraries and museums, qualifying home-school programs — [minecraft.wiki/w/Minecraft_Education](https://minecraft.wiki/w/Minecraft_Education)
- Official licensing page: "Individual licenses can be purchased for use in camps, clubs, and other organizations. This purchase option is perfect for any anyone that doesn't fit the criteria for a qualified educational organization. $36 User/Year" — [education.minecraft.net/licensing](https://education.minecraft.net/licensing)
- Official support article: "Any organization can purchase a Commercial license. This is the license option available to any organization (like a camp, club, after-school program, etc.) that is not an eligible academic institution. It is also available to individuals and homeschoolers." Education licenses "are only available to eligible academic institutions." — [edusupport article 360061371532](https://edusupport.minecraft.net/hc/en-us/articles/360061371532)
- The 2021 "Camps and Clubs Update" opened purchasing so "camps, clubs, after-school programs, nonprofits, homeschools, and other organizations can purchase licenses" — [education.minecraft.net blog](https://education.minecraft.net/blog/the-camps-and-clubs-update-brings-minecraft-education-edition-to-learners-beyond-the-classroom); covered by [Windows Central](https://windowscentral.com/microsoft-brings-minecraft-education-edition-outside-classroom-camps-and-clubs)
- Official FAQ figures (undated page): ~$5.04/user/year for eligible institutions, $36/user/year otherwise — [edusupport FAQ 360047119092](https://edusupport.minecraft.net/hc/en-us/articles/360047119092-FAQ-Availability-Pricing-and-Licensing); a third-party page (Apr 2026) claims $12/user/year for non-institutions, contradicting Microsoft's $36 — [codegenes.net](https://www.codegenes.net/blog/minecraft-education-edition-download/)
- Code Builder: opened with the "C" key (or the agent icon on touch); it replaced the separate "Code Connection" app; one lesson guide lists three editors — Microsoft MakeCode, Python with Azure Notebooks, or Tynker; MakeCode offers drag-and-drop blocks, JavaScript, and Python editors; the Agent is "a programmable character that can be programmed to move, make decisions, and complete jobs", e.g. `agent.move(FORWARD, 10)`; selectors `@c` (your agent) and `@v` (all agents, worldbuilders only); all users start with Worldbuilder = false — [Microsoft Learn: MakeCode and the Agent](https://learn.microsoft.com/en-us/training/modules/introduce-coding-minecraft-education-edition/learn-to-code-microsoft-makecode-agent), [Microsoft Learn: Python in MakeCode](https://learn.microsoft.com/en-us/training/modules/transition-python-minecraft-education-edition/learn-code-with-python-microsoft-makecode), [edusupport 360047116992](https://edusupport.minecraft.net/hc/en-us/articles/360047116992)
- Microsoft's "Prompt Lab" module uses Copilot to "generate Python scripts that you can use to teach and build in Minecraft" — [minecraft.net Prompt Lab](https://new.minecraft.net/en-us/blog/prompt-lab-2)
- Linux: a community thread on the official support forum asks about Linux support; search results show no official answer and suggest the Windows build via Wine or the Mac download as workarounds — [edusupport community post](https://edusupport.minecraft.net/hc/en-us/community/posts/360072469272-Installing-Minecraft-Education-Edition-on-Linux)
- Minecraft Education celebrated its tenth anniversary at Minecraft LIVE Sept 2026 — [minecraft.wiki LIVE Sept 2026](https://minecraft.wiki/w/Minecraft_Live_%E2%80%93_September_2026)

### Inferences
- For Newburgh Creates (a community program, not a school), the applicable tier is the Commercial license at $36/user/year (~$3/user/month); the $5.04 academic rate is explicitly closed to non-institutions. Public libraries/museums *are* in the academic-eligible list, so a library partnership could be a route to the cheaper rate.
- Education Edition content (worlds, Code Builder projects) does not transfer to Java Edition; it is a Bedrock derivative, so any Java datapacks already built (this repo) are irrelevant to it and vice versa.
- Dave's Arch Linux machine cannot run Education Edition natively; a Chromebook/iPad/Windows fleet would be needed for a class.

### Gaps
- Could not fetch education.minecraft.net/licensing or the camps-and-clubs page directly (timeouts); pricing quotes come from search-engine extracts of those official pages and from the Minecraft Wiki.
- No official Microsoft statement on Linux (the forum post returned 403); "no Linux build" rests on the official platform list omitting it.
- Account requirements (Microsoft 365/Entra account provisioning for commercial licenses) not verified.
- Whether Code Builder currently still offers the Tynker and Azure Notebooks editors (vs. MakeCode only) in 26.x was not confirmed from a 2026 source.

---

## 6. Client-side-only modifications, the vanilla "modding" tier (command blocks/redstone), and Realms/server constraints

### Takeaway
Client-only mods (Sodium, Iris, OptiFine) change rendering/performance without touching gameplay and need no server support; Sodium/Iris already have 26.3 builds (Sep 2026) while OptiFine lags (26.2 preview, 1.21.11 last stable). Vanilla command blocks/functions/data packs are the only customization that survives Realms; Realms accept no mods or plugins.

### Cited Findings

**Shaders / performance mods**
- Sodium releases: 0.9.3-alpha.1 for 26.3 (20 Sep [2026]); **0.9.2 for 26.3 (15 Sep, "Latest")**; 0.9.2 for 26.2 and 26.1.2 (11 Sep); 0.8.15-beta.1 and 0.8.14 for 1.21.11; the 26.3 0.9.2 notes say "Iris is not yet compatible"; 0.9.2 added FRAPI support on NeoForge — [github.com/CaffeineMC/sodium/releases](https://github.com/CaffeineMC/sodium/releases); Sodium `mc26.2-0.9.1` warned Iris 1.11.1 was incompatible — [newreleases.io](https://newreleases.io/project/github/CaffeineMC/sodium/release/mc26.2-0.9.1)
- Iris: third-party listings show Iris 1.11.4+26.2-fabric and Iris 1.11.7+26.3-fabric (single source), and an "Iris 1.11.2 for NeoForge 26.2" CurseForge file "updated to Sodium 0.9.1" — [craftmc.net](https://www.craftmc.net/minecraft-mods/iris-shaders), [curseforge Iris NeoForge file](https://www.curseforge.com/minecraft/mc-mods/irisshaders/files/8396844); an unofficial "Iris for Forge" port exists, "not affiliated with or endorsed by the Iris Shaders development team" — [curseforge Iris for Forge](https://www.curseforge.com/minecraft/mc-mods/iris-for-forge); Iris's GitHub Releases page only lists 1.7.x (2024-era) builds, so current releases are distributed elsewhere (Modrinth) — [github.com/IrisShaders/Iris/releases](https://github.com/IrisShaders/Iris/releases)
- OptiFine official downloads: 26.2 → OptiFine HD U K2 pre1 (22 Sep 2026, preview); 26.1.2 → HD U K1 pre2 (22 Jun 2026, preview); **1.21.11 → HD U J9 (05 Feb 2026, stable — the newest stable)**; 1.21.5–1.21.10 only previews — [optifine.net/downloads](https://optifine.net/downloads)
- "OptiFine for Fabric" on Modrinth is a community recreation, not official OptiFine — [boxtoplay listing](https://www.boxtoplay.com/en/minecraft-hosting/minecraft-server/modrinth-modpacks/optifine-for-fabric-49222)

**Vanilla "modding" tier and Java vs Bedrock command/redstone differences**
- Microsoft's creator docs: Bedrock's command structure "is similar to the system used in versions of Java up to 1.13"; Bedrock lacks quasi-connectivity so BUD switches behave differently; Java data packs can do custom fonts and GLSL shaders — [learn.microsoft.com Differences](https://learn.microsoft.com/en-us/minecraft/creator/documents/differencesbetweenbedrockandjava)
- Paper plugins can register commands "that players, the console, RCON, and command blocks can run" — i.e. command blocks remain a first-class trigger surface even on plugin servers — [docs.papermc.io](https://docs.papermc.io/paper/dev/how-do-plugins-work/)

**Realms / hosting constraints**
- "Minecraft: Java Edition Realms cannot use add-ons or mods" — [Windows Central Realms FAQ](https://windowscentral.com/gaming/minecraft-realms-faq-how-to-setup-price-and-other-questions-answered)
- Data packs reach Java Realms only by uploading a whole world: "Realms > Configure Realms, pick a world slot, and select Reset World > Upload World" — [gurugamer Realms mods guide](https://gurugamer.com/pc-console/minecraft-realms-mods-guide-2025-19106); a feedback post notes "the only way I can update a 4MB pack on a realm is to download a 500MB world" — [feedback.minecraft.net](https://feedback.minecraft.net/hc/en-us/community/posts/360023754951/comments/360013179971)
- Hosting comparison: Realms "don't support mods or plugins"; Paper etc. "require a dedicated server" — [xgamingserver](https://xgamingserver.com/blog/what-are-minecraft-realms/)
- Bedrock consoles can only get community add-ons "through Realms" (or Marketplace) — [minecraft.wiki/w/Add-on](https://minecraft.wiki/w/Add-on)
- Vanilla Java now offers peer-to-peer "Online" hosting of singleplayer worlds plus a Friends List (26.2 Snapshot 7, May 2026; "a first version") — [minecraft.net 26.2 Snapshot 7](https://minecraft.net/en-us/article/minecraft-26-2-snapshot-7), [feedback.minecraft.net](https://feedback.minecraft.net/hc/en-us/articles/45790287863437-Minecraft-Java-Edition-26-2-Snapshot-7)

### Inferences
- Client-only mods are irrelevant to *teaching* game design but matter for hardware: Sodium is the practical fix for low-end laptops on 26.x; OptiFine users are stuck on 1.21.11 stable or previews.
- Resource packs (vanilla) + command blocks/functions/data packs are the only tier that works everywhere a Java world can be hosted — singleplayer, LAN/P2P Online, Realms, and any server — which is why this repo's datapack approach is the most portable.
- Shader packs require Iris (or OptiFine) on each client; they cannot be pushed from a server. Server-side "shaders" don't exist (resource packs can set a world `resources.zip`, but this repo's CLAUDE.md already records that failing in 26.3).

### Gaps
- Could not fetch Mojang's official help-center Realms/Java article; Realms constraints are from Windows Central and hosting blogs.
- Iris 26.3 version number comes from one third-party listing.
- No primary source on vanilla "Open to LAN" being removed/replaced in the final 26.2 release (only snapshot-era reporting).

---

## 7. Genuinely new in 2025–2026: Mojang/Microsoft announcements about modding, creator tools, version renumbering, Minecraft LIVE 2025/2026

### Takeaway
The two concrete Mojang moves for Java modders were (a) removing code obfuscation from Java Edition (announced Nov 2025, shipping from the first post-Mounts-of-Mayhem snapshot, i.e. the 26.1 cycle) and (b) the switch to year-based versions (26.1 = March 2026); Minecraft LIVE Sept 2026 added only a vague "official creator platform" pledge from Jens Bergensten. No Java add-on system or official Java mod API was announced at any 2025–2026 LIVE.

### Cited Findings

**Deobfuscation of Java Edition**
- Official Minecraft.net article "Removing obfuscation in Java Edition": the game "has been scrambled since release"; the 2019 "obfuscation mappings" only partly helped modders; starting with the first snapshot after the Mounts of Mayhem launch, builds ship with original names including variable names so mod tools and crash logs are easier to read — [minecraft.net](https://minecraft.net/en-us/article/removing-obfuscation-in-java-edition) (summary via search extract; the page itself timed out on fetch)
- AlternativeTo (5 Nov 2025): "Microsoft will offer unobfuscated experimental versions in parallel with the traditional obfuscated ones" starting with the next snapshot; "the first Minecraft: Java Edition snapshot [after Mounts of Mayhem] to ship will be the first official version delivered without obfuscation"; "this change will bring some temporary difficulty for those using existing modding tools, which expect obfuscated code"; the article does not mention an official modding API — [alternativeto.net](https://alternativeto.net/news/2025/11/microsoft-to-remove-code-obfuscation-from-minecraft-java-edition-greatly-helping-modders)
- Windows Central: "Mojang Studios has announced that it's removing obfuscation from Minecraft: Java Edition's code, which will make it much easier for developers to mod the game" — [windowscentral.com](https://www.windowscentral.com/gaming/minecraft/mojang-studios-is-removing-obfuscation-from-minecraft-java-edition)
- Downstream: Paper dropped its internal Spigot remapper in 26.1 because "Mojang will stop providing obfuscated server jars" — [papermc.io/news/1-21-11](https://papermc.io/news/1-21-11); NeoForged's 2025 retrospective references the coming changes — [neoforged.net](https://neoforged.net/news/2025-retrospection/)

**Version renumbering**
- Versions "will start with the current year, then the drop number within that year", optionally patch and hotfix; first 2026 drop `26.1`, first hotfix `26.1.1` (PaperMC, 21 Dec 2025) — [papermc.io/news/1-21-11](https://papermc.io/news/1-21-11)
- Mojang introduced the scheme with "Minecraft 26.1 Snapshot 1" (released 16 Dec 2025) — [beebom.com](https://beebom.com/minecraft-new-version-numbering-system-for-java-edition/amp/); Bedrock patch notes: version numbers in 2026 "will begin with '26' for both Bedrock and Java Edition" — [mp1st.com](https://mp1st.com/?p=303524); "Tiny Takeover" released March 24, 2026 as Java 26.1 — [space-node.net](https://space-node.net/blog/minecraft-26-version-numbers-explained)
- Minecraft LIVE March 2026 confirmed Tiny Takeover "would release on March 24th" — [minecraft.wiki LIVE March 2026](https://minecraft.wiki/w/Minecraft_Live_%E2%80%93_March_2026)

**Minecraft LIVE 2025 (two shows)**
- March 2025: Vibrant Visuals announced (Bedrock first, Java later) — [news.xbox.com](https://news.xbox.com/en-us/2025/03/25/minecraft-vibrant-visuals/)
- September 27, 2025: Mounts of Mayhem (nautilus, zombie nautilus, spear, zombie horseman), The Copper Age release date, Dragon Ball Z DLC tease, a "Friendly Fishing Add-On" charity pre-show item; the wiki article "doesn't cover … modding, creator tools, deobfuscation, version numbering" — [minecraft.wiki LIVE Sept 2025](https://minecraft.wiki/w/Minecraft_Live_%E2%80%93_September_2025)

**Minecraft LIVE 2026 (three shows)**
- March 21, 2026: "Parties" ("groups of players that can work together and play on multiple worlds"), Tiny Takeover (Mar 24), Chaos Cubed (sulfur caves/cube), Minecraft Dungeons II, Minecraft World theme park (Chessington, 2027); nothing on modding/add-ons/creator tools — [minecraft.wiki LIVE March 2026](https://minecraft.wiki/w/Minecraft_Live_%E2%80%93_March_2026), official recap [minecraft.net mclive_march2026_recap](https://minecraft.net/en-us/article/mclive_march2026_recap)
- May 30, 2026 (TwitchCon Rotterdam): Chaos Cubed release date June 16, 2026; Dungeons II details; movie sequel; no modding items — [minecraft.wiki LIVE May 2026](https://minecraft.wiki/w/Minecraft_Live_%E2%80%93_May_2026)
- September 26, 2026: Jens said "they will begin an official creator platform" (no date/details); a "sound effects pack … a type of resource pack coming to Minecraft soon"; Ice Caves in "Fourth Drop 2026"; "The Sift" dimension for Java and Bedrock in 2027; Switch 2 with Vibrant Visuals; Dungeons II released Sept 29, 2026; recap published on Minecraft.net Oct 3, 2026 — [minecraft.wiki LIVE Sept 2026](https://minecraft.wiki/w/Minecraft_Live_%E2%80%93_September_2026); a Vietnamese recap says Mojang framed the "Creator Platform" as making it easier to "build, manage, and share content through better tools and systems" with no specific features or dates — [cellphones.com.vn](https://cellphones.com.vn/sforum/minecraft-live-2026)

**Java multiplayer changes (relevant to hosting)**
- 26.2 Snapshot 7 (May 2026): Friends List, "Invite to world"/"Request to join world", Presence settings (All/Limited/None); "a first version" — [minecraft.net](https://minecraft.net/en-us/article/minecraft-26-2-snapshot-7), [feedback.minecraft.net](https://feedback.minecraft.net/hc/en-us/articles/45790287863437-Minecraft-Java-Edition-26-2-Snapshot-7)

**Bedrock Marketplace add-ons (2024, context)**
- Feb 20, 2024: standalone add-ons category on the Bedrock Marketplace, vetted by Mojang, cross-platform — [Windows Central editorial](https://www.windowscentral.com/gaming/minecraft/minecraft-bedrock-edition-add-ons-editorial)

### Inferences
- Deobfuscation is the most consequential modding change of the period: it lowers the barrier for Java mods and for tools like MCreator/KubeJS (readable names, readable crash logs), but it is not an official API and Mojang made no API promise in the announcement.
- The "official creator platform" (Sept 2026) is the first hint since Bedrock add-ons that Mojang wants first-party creator tooling; with no details it cannot yet be weighed against Java mods or data packs.
- Faster "drops" (four per year in 2026: 26.1 March, 26.2 June, 26.3 September, 26.4 upcoming) mean every third-party route breaks more often; Paper's note that each drop's world upgrade is irreversible applies equally to classroom worlds.

### Gaps
- The Minecraft.net LIVE Sept 2026 recap (Oct 3, 2026) and the exact Jens Bergensten quote on the "creator platform" were not fetched; only the wiki paraphrase and a Vietnamese recap are available.
- The official deobfuscation article's text was only seen via a search extract (fetch timed out); the exact first unobfuscated snapshot number is not recorded here.
- No official Mojang statement on an official Java mod API or Java add-ons for 2025–2026 was found — this appears to be a genuine absence rather than a search miss, but cannot be proven.
- Whether "Parties" (March 2026) and the Friends List/Online hosting (May 2026) are the same feature was not confirmed.
