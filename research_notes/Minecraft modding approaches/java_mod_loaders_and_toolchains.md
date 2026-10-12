# Java Edition mod loaders and toolchains in 2026 (Fabric, NeoForge, Forge, Quilt; Mojang's stance)

Research date: 2026-10-12. Minecraft Java is on 26.3 ("Wilderness Bound", released 2026-09-15); 26.4 snapshots are out. Everything below is dated; items older than 2026 are marked.

Data-collection note: counts tagged "Modrinth API" were pulled live on 2026-10-12 19:23 UTC from `https://api.modrinth.com/v2/search?limit=0&facets=[["categories:<loader>"],["versions:<mc>"],["project_type:mod"]]`; version/date facts tagged "maven metadata" come from the loaders' own Maven repositories (HTTP `Last-Modified` headers on the artifact POMs/JARs) and `meta.fabricmc.net` / `meta.quiltmc.org`.

## Key Question 1: Which loaders support 26.2 / 26.3, how fast do they update, and what is their share?

### Takeaway
All four loaders ship for 26.3, but with very different depth: Fabric and NeoForge both had 26.3 builds on release day (Fabric API the evening before; NeoForge within hours) and are the two live ecosystems; Forge still publishes 26.x builds (66.0.x for 26.3) but has a small and shrinking mod catalogue; Quilt Loader technically runs on 26.3 but Quilt retired QSL/QFAPI/Quilt Mappings in early 2026, so "Quilt mods" on 26.x are effectively Fabric mods. On Modrinth, Fabric has roughly 1.8× NeoForge's 26.3 mod count (7,341 vs 4,107), while NeoForge dominates the 1.21.1 "stable modding" version (21,277 vs 19,514).

### Cited Findings

