# To-do

New game ideas for this repo (one directory per datapack). Per-pack feature
backlogs live next to the pack, e.g. `one-block_2/IDEAS.md`.

- [ ] **Tile-based game** — IN PROGRESS as `tile-game/` (world `tile-game` in
  the `26.3_mini_games` instance). 2026-10-12 evening, per Dave: **3×3 board of
  3×3×3 tiles (nine total), not 9×9**; editor done (place/remove whole tiles by
  feet or coords, nine tile types, `/trigger grass|remove|tiles|…` short
  commands, adventure mode so tiles only change via commands, checkerboard base
  plate, build/play modes where play drops the plate so holes go to the void).
  Dave's game on top of it, in `tile-game/IDEAS.md`: an **island game** — kids
  build the island from tiles first, then one tile vanishes per turn, last
  player standing wins. Next: decide turn rules (how the vanishing tile is
  picked, turn length, whether tile types matter, build in turns or together)
  and build the sink phase. Dave wants flying considered for build mode.
- [x] **Bedrock-style NPC game** — DONE as building blocks 2026-10-12 evening:
  `npc-game/` (world `npc-game` in `26.3_mini_games`): villager body +
  `interaction` click box + `text_display` name, inline `/dialog show`
  screens with up to three buttons, characters created and edited **in game**
  (`___new`, `___greeting`, `___button`, `___reply`, `___job`, …; see its
  README). Playtested: clicks, buttons, wandering (generated version); the
  in-game-editing rewrite still needs a playtest. Open: a game built on it
  (see RPG below), branching conversations (a button opening a second screen).
- [ ] **RPG-style game** — an RPG inside Minecraft: quests, NPCs with
  dialogue, stats/levels, and loot. Overlaps with the NPC game above for the
  dialogue layer; stats and inventory via scoreboards, storage NBT, and
  `custom_data`-tagged items.
- [ ] **Commands tutorial map ("Command Forge"), fully in-game (no videos)** —
  IN PROGRESS in `commands-tutorial/` (targets 26.3, Prism instance folder
  `Command Forge - 26.3`, world folder `learn_commands`). Section 1 (12 quests,
  incl. the new "Open the Book" quest 1 and the quest-12 cage trip ending in
  TP TO NEXT ISLAND) and **Section 2 (8 command block quests on island 2)**
  built and playtested through 2026-10-12 (see CLAUDE.md for the rules, text
  style, points/leaderboard, growing Little Command Book, reset post, goto
  tools). Open items: a second-player LAN test (per-player islands, the
  leaderboard, and the medal name prefixes are untested with two accounts);
  quests 2–3 pass on trust (chat/keys invisible to datapacks); the "Triggered
  [tut_btn]" line still shows for book links; `tools/__pycache__/` got staged —
  unstage and add `__pycache__/` to `.gitignore`; playtest section 2 start to
  finish on a fresh player; decide whether every kid gets a progress badge in
  chat or only the top three stars. Next: more section 2 (lever/repeat-with-
  redstone, conditional chains), then slicedlime's remaining sections and the
  second half he never filmed (functions early, execute store, data,
  components, macros). Design in `commands-tutorial/PLAN.md`; research in
  `reports/Teaching Minecraft Java commands.md`.
- [ ] **Pack install helper** — `tools/install.sh` (zip + copy into the world,
  optional `--watch` via `inotifywait`) proposed 2026-10-12; Dave chose the
  in-game reload shortcuts instead for now. Build only if the manual zip/copy
  step becomes a bother again.

## Game-type ideas

Kinds of games that work well as vanilla datapacks, grouped by genre. Not
committed to; pull from here into the list above.

- **Parkour / obstacle course** — checkpoints, timer, fall detection, ghost
  runs via stored positions.
- **Maze / dungeon crawl** — tiles stamped from structures, keys and doors,
  fog via darkness effect, map that reveals as you explore.
- **Puzzle rooms** — pressure-plate logic, sokoban with pushable blocks (piston
  or setblock), light-beam/redstone riddles, "escape room" with clue items.
- **Spleef / arena PvP** — floor removal, last player standing, rounds and a
  scoreboard.
- **Hide and seek / prop hunt** — hiders disguised as blocks (block_display
  riding the player), seekers with a radar actionbar.
- **Tower defense** — waves of mobs along a path, towers as dispensers or
  summoned guardians, currency from kills.
- **Wave survival / horde mode** — rounds of mobs, shop between rounds,
  upgrades via attribute modifiers.
- **Boss fight** — custom boss (bossbar, phases on health thresholds, attack
  patterns via scheduled functions).
- **Racing** — boat or elytra race, checkpoints, lap timer, ghost of best run.
- **Capture the flag / king of the hill** — team objectives, zone detection
  with positional selectors, capture timer.
- **Deathrun / trap course** — one player triggers traps, others run.
- **Board game** — tile-based board (dice via /random), snakes-and-ladders or
  Monopoly-lite with scoreboard money.
- **Card / memory game** — item frames or displays flipped by interaction
  entities, match pairs.
- **Tycoon / idle** — resource generators that tick on a timer, buy upgrades,
  prestige resets.
- **Farming / shop sim** — grow, harvest, sell to NPC shop (dialog menus),
  unlock seeds.
- **Stealth / heist** — guards with sight cones (facing checks), alarms,
  loot extraction.
- **Horror / investigation** — scripted scares, sanity meter, clue collection,
  NPC dialogue trees.
- **Tutorial / training map** — lessons with sandboxed verification, like
  Command Training Grounds (see the research report).
- **Rhythm / timing** — hit note blocks on beat, score on precision (tick
  windows).
- **Platformer / 2D side-scroller** — camera-locked movement along one axis
  using teleport constraints, spectator-locked camera.
- **Minigame hub** — lobby that launches any of the above, shared lives and
  leaderboard plumbing from one-block_2.
