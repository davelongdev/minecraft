# slicedlime's "Learn Minecraft Commands" series and the Command Training Grounds map

Research date: 2026-10-11. Series ran 2022-10-08 to 2023-02-04 and targets Minecraft Java 1.19.x; anything about current (26.x) syntax is outside its scope, and several details it teaches (camelCase game rules such as `commandBlockOutput`/`doDaylightCycle`, NBT-style `summon` arguments) have since changed.

Method note: YouTube pages, the playlist, and caption/transcript endpoints were all blocked or empty via the tools available, so the per-episode detail below comes from the video descriptions and chapter timestamps embedded in each watch page (extracted via curl), the oEmbed API, slicedlime.tv posts, an Invidious comments mirror, minecraft.net credits, and the Minecraft Wiki. No video content was watched and no files were downloaded (only an HTTP HEAD on the zips).

## Who slicedlime is, and why it matters for credibility

### Takeaway
Mikael "slicedlime" Hedberg is a Mojang Studios employee listed in the official Minecraft credits under "Technical Directors", working on Java Edition; every episode description states he is a Mojang Tech Lead but that the channel is a personal spare-time project, and every post carries `#minecraftemployee`.

### Cited Findings
- minecraft.net's official credits page lists "Mikael Hedberg" under the heading "Technical Directors" — [minecraft.net credits](https://www.minecraft.net/en-us/credits)
- Every episode description says: "slicedlime works as a Tech Lead for Minecraft at Mojang, but the YouTube and Twitch channels are personal projects run entirely in his spare time." — [Episode 0 on YouTube](https://www.youtube.com/watch?v=w3MBp-2Oxa4) (same boilerplate in all 12 descriptions)
- Minecraft Wiki: Swedish; "technical director at Mojang Studios since February 1, 2017"; earlier interim tech lead for the Minecraft Launcher team, now tech lead for the Java Edition platform team; on 2019-05-01 "announced he would be working on Minecraft: Java Edition"; described as "a data pack coder" and map maker; his channel's version videos are "not official overviews" — [Minecraft Wiki: Slicedlime](https://minecraft.wiki/w/Slicedlime)
- Wiki trivia: Searge (Mojang) tweeted that slicedlime is "Mojangs favorite YouTuber" — [Minecraft Wiki: Slicedlime](https://minecraft.wiki/w/Slicedlime)
- A 2017 Minecraft Forum reply recommended his channel because the creator is a Mojang (then Pocket Edition) developer who "knows his stuff" and teaches in an easy-to-understand way — [Minecraft Forum: How to learn Command Blocks](https://www.minecraftforum.net/forums/minecraft-java-edition/redstone-discussion-and/commands-command-blocks-and/2823139-how-to-learn-command-blocks)
- Every slicedlime.tv post about the series and the map ends with the hashtag `#minecraftemployee` (a disclosure tag) — [Episode 0 post](https://www.slicedlime.tv/2022/10/08/learn-minecraft-commands-series-introduction-episode-0/)
- Top comment on Episode 1 (103 likes): "A Minecraft developer teaching about commands? Genius" — [Episode 1 comments via Invidious](https://invidious.f5.si/api/v1/comments/iurIhHVK-hk)
- Channel links in descriptions: Discord https://discord.gg/aFAnsdv, Twitch, Patreon, second channel "limeuncut"; his website is slicedlime.tv (slicedlime.com is a parked GoDaddy domain, not his) — [Episode 0 description](https://www.youtube.com/watch?v=w3MBp-2Oxa4); [slicedlime.com redirect observed](https://slicedlime.com/)

### Inferences
- The wiki's "technical director since 2017" and his own "Tech Lead" wording describe the same person at different levels of formality; the official credits settle the formal title as Technical Director.
- Material from someone who works on the command system itself is as authoritative as unofficial tutorials get, but he explicitly frames it as personal, not Mojang-endorsed.

### Gaps
- No interview or primary statement describing his exact day-to-day role on commands/data packs was found.

## Full episode list, in order, with topics

### Takeaway
The playlist holds 12 videos (Episode 0 through Episode 11), released weekly on Saturdays from 2022-10-08 to 2023-02-04 (with gaps around December), totalling about 1 h 50 min; there has been no Episode 12, and the playlist was last updated 2023-02-04.

### Cited Findings
Playlist: 12 videos, 341,875 views, "Last updated on Feb 4, 2023" — [YouTube playlist](https://www.youtube.com/playlist?list=PL4ZS2guXqa_jVrj73ZBl4zkkz_BdEVEb5). Titles via [YouTube oEmbed](https://www.youtube.com/oembed?url=https://www.youtube.com/watch?v=w3MBp-2Oxa4&format=json) and watch-page metadata; dates/lengths/view counts from the watch pages (views as of 2026-10-11).

| # | Title | Video | Published | Length | Views | Description summary |
|---|---|---|---|---|---|---|
| 0 | Learn Minecraft Commands - Series Introduction (Episode 0) | https://www.youtube.com/watch?v=w3MBp-2Oxa4 | 2022-10-08 | 2:04 | 144k | "We'll go from beginner to expert, one step at a time. This video introduces the series and its companion map." |
| 1 | Learn Commands Tutorial - Command Basics (Episode 1) | https://www.youtube.com/watch?v=iurIhHVK-hk | 2022-10-08 | 7:32 | 127k | "command basics and the say, help and give commands as well as an introduction to command blocks" |
| 2 | Learn Minecraft Commands - Repeating Commands (Episode 2) | https://www.youtube.com/watch?v=Byf0nHnIBhM | 2022-10-15 | 6:36 | 56k | "repeating command blocks, ticks, game rules, absolute coordinates, the debug screen and the setblock and gamerule commands" |
| 3 | Learn Minecraft Commands - Command Chains (Episode 3) | https://www.youtube.com/watch?v=xEXRGRnvrRI | 2022-10-22 | 5:41 | 41k | "chain command blocks and the teleport (tp) and gamemode commands" |
| 4 | Learn Minecraft Commands - Relative Coordinates (Episode 4) | https://www.youtube.com/watch?v=DmsjJFwaPDw | 2022-10-29 | 9:01 | 33k | "relative coordinates, conditional command blocks, and an intro to summoning entities with the summon command" |
| 5 | Learn Minecraft Commands - Block States (Episode 5) | https://www.youtube.com/watch?v=hl9WLdYOYzc | 2022-11-05 | 7:05 | 30k | "setblock modes, block states and an intro to block entity data" |
| 6 | Learn Minecraft Commands - Changing the World with /fill, /clone and More (Episode 6) | https://www.youtube.com/watch?v=U4WlKem4FwM | 2022-11-12 | 11:37 | 23k | "the fill, clone, time and weather commands, as well as the doDaylightCycle and doWeatherCycle game rules" |
| 7 | Learn Minecraft Commands - Selecting Entities and the /kill Command (Episode 7) | https://www.youtube.com/watch?v=SjG4DmDlL2k | 2022-11-19 | 10:23 | 27k | "the kill command, the @a, @p and @r player selectors, the @e entity selector, as well as the distance, type, limit and sort selector arguments" |
| 8 | Learn Minecraft Commands - Summoning and Tagging Entities with Entity Data (Episode 8) | https://www.youtube.com/watch?v=y9I3X8R_HEw | 2022-11-26 | 14:23 | 51k | "the tag command and more advanced uses of the summon command, the tag selector argument and the NoAI and Tags entity data fields" |
| 9 | Learn Commands Tutorial - Execute (Episode 9) | https://www.youtube.com/watch?v=Jnn8Um9tjbM | 2022-12-31 | 9:03 | 18k | "the execute command basics and the execute as and execute at subcommands as well as the at-s selector" |
| 10 | Learn Minecraft Commands Tutorial - Scoreboards (Episode 10) | https://www.youtube.com/watch?v=GwRfluFO3Tk | 2023-01-14 | 9:29 | 89k | "the scoreboard command basics and scores selector argument" |
| 11 | Learn Minecraft Commands Tutorial - Execute Conditionals (Episode 11) | https://www.youtube.com/watch?v=mEUpxev-1Eg | 2023-02-04 | 12:39 | 24k | "the execute if and execute unless sub-commands and execute if block, execute if blocks, execute if entity and execute if score" |

- Companion blog posts exist for each episode on slicedlime.tv, e.g. [Ep 0](https://www.slicedlime.tv/2022/10/08/learn-minecraft-commands-series-introduction-episode-0/), [Ep 1](https://www.slicedlime.tv/2022/10/08/learn-minecraft-commands-command-basics-episode-1/), [Ep 3](https://www.slicedlime.tv/2022/10/22/learn-minecraft-commands-command-chains-episode-3/), [Ep 4](https://www.slicedlime.tv/2022/10/29/learn-minecraft-commands-relative-coordinates-episode-4/), [Ep 5](https://www.slicedlime.tv/2022/11/05/learn-minecraft-commands-block-states-episode-5/), [Ep 6](https://www.slicedlime.tv/2022/11/12/learn-minecraft-commands-changing-the-world-with-fill-clone-and-more-episode-6/), [Ep 8](https://www.slicedlime.tv/2022/11/26/learn-minecraft-commands-summoning-and-tagging-entities-with-entity-data-episode-8/), [Ep 9](https://www.slicedlime.tv/2022/12/31/learn-commands-tutorial-execute-episode-9/), [Ep 10](https://www.slicedlime.tv/2023/01/14/learn-commands-tutorial-scoreboards-episode-10/), [Ep 11](https://www.slicedlime.tv/2023/02/04/learn-minecraft-commands-tutorial-execute-conditionals-episode-11/); site search index: [slicedlime.tv search](https://www.slicedlime.tv/?s=Learn+Minecraft+Commands)
- The series was announced on 2022-10-07: "The new tutorial series starts tomorrow! More info in the image and link" (297 likes) — [@slicedlime tweet](https://twitter.com/slicedlime/status/1578498852209848320)
- A viewer on Episode 9 asked "could you please continue the series?", consistent with the series stopping at Episode 11 — [Episode 9 comments](https://invidious.f5.si/api/v1/comments/Jnn8Um9tjbM)

### Inferences
- All uploads are at 07:15 Pacific on Saturdays, so the format is a weekly short lesson (5 to 14 minutes); a viewer comment "can't wait for next Saturday" confirms the audience perceived a weekly cadence — [Episode 1 comments](https://invidious.f5.si/api/v1/comments/iurIhHVK-hk)
- Title wording is inconsistent ("Learn Minecraft Commands", "Learn Commands Tutorial", "Learn Minecraft Commands Tutorial"), which looks like SEO experimentation; it does not indicate separate series.
- The promised "to expert" arc was never finished: nothing after `execute if score` (no `execute store`, `data`, functions, data packs, predicates, or `/item`, `/attribute`, etc.).

### Gaps
- No official statement from slicedlime on why the series stopped or whether it will resume was found.

## Progression of concepts (sequence and how episodes build)

### Takeaway
The sequence is: chat commands and command blocks (say/help/give) → command block modes (impulse, repeat, chain) with setblock/gamerule/tp/gamemode as the vehicles → coordinates (absolute, then relative) and conditional blocks → the block side of the world (block states, block entities, fill/clone/time/weather) → the entity side (selectors, kill, tag, summon with NBT) → execute as/at and @s → scoreboards → execute if/unless. Selectors are deliberately deferred to Episode 7, NBT to Episode 8, execute to Episode 9, and data packs/functions never arrive.

### Cited Findings
Chapter timestamps from each video description (all at the watch URLs in the table above):
- Ep 0 chapters: Introduction 0:00, Prior Knowledge Required 0:19, Beginner Commands 0:32, Minecraft Versions 0:40, Companion Map 0:53, Upgrading the map 1:23, Outro 1:56 — [Ep 0](https://www.youtube.com/watch?v=w3MBp-2Oxa4)
- Ep 1 chapters: Minecraft Version 0:15; Running a command 0:32; The say command 1:04; The help command 1:16; Terminology 1:44; Accessing commands 2:14; The give command 2:53; Command and chat history 3:39; Using the give command with a count 4:04; Namespaced ids and the minecraft namespace 4:23; Command blocks 4:52; Activating command blocks 5:35; Activation modes 6:19; Using the give command from command blocks 6:58 — [Ep 1](https://www.youtube.com/watch?v=iurIhHVK-hk)
- Ep 2 chapters: Command block modes; Repeat command blocks; Game ticks and interpolation; The power and danger of repeating commands; The setblock command; Using the debug screen for coordinates; Auto-completing coordinates; Using setblock in a repeating command block; Game rules; The commandBlockOutput game rule; The gamerule command — [Ep 2](https://www.youtube.com/watch?v=Byf0nHnIBhM)
- Ep 3 chapters: Chain command blocks; Command block chains; A more complex example; The teleport command; The gamemode command; Game modes; Using the gamemode command from command blocks; The game mode switcher — [Ep 3](https://www.youtube.com/watch?v=xEXRGRnvrRI)
- Ep 4 chapters: Referencing Locations; Relative Coordinates; Frames of Reference; Directions in the World; Mixed Coordinates; The summon command; Entity types; Conditional Command Blocks; Multiple conditions in chains — [Ep 4](https://www.youtube.com/watch?v=DmsjJFwaPDw)
- Ep 5 chapters: Setblock modes; Block States; Multiple Block Properties; Viewing Block States; The Debug Stick; An Introduction to Block Entities; Copying a Block with State and Entity; Some Closing Words on Block Entity Data — [Ep 5](https://www.youtube.com/watch?v=hl9WLdYOYzc)
- Ep 6 chapters: The fill command; Fill modes; Outline example; Hollow example and using fill with tab completion; Replace filters; The clone command; Clone modes; The time command; The doDaylightCycle game rule; The weather command; The doWeatherCycle game rule — [Ep 6](https://www.youtube.com/watch?v=U4WlKem4FwM)
- Ep 7 chapters: Blocks vs Entities; What is an Entity?; The kill command; Optional entity arguments; Referencing entities; Entity UUIDs; Entity Selectors; Player Selectors; @a, @p, @r; Selecting 0 targets; @e; Selector Arguments; distance; Ranges; type; Multiple selector arguments; Inverted matches; limit; sort; Putting it all together — [Ep 7](https://www.youtube.com/watch?v=SjG4DmDlL2k)
- Ep 8 chapters: Tags; The tag command; Tag names; The tag selector argument; Multiple tags; Inverted tag selections; Summon command recap; The nbt summon argument; Entity data intro; The NoAI data field; Reading entity data formats on the wiki; Multiple different "tag" concepts; Reading a field specification; Integer NBT fields; Copying entity data; Tagging summoned entities; The Tags NBT field; List and String NBT fields; Using the Tags field in a summon; Closing words about entity data; The doMobSpawning game rule — [Ep 8](https://www.youtube.com/watch?v=y9I3X8R_HEw)
- Ep 9 chapters: Why do we need execute?; execute overview; execute at; Who runs a command matters; execute as; Keeping things separate; Combining multiple modifiers; The s selector; Combining as and at; Position changes and selectors; Practice 8:40 — [Ep 9](https://www.youtube.com/watch?v=Jnn8Um9tjbM)
- Ep 10 chapters: Scoreboard basics; The scoreboard objectives sub-command; Creating scoreboards; Displaying scoreboards; Setting scores; Setting scores for entities; Fake Players; Adding and subtracting from scores; Removing scores; Adding to non-existant scores; Scoreboard limits; Listing scoreboards; Removing scoreboards; Selecting entities by score; Selecting by multiple scores simultaneously; Removing a scoreboard display — [Ep 10](https://www.youtube.com/watch?v=GwRfluFO3Tk)
- Ep 11 chapters: Conditionals - execute if and execute unless; execute if block; Combining execute sub-commands; matching block states; chaining multiple conditionals; "Complexity made of understandable pieces" 4:02; execute if blocks; scan modes; execute if blocks with block states; execute if entity; execute if entity vs execute as; execute if without run; counting entities by score; entity selectors vs fake players; execute if score; Comparing scores — [Ep 11](https://www.youtube.com/watch?v=mEUpxev-1Eg)
- In 2015 his earlier "Beginner Command Block Tutorial" followed a similar order: Part 6 /summon, Part 7 /execute ("one of the most important commands to master"), Part 8 intro to /scoreboard ("one of the keys to using command blocks to their full potential"), Part 9 Clocks, Part 10 Scoreboard Selectors, Part 11 Scoreboard Criteria Types, Part 12 Introduction to Data Tags ("the final major complexity of command blocks"), Part 13 Setting Data Tags & the Chunk Format page — [slicedlime.tv tag: Beginner Commands](https://www.slicedlime.tv/tag/beginner-commands/)

### Inferences
- Vehicles vs concepts: each new concept is introduced through one or two concrete commands chosen for being visible and low-risk (`say`, `give`, `setblock`, `tp`, `gamemode`, `fill`), so the concept (modes, ticks, coordinates, states) is the lesson and the command is the example.
- Explicit "mental model" chapters appear in each episode: "Terminology", "Namespaced ids", "Game ticks and interpolation", "Frames of Reference", "Blocks vs Entities / What is an Entity?", "Who runs a command matters", "Multiple different 'tag' concepts", "entity selectors vs fake players", "Complexity made of understandable pieces". Chapter titles show he names misconceptions explicitly rather than only demonstrating syntax.
- He teaches reading the reference, not memorising it: Ep 8 has "Reading entity data formats on the wiki" and "Reading a field specification"; Ep 1 has "The help command"; Ep 6 "using fill with tab completion"; Ep 2 "Auto-completing coordinates". The 2015 series likewise had "the Chunk Format page".
- Safety/caution is taught alongside power: "The power and danger of repeating commands", "Selecting 0 targets", "Scoreboard limits", "Closing words about entity data".
- Each world-side concept gets both an "intro" and a later "continued" slot (summon in Ep 4 then Ep 8; conditionals in Ep 4 as conditional blocks then Ep 11 as execute if), a spiral rather than linear curriculum.
- Command blocks are the primary execution environment throughout (modes, chains, conditional blocks). Functions and data packs, which are how most modern command work is done, are not reached. Someone modelling a modern course would need to decide where to introduce `.mcfunction` files and `/reload`.

### Gaps
- Without transcripts, the exact wording of his "Prior Knowledge Required" and "Beginner Commands" sections in Episode 0 (what he assumes, and what he considers beginner vs expert) could not be captured. Only chapter titles are available.
- Not verified which Minecraft version Ep 0/Ep 1 name on screen ("Minecraft Version(s)" chapters). Given the 2022-10-08 release, the current release was 1.19.2; 1.19.3 was released 2022-12-07, so the brief's "1.19.3 world" probably reflects a later map build (see below).

## How the Command Training Grounds map works as a learning tool

### Takeaway
The map is explicitly a companion to the videos, built live on Twitch between 2022-09 and 2023-02, distributed as a full world zip plus a separate "Upgrade" package that lets players who have already started keep their progress when new episodes add content; no public text source describes its rooms, stations, or validation logic, and the map's internals (the `ctg.zip` datapack, `resources.zip`) are not documented anywhere I could find.

### Cited Findings
- "The Command Training Grounds map is a companion map for my Learn Minecraft Commands tutorial series." The page offers "Full map download" and "Upgrade package" and says for upgrading a map you've already started playing, see the Series Introduction video at 0:54 — [slicedlime.tv/command-training-grounds](https://www.slicedlime.tv/command-training-grounds/)
- Download URLs: full map https://www.slicedlime.tv/dl/ctg/CommandTrainingGrounds.zip and upgrade https://www.slicedlime.tv/dl/ctg/Upgrade.zip — [Episode 1 description](https://www.youtube.com/watch?v=iurIhHVK-hk)
- Episode 0's description lists only the full download; from Episode 1 on, every description lists both "Full download" and "Upgrade" — [Ep 0](https://www.youtube.com/watch?v=w3MBp-2Oxa4) vs [Ep 1](https://www.youtube.com/watch?v=iurIhHVK-hk)
- Episode 0 chapters: "Companion Map 0:53" and "Upgrading the map 1:23" — [Ep 0](https://www.youtube.com/watch?v=w3MBp-2Oxa4)
- HTTP HEAD (2026-10-11): CommandTrainingGrounds.zip is 41,361,564 bytes and Upgrade.zip 2,359,739 bytes; both Last-Modified "Sat, 04 May 2024 14:15:03 GMT" — [CommandTrainingGrounds.zip](https://www.slicedlime.tv/dl/ctg/CommandTrainingGrounds.zip), [Upgrade.zip](https://www.slicedlime.tv/dl/ctg/Upgrade.zip)
- Map development streams: "I worked on Command Training Grounds for the first time on stream" (stream 2022-09-11, post 2022-09-18); further "Making the Command Training Grounds" stream archives dated 2022-09-25, 2022-10-17, 2022-10-25, 2022-12-27, 2022-12-30, 2023-01-19, and 2023-02-04 ("I continued working on the Command Training Grounds and then had a tour of old command contraptions"); the recurring description is "a map to teach commands together with a new tutorial series" — [slicedlime.tv search: Command Training Grounds](https://www.slicedlime.tv/?s=Command+Training+Grounds); [first stream post](https://www.slicedlime.tv/2022/09/18/stream-archive-making-the-command-training-grounds/); [last stream post](https://www.slicedlime.tv/2023/02/04/stream-archive-making-the-command-training-grounds-minigame-tour/)
- Episode 9 ends with a chapter titled "Practice: 8:40" — [Ep 9](https://www.youtube.com/watch?v=Jnn8Um9tjbM)
- Viewer on Episode 0: "This upgrade mechanism is amazing. It makes a bunch of limitations and challenges for you, but it couldn't be simpler for the user!" — [Ep 0 comments](https://invidious.f5.si/api/v1/comments/w3MBp-2Oxa4)
- Viewer on Episode 1: "Just binged this whole series last night and now downloading the practice world." Another: "I'll likely be downloading new maps each time for the repetition" — [Ep 1 comments](https://invidious.f5.si/api/v1/comments/iurIhHVK-hk)
- Viewer on Episode 10: "Hoping to use this series as an aid to help introduce students to creative coding." — [Ep 9 comments](https://invidious.f5.si/api/v1/comments/Jnn8Um9tjbM)
- The map page is dated 2022-10-05, three days before Episode 0 — [slicedlime.tv search page 2](https://www.slicedlime.tv/page/2/?s=Learn+Minecraft+Commands)

### Inferences
- The map grew with the series (stream work continued through 2023-02-04, the day Episode 11 released), so the "Upgrade" package is how later episodes' content reached existing worlds; the viewer comment about the upgrade imposing "limitations and challenges for you" (the author) suggests the upgrade is applied inside an existing save, likely by dropping in a datapack/resource pack rather than replacing the world. Treat as inference: the mechanism is not described in any text source found.
- A 2024-05-04 modification date on both zips indicates at least one update roughly 15 months after the last episode, plausibly to a newer game version; this would explain why the brief describes the download as a 1.19.3 world even though the series launched on 1.19.2. The currently served file may differ from the one the brief describes.
- Whether the map "checks the player's work" and how feedback is given could not be established from any public text. The chapter "Practice" in Episode 9 and viewers calling it the "practice world" suggest exercise areas tied to episodes, but no description of stations, validation commands, or feedback was published.

### Gaps
- No written documentation of the map's layout, rooms/stations, exercise list, validation logic, or feedback exists on slicedlime.tv, the video descriptions, or indexed forums. Inspecting the `ctg.zip` datapack is the only way to learn this, and downloading was out of scope.
- Minecraft version required is not stated on the map page or in the descriptions; only the 2024-05-04 Last-Modified header hints at an update. No report of it working or failing on 1.20/1.21/26.x was found.
- No Reddit, Planet Minecraft, or Minecraft Forum thread about the map was found (Reddit's search API refused unauthenticated requests; web search returned nothing).

## Community reception: strengths and gaps

### Takeaway
Viewer comments praise clarity, short length, pacing, careful terminology, and the credibility of a Mojang developer teaching; the recorded criticisms are terminological looseness ("scoreboard" vs "objective"), one case of distracting music, viewers who already know the basics finding early episodes slow, and the series never reaching advanced topics.

### Cited Findings
Strengths:
- "Please keep making these bite sized tutorials. They're really easy to follow and short enough to keep my attention span." (57 likes) — [Ep 1 comments](https://invidious.f5.si/api/v1/comments/iurIhHVK-hk)
- "Wow, best beginners tutorial by far. Very basic and not overwhelming." (20 likes); "Really good tutorial for complete beginners. Hope this tutorial will cover some advanced stuff like nbt data." (83 likes) — [Ep 1 comments](https://invidious.f5.si/api/v1/comments/iurIhHVK-hk)
- "I've read the Minecraft Wiki so many times trying to understand this stuff, but there's nothing like having a clear simple demonstration." — [Ep 1 comments](https://invidious.f5.si/api/v1/comments/iurIhHVK-hk)
- "Your clarity pacing is great" (24 likes); "I've always felt a bit uncertain on how execution context works, but after watching this video I'm a lot more confident. Just needed a guiding hand on the syntax with some clear examples." — [Ep 9 comments](https://invidious.f5.si/api/v1/comments/Jnn8Um9tjbM)
- "I've been stuck thinking in 1.8 commands for far too long, and now that I'm learning programming this series worked extra well for me since a lot of skills can transfer over" — [Ep 0 comments](https://invidious.f5.si/api/v1/comments/w3MBp-2Oxa4)
- "Your old series is what got me into commands" (83 likes, top comment on Ep 0) — [Ep 0 comments](https://invidious.f5.si/api/v1/comments/w3MBp-2Oxa4)
- 2017 forum recommendation of his earlier beginner/advanced series as easy to understand — [Minecraft Forum](https://www.minecraftforum.net/forums/minecraft-java-edition/redstone-discussion-and/commands-command-blocks-and/2823139-how-to-learn-command-blocks)

Gaps/criticism:
- "It would be nice to keep the language consistent, i.e. call a scoreboard objective an 'objective' and not a 'scoreboard', since the scoreboard itself actually encompasses all objectives... Something else that might have been nice to clarify is that selecting by score does not actually search through all entities on the objective, but instead searches through all loaded entities and tests for their scores... many beginners try to target fake players through selectors, which ends up not working" (9 likes) — [Ep 10 comments](https://invidious.f5.si/api/v1/comments/GwRfluFO3Tk)
- A viewer clarified why a fake player did not appear in an `@e` selection at 7:58 of Episode 10 (56 likes), indicating a point the episode left implicit — [Ep 10 comments](https://invidious.f5.si/api/v1/comments/GwRfluFO3Tk)
- "the music became a bit distracting at around mid video!" — [Ep 9 comments](https://invidious.f5.si/api/v1/comments/Jnn8Um9tjbM)
- "Finally getting to the more advanced topics, can't wait for the next episodes" (28 likes, Ep 10); "Looking forward to the more advanced tutorials since this is all basic stuff I already know" — [Ep 10 comments](https://invidious.f5.si/api/v1/comments/GwRfluFO3Tk)
- "This one made my brain hurt" (Ep 9, execute) — [Ep 9 comments](https://invidious.f5.si/api/v1/comments/Jnn8Um9tjbM)
- "could you please continue the series?" — [Ep 9 comments](https://invidious.f5.si/api/v1/comments/Jnn8Um9tjbM)

### Inferences
- View counts fall steadily from 127k (Ep 1) to about 18k (Ep 9), with a rebound to 89k for Scoreboards (Ep 10), which suggests the scoreboard episode is found by search independently of the series; the steep drop-off is typical of a sequential course and also marks where difficulty jumps (execute).
- The audience reported was mixed: complete beginners, lapsed 1.8–1.12 command users returning, Bedrock players switching to Java, and teachers wanting a classroom aid.

### Gaps
- No Reddit or forum discussion of this specific series or map was found, so community-wide assessment rests on YouTube comments retrieved via one Invidious mirror (which returns a subset ordered by its own default).

## Other command-teaching material by slicedlime (or Mojang)

### Takeaway
slicedlime has a long back-catalogue of command teaching: a 13-part "Beginner Command Block Tutorial" (2015), an "Advanced Commands Tutorial" series (2015–2018) covering 1.9 if/then/else, 1.12 chains and functions, and the 1.13 command rewrite, and an ongoing stream of per-snapshot technical-change videos and "News in Data Pack Version X" posts that continue through the 26.4 snapshots in 2026; no Minecraft Live / MINECON data pack talk by him was found.

### Cited Findings
- 2015 Beginner Command Block Tutorial parts 6–13: /summon (2015-04-21), /execute (2015-04-30), Intro to /scoreboard (2015-05-09), Clocks (2015-05-14), Scoreboard Selectors (2015-05-27), Scoreboard Criteria Types (2015-06-03), Introduction to Data Tags (2015-06-11), Setting Data Tags & the Chunk Format page (2015-07-08) — [Beginner Commands tag](https://www.slicedlime.tv/tag/beginner-commands/) (parts 1–5 are not on the indexed archive page; page 2 returns 404)
- Advanced Commands Tutorial posts include: "If/Then/Else and Loop Control in Minecraft 1.9" (2015-08-24), "Command and Map Making Changes in Minecraft 1.11" (2016-11-19), "For/While Loops with Minecraft 1.12 Chains" (2017-04-22), "Hidden Minecraft 17w16b Feature: @s Command Selector" (2017-04-25), "Functions & Recursion using Advancement Rewards" (2017-04-28), "Upgrading Maps and Commands to Minecraft 1.12" (2017-06-10), "Functions in Minecraft 1.12" (2017-06-16), "Minecraft Bedrock Edition 1.2 Command Changes" (2017-09-28), "Command News in Minecraft 1.13" (2018-07-27), "Minecraft Snapshot 18w43a and 18w43b Map Making, Data Pack and Command News" (2018-10-25), "All the Technical Changes in Minecraft Java Edition 1.14" (2019-04-29) and 1.15 (2020-01-25) — [Advanced Commands tag](https://www.slicedlime.tv/tag/advanced-commands/) (page 1 of 3)
- Ongoing technical posts as of October 2026: "News in Data Pack Version 123.0 and Resource Pack Version 100.0 (26.4 Snapshot 3)" (2026-10-11), "...122.1 and 99.0 (26.4 Snapshot 2)" (2026-10-04), "...122.0 and 98.0 (26.4 Snapshot 1)" (2026-09-27), alongside "What's New in Minecraft 26.4 Snapshot N?" videos — [slicedlime.tv recent posts](https://www.slicedlime.tv/page/2/?s=Learn+Minecraft+Commands)
- Minecraft Wiki: the wiki embeds his version-showcase videos in articles; they are "not official overviews" — [Minecraft Wiki: Slicedlime](https://minecraft.wiki/w/Slicedlime)
- A 2017 forum post says his channel had "beginner and advanced command block tutorial series" — [Minecraft Forum](https://www.minecraftforum.net/forums/minecraft-java-edition/redstone-discussion-and/commands-command-blocks-and/2823139-how-to-learn-command-blocks)
- Searches for a slicedlime data pack talk at Minecraft Live or MINECON returned only unrelated community panel pages — [minecraft.net community panels article](https://minecraft.net/en-us/article/community-panels-minecon-live)

### Inferences
- His per-snapshot "News in Data Pack Version" posts are the natural companion for keeping any 1.19-era lesson current: they are the most granular public changelog of command/data pack syntax changes, written by someone on the team.
- The 2015 and 2022 series share the same backbone (basics → clocks/repeat → summon → execute → scoreboard → NBT), so the ordering reflects a settled view of the dependency graph rather than a one-off choice.

### Gaps
- No Mojang-published command curriculum and no slicedlime conference talk were found; the Microsoft Learn commands introduction is Bedrock-only and unrelated.
- Parts 1–5 of the 2015 series could not be listed (archive page 2 returns 404).