**Minecraft versions and the versioning change**
- The Minecraft Wiki version table lists: 26.1 (dev release 2025-12-16, full release 2026-03-24), 26.1.1 (2026-04-01), 26.1.2 "Tiny Takeover" hotfix (2026-04-09), 26.2 "Chaos Cubed" (snapshots from 2026-04-07, released 2026-06-16), 26.3 "Wilderness Bound" (snapshots from 2026-06-23, released 2026-09-15), and 26.4 (snapshots from 2026-09-22, "Upcoming Q4 2026") — [Minecraft Wiki: Java Edition version history](https://minecraft.wiki/w/Java_Edition_version_history)
- 26.1 "uses a new 'year.drop.hotfix' scheme, announced in December 2025", is "the first to require Java 25" (bundled runtime is Microsoft OpenJDK 25), ships data pack format 101.1 / resource pack format 84.0, and "is fully unobfuscated, with no accompanying obfuscated variant" — [Minecraft Wiki: Java Edition 26.1](https://minecraft.wiki/w/Java_Edition_26.1)
- NeoForge's year-end post: snapshots use the form "26.1-snapshot-1"; the first hotfix of the second 2026 drop would be "26.2.1"; "1.21.11 is likely the last version with major component 1" — [NeoForge: 2025 retrospection, 2026-01-01](https://neoforged.net/news/2025-retrospection/)
- Conflicting claim to ignore: a JavaCodeGeeks piece says 26.1 "released in December 2025"; the Wiki shows December 2025 was the first *snapshot*, with the release on 2026-03-24 — [Minecraft Wiki](https://minecraft.wiki/w/Java_Edition_version_history) vs [JavaCodeGeeks](https://www.javacodegeeks.com/?p=141499)
- The "1.22" nickname is unofficial: a Modrinth mod ("Notch's Versioning") maps 26.1 → "1.22" while a Minecraft Wiki user draft maps it to "1.29"; neither is Mojang's — [Modrinth project](https://modrinth.com/project/vgLXxbmB); [Wiki user page](https://minecraft.wiki/w/User:3A/Other/New_versioning_system/Development_versions)

**Fabric**
- Fabric's 26.3 post (2026-09-15, release day): "Use the latest stable version, currently 0.19.5" of Fabric Loader; developers should use Loom 1.17 and Gradle 9.6.0 — [Fabric for Minecraft 26.3](https://fabricmc.net/2026/09/15/263.html)
- Fabric API's first 26.3-tagged release, 0.160.5+26.3, was published 2026-09-14 20:06 UTC — the evening before Minecraft 26.3 released; the latest is 0.162.0+26.3 (2026-10-06). The first 26.2 release, 0.152.1+26.2, landed 2026-06-15 09:50 UTC (26.2 released 2026-06-16) — Modrinth API, `fabric-api` versions
- Fabric API already publishes for 26.4 snapshots (0.162.2+26.4 for 26.4-snapshot-3, 2026-10-06) — Modrinth API, [Fabric API on Modrinth](https://modrinth.com/mod/fabric-api)
- `meta.fabricmc.net/v2/versions/game` lists 26.4-snapshot-3/2/1, 26.3, 26.3-rc-3… as supported game versions; stable versions are 26.3, 26.2, 26.1.2, 26.1.1, 26.1, 1.21.11; loader 0.19.5 is the only stable loader (0.19.4/3/2 unstable). Fabric Loader 0.19.5's jar is dated 2026-08-28 — [Fabric meta API](https://meta.fabricmc.net/v2/versions/loader); maven.fabricmc.net
- Fabric meta returns intermediary "0.0.0" for 26.1 and 26.3 (versus "1.21.11" for 1.21.11) — i.e., there is no real intermediary layer for 26.x — [Fabric meta intermediary endpoint](https://meta.fabricmc.net/v2/versions/intermediary/26.3)
- Fabric's blog release cadence: posts for 26.1 (2026-03-14), 26.2 (2026-06-15), 26.3 (2026-09-15), i.e., on or before each Minecraft release day — [Fabric blog index](https://fabricmc.net/blog/)

**NeoForge**
- NeoForge Maven: 26.3 builds run from 26.3.0.0-beta (POM dated 2026-09-15 19:30 UTC, i.e., release day) through 26.3.0.75-beta to **26.3.0.76 (no `-beta`, 2026-10-11)** — 75 versions in four weeks. 26.2 runs 26.2.0.0-beta (2026-06-16) to 26.2.0.90 (2026-10-10); first non-beta 26.2 build was 26.2.0.57. 26.1 has 163 versions from 26.1.0.0-alpha.1+snapshot-1 to 26.1.2.116. 21.1.259 (for 1.21.1) is still being released — [NeoForge maven-metadata.xml](https://maven.neoforged.net/releases/net/neoforged/neoforge/maven-metadata.xml), POM Last-Modified headers
- NeoForge's own 2025 statistics: "Initial NeoForge releases came within roughly 40 minutes to 2 hours 55 minutes of each Minecraft release"; 1.21.1 "over 16000 mods", growing faster than Forge 1.20.1 did; 633 PRs merged in 2025; Maven served 1.4 billion requests / ~383 TB — [NeoForge: 2025 retrospection](https://neoforged.net/news/2025-retrospection/)
- NeoForge 26.1 release post (2026-03-24): versions now have four components, "the first three match the Minecraft version and the last is the NeoForge release number" (e.g. `26.1.0.10-beta`); "The `-beta` suffix means breaking changes are still allowed"; the author's *personal* guess is that "26.1 will likely become the next stable modding version, replacing 1.21.1"; maintainers are "short-staffed" — [NeoForge for Minecraft 26.1](https://www.neoforged.net/news/26.1release/)
- NeoForge published a snapshot-release program for 26.1-snapshot-1 (2025-12-26), after "significant manual work" porting to the unobfuscated jar — [NeoForge for 26.1 Snapshots](https://www.neoforged.net/news/26.1snapshots/); [news index](https://neoforged.net/news/)
- No blog post exists for 26.2 or 26.3 (both `/news/26.2release/` and `/news/26.3release/` return 404; the news index's newest post is 2026-05-11). Status must be read from Maven — [NeoForge news](https://neoforged.net/news/)
- Mod author anecdotes: JEI 31.0.0.x "for NeoForge 26.3" shipped within days and "fixing NeoForge client regressions in 26.3"; one author notes "MDG 2.0.147 builds" 26.3 cleanly after an older ModDevGradle failed — [JEI CurseForge file](https://www.curseforge.com/minecraft/mc-mods/jei/files/8918192); [Crow Bar changelog](https://www.curseforge.com/minecraft/mc-mods/crow-bar/files/8904494)

**Forge (MinecraftForge, LexManos)**
- Forge's files site lists 26.3 as "Download Latest": Forge 66.0.10 dated 2026-10-09; sidebar has 26.3, 26.2, 26.1 (26.1.2/26.1.1/26.1), 1.21.11 and older — [files.minecraftforge.net](https://files.minecraftforge.net/net/minecraftforge/forge/)
- Forge 66.0.0 for 26.3 appeared 2026-09-19 (four days after Minecraft 26.3); 65.0.0 for 26.2 on 2026-06-17 (one day after 26.2). `promotions_slim.json`: `26.3-latest: 66.0.10`, `26.2-latest: 65.1.3`, `26.2-recommended: 65.1.0`, `26.1.2-recommended: 64.1.0`, `1.21.11-recommended: 61.2.0` — [index_26.3.html](https://files.minecraftforge.net/net/minecraftforge/forge/index_26.3.html); [promotions_slim.json](https://files.minecraftforge.net/net/minecraftforge/forge/promotions_slim.json)
- ForgeGradle 7.0.20 is the latest on the Gradle Plugin Portal (2026-04-09); the Forge files page for ForgeGradle still shows 7.0.0-beta.1 (2025-06-09) — [plugins.gradle.org net.minecraftforge.gradle](https://plugins.gradle.org/plugin/net.minecraftforge.gradle); [ForgeGradle files](https://files.minecraftforge.net/net/minecraftforge/forgegradle/index.html)

**Quilt**
- Quilt meta lists 26.3, 26.3-rc-3… as game versions and loader 0.31.0-beta.4 (jar dated 2026-10-12) as newest; the loader list for 26.3 has 307 entries (Quilt Loader is version-independent, like Fabric Loader) — [meta.quiltmc.org game](https://meta.quiltmc.org/v3/versions/game); [loader](https://meta.quiltmc.org/v3/versions/loader)
- Quilt's 2026-02-03 post: Quilt Mappings "will not be released for future Minecraft versions"; QSL, Quilt Kotlin Libraries and QFAPI "are being retired in Minecraft 26.1" (maintenance for older versions only) because maintenance "has fallen largely on one developer, Oro" and the QFAPI compat layer "confuses users and developers"; CHASM "officially retired" (MixinExtras covers its use cases); Quilt is "exploring bringing some of its innovations back to Fabric API"; the project is "run by volunteers" with "no release dates committed" — [Bringing Quilt into the non-obfuscated era](https://quiltmc.org/en/blog/2026-02-03-non-obfuscated-updates)
- The QSL/QFAPI Modrinth project was last updated 2024-12-02 and tops out at 1.21 — Modrinth API, [QSL/QFAPI](https://modrinth.com/mod/qsl)
- Quilt's blog had no posts between July 2024 and February 2026 — [Quilt blog](https://quiltmc.org/en/blog/1)

**Market share (Modrinth, project counts of type `mod`, 2026-10-12)**
| MC version | Fabric | NeoForge | Forge | Quilt* |
|---|---|---|---|---|
| 26.3 | 7,341 | 4,107 | 2,152 | 2,272 |
| 26.2 | 12,873 | 6,664 | 3,337 | 3,369 |
| 26.1 | 10,778 | 6,174 | 3,309 | 3,451 |
| 1.21.11 | 17,849 | 8,095 | 4,403 | 4,388 |
| 1.21.1 | 19,514 | 21,277 | 5,399 | 4,776 |
| 1.20.1 | 17,661 | 5,074 | 25,151 | 4,946 |
| all versions | 46,914 | 29,731 | 35,076 | 10,431 |
Source: Modrinth search API, `total_hits` per facet query (see data-collection note). *The Quilt column is almost entirely Fabric mods whose authors tick the "Quilt" compatibility box; Quilt-only APIs stopped at 1.21.
- Downloads of flagship libraries (Modrinth, 2026-10-12): Fabric API 276.4 M; Sodium 243.5 M (now ships Fabric *and* NeoForge builds, mc26.3-0.9.3-alpha.1); Fabric Language Kotlin 127.0 M; Architectury API 104.9 M; JEI 82.5 M (Fabric + NeoForge for 26.3, 31.12.0.65 on 2026-10-12); Kotlin for Forge 53.5 M; Forgified Fabric API 30.0 M; Sinytra Connector 26.5 M; Create 27.5 M (NeoForge, still 1.21.1 only, last update 2026-04-21) — Modrinth API
- Qualitative share commentary (hosting/blog sources, lower confidence): "ATM10 and most modpacks released in 2025–2026 target NeoForge"; NeoForge "has taken over tech and content mods, while Fabric remains the king of performance" — [GuildOrder guide](https://guildorder.com/games/minecraft/guides/modpack-clan-management); [mineguard.pro](https://mineguard.pro/en/blog/neoforge-vs-forge-vs-fabric-2026)
- Counter-anecdote: a Fabric mod author's March 2026 CurseForge page says they dropped NeoForge because Fabric got "as much as 500x more downloads" of their mod — one creator, not a platform statistic — [CurseForge page via search](https://www.curseforge.com/minecraft/mc-mods/betterstats/files/7822495)

### Inferences
- For a brand-new project targeting 26.3, the live choice is Fabric or NeoForge; Forge 26.x exists but its Modrinth catalogue for 26.3 is ~30% of Fabric's and the Forge→NeoForge migration of big mods (JEI, Sodium, Architectury all ship "neoforge", not "forge", for 26.3) is complete.
- Fabric reaches a new drop slightly faster (Fabric API the night before release; NeoForge ~hours after), but both are "release-day" loaders now; the practical lag is in *mods*, not loaders. NeoForge's 26.3 took ~4 weeks (75 betas) to drop the `-beta` tag.
- Quilt should be treated as a Fabric Loader alternative for players, not a development target: there is no Quilt-specific API for 26.x.
- The "stable modding version" split: the big content/modpack scene still sits on 1.21.1 (NeoForge 21.1.x still receiving releases; Create unported), while the performance/utility scene has moved to 26.x on Fabric. NeoForge's own maintainer guessed 26.1 would become the next long-lived version; the Maven data (26.1.2.116 still being built) is consistent with that.

### Gaps
- No CurseForge per-loader counts: CurseForge's API needs a key and the search found only an aggregator (moddex.gg, ~152k mods across both platforms, mixed snapshot dates) — [moddex.gg](https://moddex.gg/projects?page=611). CurseForge is historically Forge/NeoForge-heavier than Modrinth, so the Modrinth table likely overstates Fabric's overall share.
- No official NeoForge statement on 26.2/26.3 stabilisation (no blog posts); the non-beta status is inferred from version strings only.
- Forge's Java/ForgeGradle requirements for 26.x were not found in primary docs (docs.minecraftforge.net still indexes FG 5.x/6.x pages).
- Reddit is blocked to the crawler, so no 2025–2026 r/fabricmc / r/feedthebeast sentiment threads could be read directly.

## Key Question 2: What does the dev toolchain look like for each loader?

### Takeaway
Both main toolchains converged in 2026: JDK 25, Gradle 9.x, Mojang's official names (no remapping), IntelliJ IDEA as the primary IDE, `gradlew runClient`. Fabric = Loom 1.17/1.18 under the new `net.fabricmc.fabric-loom` plugin ID with plain `implementation` deps and `jar` (no `remapJar`); NeoForge = ModDevGradle 2.0.14x (NeoGradle 7.1.x still maintained) with Parchment now optional.

### Cited Findings

**Java / Gradle / IDE**
- Fabric docs: "To develop mods for Minecraft 26.1, you will need JDK 25"; IntelliJ IDEA is "recommended", VS Code is the alternative (Eclipse not mentioned) — [Fabric docs: Setting up](https://docs.fabricmc.net/develop/getting-started/setting-up)
- Fabric 26.1 post: "Java 25 is the minimum for the Gradle JVM"; "IntelliJ IDEA 2025.3 or later is required for mixins to work correctly"; Loom 1.15 + Gradle 9.4.0 at the time — [Fabric for Minecraft 26.1](https://fabricmc.net/2026/03/14/261.html)
- Fabric 26.2 post: Loader 0.19.3 stable; Loom 1.17; Gradle 9.5.1; Loader 0.19.0 added the enum extension API — [Fabric for Minecraft 26.2](https://fabricmc.net/2026/06/15/262.html)
- Fabric 26.3 post: Loader 0.19.5; Loom 1.17; Gradle 9.6.0 — [Fabric for Minecraft 26.3](https://fabricmc.net/2026/09/15/263.html)
- NeoForge docs (version 26.1): requires "An installation of the Java 25 Development Kit (JDK) and 64-bit Java Virtual Machine", recommends Microsoft's OpenJDK builds; "NeoForge officially supports IntelliJ IDEA and Eclipse"; other editors work but Minecraft-source lookup only in those two; build with `gradlew build` (output in `build/libs`), run with `gradlew runClient` (from `runs/client`) or `gradlew runServer` (accept `eula.txt`, set `online-mode=false`) — [NeoForge docs: Getting Started](https://docs.neoforged.net/docs/gettingstarted/)
- NeoForge 26.1 post: set `languageVersion` to `JavaLanguageVersion.of(25)` (was 21); "Gradle 9.1.0 or newer is required"; ModDevGradle 2.0.141, NeoGradle 7.1.21 at release — [NeoForge for Minecraft 26.1](https://www.neoforged.net/news/26.1release/)
- Current plugin versions (maven metadata, 2026-10-12): ModDevGradle latest 2.0.148 (2026-09-29); NeoGradle userdev latest 7.1.39 (2026-09-15); Fabric Loom latest release line 1.18.4 with 1.19.0-alpha.2 (2026-10-10) — [Gradle plugin portal, net.neoforged.moddev](https://plugins.gradle.org/m2/net/neoforged/moddev/net.neoforged.moddev.gradle.plugin/maven-metadata.xml); [maven.neoforged.net gradle/userdev](https://maven.neoforged.net/releases/net/neoforged/gradle/userdev/maven-metadata.xml); [maven.fabricmc.net fabric-loom](https://maven.fabricmc.net/net/fabricmc/fabric-loom/maven-metadata.xml)

**Fabric Loom and the unobfuscated migration**
- Loom release notes: 1.12 (29 Oct 2025) "the last version of Loom to support Gradle 8.x"; 1.14 (4 Dec 2025) requires Gradle 9.2 and adds "`net.fabricmc.fabric-loom` to be used for non-obfuscated versions" (old `fabric-loom` ID kept for compatibility), noting "1.21.11" as the last obfuscated version; 1.15 (22 Jan 2026) drops the FernFlower decompiler; 1.16 (20 Apr 2026) minimum Gradle 9.4; 1.17 (7 Jun 2026) Gradle 9.5, new property-based RunConfiguration API, `preferGradleTask`; 1.18 (20 Sep 2026) uses Gradle task-based run configurations by default, replaces `fabric-loom-native` with Java 25's FFM API, experimental `microsoftLogin` task — [Fabric Loom releases](https://github.com/FabricMC/fabric-loom/releases)
- Migration steps (26.1): switch plugin from `net.fabricmc.fabric-loom-remap`/`fabric-loom` to `net.fabricmc.fabric-loom` ("the new plugin doesn't remap Minecraft or mods"); `modImplementation`/`modCompileOnly` → `implementation`/`compileOnly`; `remapJar` → `jar`; "Mods built for 1.21.11 or earlier won't work without at least recompilation"; "Yarn is no longer officially supported, so move to Mojang's mappings"; the `fabric` mod id is gone — depend on `fabric-api` — [Fabric for Minecraft 26.1](https://fabricmc.net/2026/03/14/261.html)
- Fabric's Oct 2025 plan: "Intermediary will no longer exist; the game will use Mojang's names at runtime"; a possible slimmer "Loom 2.0" with no remapping is "still in the design phase"; Loom's migrate-mappings tooling helps rename Yarn code — [Removing Obfuscation from Fabric](https://fabricmc.net/2025/10/31/obfuscation.html)
- Fabric porting guide (26.1→26.2): update `gradle-wrapper.properties` (`./gradlew wrapper --gradle-version latest`), bump Minecraft/Loader/Loom/API in `gradle.properties`, re-sync in IntelliJ or `./gradlew --refresh-dependencies`; vanilla code changes are documented in Fabric's blog, the Minecraft Wiki and NeoForge's migration primers — [Fabric docs: Porting](https://docs.fabricmc.net/develop/porting/)

**NeoForge ModDevGradle vs NeoGradle**
- ModDevGradle README: "A Gradle plugin for developing Minecraft mods using NeoForge"; compiles against NeoForge artifacts, runs the game from Gradle or IntelliJ, supports the Gradle configuration cache; Parchment supported via `gradle.properties`/`build.gradle`; a "Vanilla mode" (set a NeoForm version instead of a NeoForge version) yields plain Minecraft jars with `client`/`server`/`data` runs; run-config example passes `-XX:+AllowEnhancedClassRedefinition`; a `LEGACY.md`/`legacytest` cover legacy-Forge use — [ModDevGradle README](https://github.com/neoforged/ModDevGradle)
- NeoForge's 2025 retrospective names only MDG ("our Gradle plugins… MDG") for new features: binaries-without-sources for faster CI, shared asset cache GitHub Action, and from 1.21.9 "`additionalRuntimeClasspath` is no longer needed. Standard configurations such as `implementation` work instead" — [NeoForge: 2025 retrospection](https://neoforged.net/news/2025-retrospection/)
- The NeoForge Mod Generator offers a choice of ModDevGradle or NeoGradle; docs note the differing Minecraft-source paths (`ng_dummy_ng.net.neoforged:neoforge:<version>` vs `minecraft-patched-<version>-merged.jar`) — [NeoForge docs: Getting Started](https://docs.neoforged.net/docs/gettingstarted/)

**Mappings**
- Mojang (2025-10-29): "Starting with the first snapshot following the complete Mounts of Mayhem launch, we will no longer obfuscate Minecraft: Java Edition… all future builds will have all of our original names – now with variable names and other names – included by default"; "No more obfuscation maps in version .jsons"; experimental unobfuscated builds shipped alongside obfuscated snapshots first — [Removing obfuscation in Java Edition](https://www.minecraft.net/en-us/article/removing-obfuscation-in-java-edition) (page `datePublished` 2025-10-29)
- NeoForge: "official mappings have been available since 1.14, and NeoForge has used them since 1.17. The main gains are official method parameter names, which replace crowd-sourced Parchment names" — [NeoForge: 2025 retrospection](https://neoforged.net/news/2025-retrospection/)
- NeoForge 26.1: "Parchment is no longer needed. You can delete its `gradle.properties` lines, or keep it for extra javadocs" — [NeoForge for Minecraft 26.1](https://www.neoforged.net/news/26.1release/)
- Parchment's version policy still says it "supports only Minecraft versions that have published obfuscation logs" and lists no 26.x — [Parchment: versions](https://parchmentmc.org/docs/versions); Quilt says "Parchment will continue producing developer documentation" — [Quilt 2026-02-03](https://quiltmc.org/en/blog/2026-02-03-non-obfuscated-updates)
- Yarn: Fabric "can't justify maintaining Yarn in its current state"; Yarn for existing versions still accepts contributions — [Removing Obfuscation from Fabric](https://fabricmc.net/2025/10/31/obfuscation.html). Quilt Mappings: discontinued for future versions — [Quilt 2026-02-03](https://quiltmc.org/en/blog/2026-02-03-non-obfuscated-updates)

**Template generators**
- Fabric: generator at fabricmc.net/develop/template; required fields are mod name, package name, Minecraft version; "Advanced Options include Kotlin, Kotlin buildscripts, and data generators"; manual alternative is cloning `fabric-example-mod`; avoid cloud-synced folders, non-ASCII or spaces in the path; template is CC0 — [Fabric docs: Creating a Project](https://docs.fabricmc.net/develop/getting-started/creating-a-project); [fabricmc.net/develop/template](https://fabricmc.net/develop/template/)
- NeoForge: generator at neoforged.net/mod-generator ("Download Mod Project" ZIP); "in early stages"; exists as an embeddable Vue app and a CLI (`npm run test-generate-mdg`) — [NeoForge mod generator](https://neoforged.net/mod-generator/); [neoforged/mod-generator](https://github.com/neoforged/mod-generator)

**Run / hot-reload workflow**
- Fabric docs structure (version 26.2): Getting started → Creating a Project, Project Structure, Setting Up Your IDE, Opening a Project, Launching the Game (per-IDE pages for IntelliJ IDEA and VS Code), Generating Sources, Building a Mod, IDE Tips — [Fabric docs: Develop](https://docs.fabricmc.net/develop/); [Launching the Game](https://docs.fabricmc.net/develop/getting-started/launching-the-game)
- Hot swap (older Fabric wiki, last edited 2024, now pointing to docs.fabricmc.net): plain debugger hotswap only changes method bodies; for structural changes use JetBrains Runtime with `-XX:+AllowEnhancedClassRedefinition`; assets reload with F3+T, data packs with `/reload`; Mixin hotswap needs the Sponge Mixin jar passed as `-javaagent` — [Fabric wiki: hotswapping](https://wiki.fabricmc.net/_export/xhtml/tutorial:hotswapping); [Mixin hotswaps](https://wiki.fabricmc.net/tutorial:mixin_hotswaps)
- ModDevGradle's documented run config also uses `-XX:+AllowEnhancedClassRedefinition` — [ModDevGradle README](https://github.com/neoforged/ModDevGradle)

### Inferences
- The unobfuscated jar removed the slowest step of first-time setup (remapping/decompiling Minecraft and every mod dependency), so the Fabric and NeoForge toolchains are now structurally similar: compile against the real Minecraft jar plus the loader's API, no intermediary. Fabric's own Oct 2025 post promised "a simpler, faster toolchain" for this reason.
- The Fabric docs' Java sentence still says "26.1" on a "26.2" page, and the Develop version selector tops out at 26.2 — docs lag releases by roughly one drop; the blog posts are the authoritative per-version source.
- For NeoForge, ModDevGradle is the de-facto default (it is the one NeoForge's own posts talk about and the one the generator's test script targets); NeoGradle is still released (7.1.39, Sept 2026) but is the legacy path.

### Gaps
- No primary source gives first-build wall-clock times for 26.x; the docs pages do not estimate it. (Pre-2026 builds were dominated by decompile/remap, which no longer happens; treat any specific number as unverified.)
- The Fabric per-IDE launching pages (`.../launching-the-game/intellij-idea`) returned 404 at the guessed URL, so current hot-swap guidance was only confirmed from the older wiki.
- The generators' live option lists (Minecraft version menus, Mojang-mappings toggle) are rendered client-side and were not captured.

## Key Question 3: Fabric vs NeoForge — API philosophy, mixins, access wideners/transformers, events, cross-loader frameworks

### Takeaway
Fabric stays a thin loader plus an optional, modular Fabric API where "use a mixin or create your own event" is the documented fallback; NeoForge is batteries-included with a central event bus (game bus + per-mod bus), access transformers, and a large patched surface. Cross-loader tooling is alive in 2026: Architectury 22.0.5 ships for 26.3, Forgified Fabric API covers 26.2, and Sinytra Connector's primary target is 26.1.2 (not yet 26.2/26.3).

### Cited Findings

**Fabric**
- Fabric API events: an `Event` instance holds callbacks exposed via a static `EVENT` field; listeners call `register()`; custom events are built from a callback interface, a Mixin injection (the docs example injects into `Sheep#mobInteract`), and `InteractionResult` semantics (`PASS` continues, `SUCCESS` finishes, `FAIL` cancels); "because some areas of the game lack Fabric API hooks, you can either use a mixin or create your own event" — [Fabric docs: Events (26.2)](https://docs.fabricmc.net/develop/events)
- Fabric docs "Tooling" section: Loom, Loader, Porting, Mixins (Java Bytecode, Accessors), **Class Tweakers** (Access Widening, Interface Injection, Enum Extension) — i.e., Fabric's access-widener successor is now called a class tweaker, and enum extension arrived with Loader 0.19.0 — [Fabric docs: Develop](https://docs.fabricmc.net/develop/); [Fabric for Minecraft 26.2](https://fabricmc.net/2026/06/15/262.html)
- Loom 1.13 added `migrateClassTweakerMappings`; 1.15 added `loom.defaultMixinRemapType` for unobfuscated versions — [Fabric Loom releases](https://github.com/FabricMC/fabric-loom/releases)
- Fabric API churn in 26.x shows the "data-driven vanilla" direction: 26.3 removed `CompostingChanceRegistry`, `FuelRegistry`, `FabricPotionBrewingBuilder`, `StrippableBlockRegistry`, `TillableBlockRegistry`, `FlattenableBlockRegistry` because compost/fuel are now item components, brewing recipes are JSON, and block transformers are a vanilla data type; recipes and advancements became "reloadable dynamic registries" — [Fabric for Minecraft 26.3](https://fabricmc.net/2026/09/15/263.html). 26.1 renamed many APIs to Mojang names (`ItemGroupEvents` → `CreativeModeTabEvents`) with an IntelliJ migration map, removed `HudRenderCallback` (use `HudElementRegistry`), and villager trades went data-driven (replacing `TradeOfferHelper`) — [Fabric for Minecraft 26.1](https://fabricmc.net/2026/03/14/261.html)

**NeoForge**
- Events: game bus `NeoForge.EVENT_BUS` for gameplay, a per-mod bus (passed to the mod constructor) for lifecycle; register via `IEventBus#addListener`, `@SubscribeEvent`, or `@EventBusSubscriber` (auto-discovered, static handlers, routes to the right bus); `ICancellableEvent` with `setCanceled`/`receiveCanceled`; priorities HIGHEST…LOWEST; mod-bus events may dispatch in parallel; listening to abstract base events crashes the game — [NeoForge docs: Events (26.1)](https://docs.neoforged.net/docs/concepts/events)
- Access transformers: lines like `public-f` + fully-qualified target with JVM descriptors; default file `src/main/resources/META-INF/accesstransformer.cfg` (ModDevGradle picks it up automatically; NeoGradle needs `minecraft { accessTransformers { file ... } }`); other paths declared under `[[accessTransformers]]` in `neoforge.mods.toml`; overrides are not transformed — [NeoForge docs: Access Transformers (26.1)](https://docs.neoforged.net/docs/advanced/accesstransformers)
- FancyModLoader changes in 2025: conditional Mixin configs per mod, `@Mod` entrypoints gated on other mods, `javafml` default, `@EventBusSubscriber` no longer needs a bus type, FML has its own MixinService, "Mixin compatibility levels", a rewritten module-style class loader, removal of ModLauncher/SecureJarHandler/BootstrapLauncher — [NeoForge: 2025 retrospection](https://neoforged.net/news/2025-retrospection/)
- NeoForge API surface examples (26.1): `ItemStackTemplate`/`FluidStackTemplate` records (stacks need loaded registries now), `GuiGraphics` → `GuiGraphicsExtractor` (`Screen#render` → `extractRenderState`), `MutableQuad` helper, data maps, the 1.21.9 transfer-API rework with transactions and `ResourceHandler` — [NeoForge for Minecraft 26.1](https://www.neoforged.net/news/26.1release/); [The Transfer Rework](https://www.neoforged.net/news/21.9-transfer-rework/)

**Cross-loader**
- Architectury API 22.0.5 published 2026-10-09 for 26.3 on both Fabric and NeoForge (21.1.12 for 26.2); project lists loaders fabric/forge/neoforge/quilt; 104.9 M downloads — Modrinth API, [Architectury API](https://modrinth.com/mod/architectury-api). Its GitHub README (viewed on the 1.19.2 branch) describes it as abstracting "calls to fabric api and forge api" and marks only the old example mod as discontinued — [architectury-api on GitHub](https://github.com/architectury/architectury-api)
- Sinytra Connector: "A compatibility layer that allows running Fabric mods on NeoForge"; README: **26.1.2 is the "primary supported version"**, 1.21.1 is LTS (critical fixes only); "Development capacity is limited"; requires Forgified Fabric API; latest build 3.0.0-beta.6+26.1.2 (2026-08-15) — [Sinytra/Connector](https://github.com/Sinytra/Connector); Modrinth API, [Connector](https://modrinth.com/mod/connector)
- Forgified Fabric API: "a direct port of Fabric API for the NeoForge modloader"; newest 0.161.0+26.2+4.0.1 (2026-10-10) for 26.2, plus 0.155.3+26.1.2 for 26.1.x; no 26.3 yet — Modrinth API, [FFAPI](https://modrinth.com/mod/forgified-fabric-api); [CurseForge page](https://www.curseforge.com/projects/889079)
- Mods now routinely ship both loaders natively: Sodium (Fabric + NeoForge, 26.3), JEI (Fabric + NeoForge, 26.3), Architectury — Modrinth API

### Inferences
- The gap between "thin" Fabric and "batteries-included" NeoForge is narrower in 26.x than in 1.20: Mojang's data-driven changes (components for fuel/compost, JSON brewing, data-driven trades, dynamic registries) keep deleting whole Fabric API modules, and NeoForge's FML rewrite trimmed its startup machinery. The real remaining difference is the event model (callback fields vs a bus with priorities/cancellation) and NeoForge's deeper vanilla patches (capabilities/transfer, data maps).
- If a hobby project needs both loaders, native dual builds via Architectury 22 are the proven 26.3 path; Connector is a *player-side* bridge that currently lags two drops behind (26.1.2), so it should not be relied on for 26.3 modpacks.

### Gaps
- No primary 2026 source compares Fabric vs NeoForge startup/perf or API stability quantitatively.
- Connector's own compatibility list (project website) was not fetched, so the set of Fabric mods that break under it is unknown.

## Key Question 4: Kotlin and other JVM languages

### Takeaway
Kotlin is first-class on both loaders and tracks Kotlin 2.4.x: Fabric Language Kotlin 1.14.2 (Kotlin 2.4.21) and Kotlin for Forge 6.4.0 both support 26.3 as of October 2026; Fabric's generator can emit a Kotlin project.

### Cited Findings
- Fabric Language Kotlin 1.14.2+kotlin.2.4.21 released 2026-10-09 for 26.1.2 / 26.2 / 26.3; 1.14.1+kotlin.2.4.20 (2026-09-07); 127.0 M downloads — Modrinth API, [Fabric Language Kotlin](https://modrinth.com/mod/fabric-language-kotlin)
- Kotlin for Forge 6.4.0 released 2026-10-10 for NeoForge 26.1.2 / 26.2 / 26.3; the 5.x line (5.12.0, 2026-06-28) still covers Forge+NeoForge 1.21.6–1.21.8; 6.x releases are NeoForge-only — Modrinth API, [Kotlin for Forge](https://modrinth.com/mod/kotlin-for-forge)
- Fabric's template generator "Advanced Options include Kotlin, Kotlin buildscripts" — [Fabric docs: Creating a Project](https://docs.fabricmc.net/develop/getting-started/creating-a-project)
- Quilt Kotlin Libraries are "being retired in Minecraft 26.1" — [Quilt 2026-02-03](https://quiltmc.org/en/blog/2026-02-03-non-obfuscated-updates)
- NeoForge removed Nashorn (JavaScript coremods) in 1.21.5 and the `lowcode` language loader; `javafml` is the default — [NeoForge: 2025 retrospection](https://neoforged.net/news/2025-retrospection/)

### Inferences
- Kotlin for Forge 6.x dropping the `forge` loader tag is another indicator that the language-adapter ecosystem has moved to NeoForge only for 26.x.

### Gaps
- No evidence found of maintained Scala/Groovy/Clojure language adapters for 26.x (not searched exhaustively; Fabric historically had `fabric-language-scala`/`-groovy` as community projects).
- NeoForge's own docs do not advertise a Kotlin option in the mod generator; whether the generator emits Kotlin was not confirmed.

## Key Question 5: Mojang's official stance — first-party API, EULA, mappings, data-driven direction

### Takeaway
As of October 2026, Mojang has announced no first-party Java modding API or "Add-Ons for Java"; its concrete 2025–2026 actions are removing obfuscation ("Modding is at the heart of Java Edition"), keeping the EULA/Usage Guidelines unchanged, adding a LICENSE file to the jar, and continuing to move gameplay systems into data-driven JSON — which both helps data-pack authors and keeps forcing loader APIs to shrink or rename.

### Cited Findings
- Mojang, 2025-10-29: "Modding is at the heart of Java Edition – and obfuscation makes modding harder… this should make it quicker and easier for modders to create and improve mods… crash logs will actually be readable!"; "We know that this change may pose challenges for existing modding tools… we're going to help modders prepare"; "No changes to EULA… these changes don't affect our Minecraft End User License Agreement and Minecraft Usage Guidelines. Both still apply to Minecraft: Java Edition and any mods"; "you'll now find a LICENSE file inside the jar that links directly to the EULA"; history: obfuscated "since its release", mappings published "in 2019" — [Removing obfuscation in Java Edition](https://www.minecraft.net/en-us/article/removing-obfuscation-in-java-edition)
- The first unobfuscated release is 26.1 (2026-03-24); the first snapshot was 26.1-snapshot-1 on 2025-12-16, after 1.21.11 ("Mounts of Mayhem", 2025-12) — [Minecraft Wiki: Java Edition 26.1](https://minecraft.wiki/w/Java_Edition_26.1); [version history](https://minecraft.wiki/w/Java_Edition_version_history)
- Mojang renamed `ResourceLocation` to `Identifier` in 1.21.11, i.e., Mojang is now actively curating public-facing names — [NeoForge: 2025 retrospection](https://neoforged.net/news/2025-retrospection/)
- EULA (current text): owners of Java Edition may "modify it by adding modifications, tools, or plugins"; "Mods" must be original work "that doesn't contain a substantial part of our copyrightable code or content"; "Mods are okay to distribute; hacked versions or Modded Versions of the game client or server software are not okay to distribute"; don't sell mods or profit from them, and the permissions can be withdrawn "at any time without notice" — [Minecraft EULA](https://minecraft.net/en-us/eula)
- Secondary coverage of the announcement reports the EULA and Usage Guidelines "remain unchanged" and frames the move as easing third-party modding — [ADTmag, 2025-11-04](https://adtmag.com/articles/2025/11/04/mojang-studios-to-remove-code-obfuscation-from-minecraft-java-edition.aspx); [GamingOnLinux, Oct 2025](https://www.gamingonlinux.com/2025/10/minecraft-java-modding-is-about-to-get-a-lot-easier-and-more-interesting)
- Data-driven direction visible in 26.x: brewing recipes are JSON; tilling/flattening/stripping are "a vanilla data type"; compost/fuel are item components; recipes and advancements are reloadable dynamic registries; configured features moved to `worldgen/feature`; villager trades data-driven (26.1) — [Fabric for Minecraft 26.3](https://fabricmc.net/2026/09/15/263.html); [Fabric for Minecraft 26.1](https://fabricmc.net/2026/03/14/261.html)
- Platform churn modders must absorb in 26.x: 26.2 added an experimental Vulkan backend with OpenGL "planned for removal once Vulkan is stable", so "mods that make raw OpenGL calls must move to the Blaze3D API"; 26.3 replaced GLFW with SDL for window/input ("some input constants changed, including all mouse buttons" — use `InputConstants`) — [Fabric 26.2](https://fabricmc.net/2026/06/15/262.html); [Fabric 26.3](https://fabricmc.net/2026/09/15/263.html); [Crow Bar changelog](https://www.curseforge.com/minecraft/mc-mods/crow-bar/files/8904494)
- Bedrock contrast: Bedrock Add-Ons are "the Minecraft: Bedrock Edition equivalent to Java Edition mods" with Mojang-maintained, backwards-compatible APIs; a hosting blog notes players asked whether Java would get Add-Ons and found no such plan — [Bedrock Wiki](https://wiki.bedrock.dev/guide/introduction); [BisectHosting](https://www.bisecthosting.com/pl-pl/blog/can-minecraft-add-ons-be-used-on-java-edition)
- Fabric's reading of Mojang's intent: after deobfuscation modders get "a simpler, faster toolchain, better logs and crash reports, and new debugging options" — [Removing Obfuscation from Fabric](https://fabricmc.net/2025/10/31/obfuscation.html)

### Inferences
- Mojang's posture is "make the community loaders' lives easier, don't replace them": no API, no SDK, but readable code, a license pointer in the jar, and (per NeoForge) consideration of jar patching at startup becoming simpler. The EULA's "no substantial part of our code" rule is unchanged, so shipping patched Minecraft classes remains off-limits — the loaders still patch at runtime.
- The data-driven trend means a surprising share of 2026 "modding" (recipes, trades, brewing, block transformers, worldgen features) is reachable from a data pack — relevant to a kids' program that already uses data packs, and it means loader-API tutorials rot faster because those APIs get deleted when vanilla absorbs the feature.

### Gaps
- No Mojang statement about an official Java modding API, a Java "Add-Ons" program, or any roadmap for one was found in 2025–2026 primary sources; absence of evidence, not a denial.
- The current Minecraft Usage Guidelines text was not fetched; monetisation rules for mods (CurseForge rewards, Patreon early access) should be checked there directly.

## Key Question 6: Up-to-date learning resources and which older tutorials are now wrong

### Takeaway
Use docs.fabricmc.net (version-switchable, 26.2 current) and docs.neoforged.net (26.1 current) plus each loader's per-drop blog post; the old wiki.fabricmc.net redirects beginners to the new docs and warns its playlists are out of date. Anything that mentions Yarn/intermediary, `modImplementation`/`remapJar`, Parchment as a requirement, Java 17/21, Gradle 8, `ResourceLocation`, `ItemGroupEvents`, `HudRenderCallback`, raw GLFW key codes, or `FuelRegistry`/brewing builders is pre-26.x and will not compile against 26.3.

### Cited Findings
- Fabric docs (version selector: 26.2, 26.1.2, 1.21.11, 1.21.1, 1.20.4; 26.3 not yet listed on 2026-10-12) cover Getting started, Items/Blocks/Fluids/Entities/Events/Sounds/Commands/Recipes/Rendering/Data Generation/Registries/Serialization, Tooling (Loom, Loader, Porting, Mixins, Class Tweakers), Automated Testing, Debugging, Networking, with a reference mod in `/reference` on GitHub — [Fabric docs: Develop](https://docs.fabricmc.net/develop/)
- The legacy Fabric wiki's start page now sends new modders to docs.fabricmc.net ("Introduction to Fabric and Modding", "Creating Your First Item") and labels its own pages as "older version"; it flags Kaupenjoe's Fabric 1.21/1.20 playlists as possibly containing "out of date content" — [wiki.fabricmc.net tutorial:start](https://wiki.fabricmc.net/_export/raw/tutorial:start)
- NeoForge docs are versioned, current label "26.1"; Getting Started, Events, Access Transformers pages confirmed — [docs.neoforged.net](https://docs.neoforged.net/docs/gettingstarted/)
- Per-drop migration primers: Fabric's blog posts for 26.1/26.2/26.3 and NeoForge's "26.1 → 26.2 migration primer" (linked from Fabric's porting page) are the canonical "what changed" lists — [Fabric docs: Porting](https://docs.fabricmc.net/develop/porting/); [Fabric blog](https://fabricmc.net/blog/)
- Fabric: "Fabric Docs will publish examples after release" for 26.3's new data-generation JSON — [Fabric 26.3](https://fabricmc.net/2026/09/15/263.html)
- Kaupenjoe (the most-searched tutorial brand): courses found are Forge 1.20.x (Udemy, "last updated 6/2024"), Forge 1.18.1 and 1.16.x (Skillshare); a mirror page lists unattributed "NeoForge Modding Tutorial – Minecraft 26.1" videos; no confirmed Kaupenjoe 26.x series was found — [Udemy](https://www.udemy.com/course/minecraft-modding-120x-for-forge/); [Skillshare](https://www.skillshare.com/en/classes/modding-by-kaupenjoe-forge-modding-for-minecraft-1-18-1/63347687); [mirror listing](https://old.fbpe.org/neoforge-modding-tutorial-minecraft-1-21-custom-blocks-3.html)
- Things that changed and therefore date a tutorial (each with the primary source):
  - Yarn/intermediary/remapping, `modImplementation`, `remapJar`, plugin id `fabric-loom` → gone in 26.1 — [Fabric 26.1](https://fabricmc.net/2026/03/14/261.html)
  - Parchment lines in `gradle.properties` → optional — [NeoForge 26.1](https://www.neoforged.net/news/26.1release/)
  - Java 21 → Java 25; Gradle 8 → 9.x — [NeoForge 26.1](https://www.neoforged.net/news/26.1release/); [Loom 1.12/1.14 notes](https://github.com/FabricMC/fabric-loom/releases)
  - `ResourceLocation` → `Identifier` (1.21.11) — [NeoForge retrospection](https://neoforged.net/news/2025-retrospection/)
  - `ItemGroupEvents` → `CreativeModeTabEvents`, `HudRenderCallback` → `HudElementRegistry`, `ColorProviderRegistry` → `BlockColorRegistry`, `TradeOfferHelper` → data-driven trades, `fabric` mod id → `fabric-api` — [Fabric 26.1](https://fabricmc.net/2026/03/14/261.html)
  - `Minecraft.getInstance().setScreen()` → `.gui.setScreen()`; raw OpenGL → Blaze3D; block/item id storage split — [Fabric 26.2](https://fabricmc.net/2026/06/15/262.html)
  - `FuelRegistry`, `CompostingChanceRegistry`, brewing builders, strippable/tillable/flattenable registries → components / JSON / `BlockTransformerHelper`; GLFW constants → `InputConstants` — [Fabric 26.3](https://fabricmc.net/2026/09/15/263.html)
  - NeoForge: `GuiGraphics` → `GuiGraphicsExtractor`, `new ChunkPos(blockPos)` → `ChunkPos.containing`, `ItemStack` creation needs loaded registries (`ItemStackTemplate`) — [NeoForge 26.1](https://www.neoforged.net/news/26.1release/); `@OnlyIn` stripping removed, `additionalRuntimeClasspath` unnecessary (1.21.6–1.21.9) — [NeoForge retrospection](https://neoforged.net/news/2025-retrospection/)
- Community "which loader" guidance (hosting blogs, 2026; low authority but consistent): pick the loader your target mods/modpack already use; Fabric for lightweight/performance/snapshot-chasing, NeoForge for large content packs — [icedfoxstudios](https://www.icedfoxstudios.com/tutorials/fabric-vs-neoforge-minecraft-modding-2026/); [space-node](https://space-node.net/blog/fabric-vs-neoforge-minecraft-2026); [GDLauncher docs](https://gdlauncher.com/docs/mod-loaders-compared)

### Inferences
- Practical rule for 2026: trust only material that targets 26.1 or later (anything from 1.21.11 or earlier predates deobfuscation and the Java 25 bump), and prefer the loader's own docs + blog + the generated template over video series, since YouTube series have not visibly caught up to 26.x.
- Because both docs sites lag a drop (Fabric 26.2, NeoForge 26.1 while the game is on 26.3), expect to read the 26.3 blog post / NeoForge primer alongside the docs.

### Gaps
- No verified 2025–2026 video tutorial series for 26.x was identified (Kaupenjoe's 26.x status unconfirmed; the one 26.1 NeoForge playlist found is unattributed).
- Reddit developer-sentiment threads (r/fabricmc, r/feedthebeast) could not be fetched (domain blocks the crawler).
- NeoForge's "26.1 → 26.2" and "26.2 → 26.3" migration primers were referenced by Fabric but their URLs/content were not fetched.
