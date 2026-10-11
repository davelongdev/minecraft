# To-do

New game ideas for this repo (one directory per datapack). Per-pack feature
backlogs live next to the pack, e.g. `one-block_2/IDEAS.md`.

- [ ] **Tile-based game** — a game built on a grid of 9×9-block tiles (each tile
  a self-contained room/puzzle/arena), e.g. a board you move across tile by
  tile, or a procedurally assembled dungeon. Tiles as structures
  (`place template`) so they can be stamped from a palette.
- [ ] **Bedrock-style NPC game** — a game driven by talking to NPCs the way
  Bedrock's NPC entity works: right-click a character, get a dialogue screen
  with buttons that run commands. Java building blocks: `interaction` entity
  for the click, `text_display` for the name, and the 1.21.6+ `/dialog` system
  (`multi_action` dialogs with `run_command` buttons) for the screen.
- [ ] **RPG-style game** — an RPG inside Minecraft: quests, NPCs with
  dialogue, stats/levels, and loot. Overlaps with the NPC game above for the
  dialogue layer; stats and inventory via scoreboards, storage NBT, and
  `custom_data`-tagged items.
- [ ] **Commands tutorial map for 26.2, fully in-game (no videos)** — our own
  version of slicedlime's Command Training Grounds for the Newburgh Creates
  kids, but every explanation lives in the world: `/dialog` screens for lesson
  text and hints, written books / lecterns for reference, signs and `tellraw`
  for exercise prompts, worked examples as pre-filled command blocks the kid
  can open and read. Keep his 11-section order as the spine, add
  functions/datapacks early and the second half he never filmed, per-player
  progress, sandboxed outcome checks. Design notes in
  `reports/Teaching Minecraft Java commands.md`.

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
