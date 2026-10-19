# To-do

New game ideas for this repo (one directory per datapack). Per-pack feature
backlogs live next to the pack, e.g. `one-block_2/IDEAS.md`.

- [ ] **"minecraft_gameforge" — combine the packs into one game** (Dave's
  idea, 2026-10-17, while playtesting NPC Forge): Command Forge, NPC Forge,
  the tile game, and the rest become one pack / one world, with the "Forge"
  naming throughout. Nothing decided yet: one namespace or several, one hub
  world with islands per game or separate worlds, how progress and the
  leaderboard carry across, and which pack's conventions win (trigger words,
  books, buttons). First step is a short design note before touching code.
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
  README). 2026-10-16: kid-facing dialog forms replace the SNBT commands
  (`/trigger create_npc`, sneak + right-click to edit; two screens per button:
  Dialogue / Run command / No button, then label + text), `/trigger clear_all_npcs` (was `clear_npcs`), `/trigger clear_one_npc` (pick
  from a list, 2026-10-17), and `/trigger refresh_starter_npcs`, island grown to 50×50. Playtested 2026-10-16:
  character form and the one-screen button form worked; still to playtest: the
  two-step button screens, clear/starter triggers, the island grow on reload.
  2026-10-17: Dave calls it **NPC Forge** now; all 16 `___` hand commands
  moved out of the pack into `npc-game/retired/` (table in its README) — add
  them back **one at a time** as he asks (suggested first: `___respawn`, then
  `___list`); two instruction books from `tools/gen_book.py` (NPC Forge Book
  with his welcome text, the triggers, and command basics; the original Little
  NPC Book kept as a second book for now), given on first join and by
  `/trigger give_new_books` — not yet playtested (check the book pages fit, that
  both books arrive, and the log for load errors).
  Done 2026-10-17 while playtesting: a leading `/` in the command box is
  forgiven (stripped on save and on press), the "Running function …" chat
  lines are gone (`send_command_feedback false` in `load`; the kids' own
  success replies go with them, errors still show). The `npc_choice` trigger
  was removed and put back the same day: a dialog button running `/function`
  pops a "Confirm Command Execution" screen (op-level command), `/trigger`
  doesn't. Open: **the same confirmation screen appears on every form
  submit** (create/edit/buttons/delete), because text can only reach the pack
  through an op-level command. Checked in the 26.3 client 2026-10-18: no
  option or flag skips it; only non-op commands (`/trigger` + a number) run
  silently. Options: (a) accept one click per screen; (b) number-only forms
  (dropdowns/sliders with digit ids) via `trigger`, text elsewhere; (c) text
  via a book-and-quill, sign, or anvil-renamed item the pack reads from NBT;
  (d) class server with a tiny server-side Fabric mod handling `dynamic/custom`
  dialog actions — vanilla clients, no confirmation (fits the "one tiny mod
  as instructor plumbing" line in the modding report). Decide before gameforge; `/trigger clear_one_npc` and the two books are
  not yet playtested; a game built on it (see RPG below); branching
  conversations (a button opening a second screen).
  2026-10-18: ownership (each player's own NPCs; starters shared), every-tick
  self-heal with a 2 s grace + duplicate cleanup (returning to the island used
  to double the cast), `npc_choice` enabled only while a screen is open (out
  of `/trigger` Tab), `give_new_books`, Island Builder achievement (3 NPCs →
  Island Button → signed post → own 21×21 island at 1024·pid, back button,
  fall catch), `/trigger choose_name` (sign name; not the chat name),
  `___reset_server` / `___reset_player` teacher functions, Little NPC Book
  pages 1–4 reworded by Dave. Still to playtest: a second account visiting an
  island and being refused edits; `clear_one_npc`; the choose_name form's one
  line of white text (keep or cut); whether "Player N" default signs are OK.
- [ ] **RPG-style game** — an RPG inside Minecraft: quests, NPCs with
  dialogue, stats/levels, and loot. Overlaps with the NPC game above for the
  dialogue layer; stats and inventory via scoreboards, storage NBT, and
  `custom_data`-tagged items.
- [ ] **Commands tutorial map ("Command Forge"), fully in-game (no videos)** —
  IN PROGRESS in `commands-tutorial/` (targets 26.3, Prism instance folder
  `Command Forge - 26.3`, world folder `learn_commands`). Section 1 (12 quests,
  order since 2026-10-16: t and Esc, Say Hello, Open the Book — the book is
  first given after quest 2 — then on to the quest-12 cage trip ending in
  TP TO NEXT ISLAND) and **Section 2 (8 command block quests on island 2)**
  built and playtested through 2026-10-12 (see CLAUDE.md for the rules, text
  style, points/leaderboard, growing Little Command Book, reset post, goto
  tools). Open items: a second-player LAN test (per-player islands, the
  leaderboard, and the medal name prefixes are untested with two accounts);
  quests 2–3 pass on trust (chat/keys invisible to datapacks); the "Triggered
  [tut_btn]" line still shows for book links; `tools/__pycache__/` got staged —
  unstage and add `__pycache__/` to `.gitignore`; playtest section 2 start to
  finish on a fresh player; decide whether every kid gets a progress badge in
  chat or only the top three stars; the book's "Stuck? [Start this exercise
  over]" page was removed 2026-10-18 (Dave) — maybe add it back once a
  particular quest has taught enough that a restart link makes sense (the
  `trigger tut_btn set 3` → `___start` path still exists). Next: more section 2 (lever/repeat-with-
  redstone, conditional chains), then slicedlime's remaining sections and the
  second half he never filmed (functions early, execute store, data,
  components, macros). Design in `commands-tutorial/PLAN.md`; research in
  `reports/Teaching Minecraft Java commands.md`.
- [ ] **Pack install helper** — `tools/install.sh` (zip + copy into the world,
  optional `--watch` via `inotifywait`) proposed 2026-10-12; Dave chose the
  in-game reload shortcuts instead. Those space / shift+space shortcuts were
  removed 2026-10-16 (dev mode was left on and every space press reloaded and
  reset the quest, blocking creative flight); `___rr` / `___rq` remain by name.
  Build the helper if the manual zip/copy step becomes a bother again.

## Studio server (2026-10-18)

Hosting research (`reports/Minecraft server hosting options.md`) picked exaroton,
then Dave offered his home Arch box (i5-13400, 62 GB; details in CLAUDE.md
"Studio server"). It's updated and reachable over SSH from the home LAN.

- [ ] **Decide Docker vs plain** (itzg containers with pinned Java vs
  `jdk25-openjdk` + one systemd unit per game). Dave asked "why docker?" and
  the trade-offs are laid out; nothing installed yet.
- [ ] **First server:** Docker or JDK install, `/srv/minecraft/npc-game/`
  with the `npc-game` world copied from Prism and `zips/npc-game.zip` in its
  `datapacks/`, online mode + whitelist (`lazerbrain6562` op), port 25565,
  nftables (SSH + game ports), LAN join test from the laptop. Then one folder
  per game (Command Forge, tile game, one-block…) on 25566+.
- [ ] **Move the box to the studio** with an Ethernet cable; fixed LAN address
  there; auto-restart of the game servers at boot (LUKS passphrase still typed
  by hand — fine while nobody plays unattended; TPM unlock or a reinstall
  without LUKS if that changes).
- [ ] **PXE + Clonezilla imaging** for the studio laptops on the same box:
  dnsmasq proxy-DHCP + TFTP, iPXE menu, Clonezilla Live over HTTP/NFS, images
  on `/home`; Clonezilla SE for multicast class-set restores; needs a switch
  and wired laptops, UEFI boot files, Secure Boot off.
- [ ] **Housekeeping on the box:** merge/delete the `.pacnew` files (keep the
  live `mkinitcpio.conf`), decide whether `%wheel NOPASSWD` stays, add the
  `studio` SSH alias on the laptop (Dave to approve), weekly update + reboot
  habit when he's on site.
- [ ] **Server-side Fabric mod** (the "instructor plumbing" from the modding
  report), now with a server to run it on: dialog `dynamic/custom` → mixin
  on `handleCustomClickAction` → write to command storage / run functions, so
  the NPC Forge forms submit with no confirmation screen; chosen display name
  in chat/tab/name tag (Dave expected `choose_name` to change his chat name —
  vanilla can't); a chat listener so Command Forge's "Say Hello" quest is
  checked for real (the server sees chat; "t and Esc" never leaves the
  client, so it stays on trust or merges into Say Hello) — Dave 2026-10-18;
  later per-player entity hiding. Prereqs in the Java section
  below (JDK 25, Fabric template).

## Java modding environment — follow-ups (2026-10-13)

Report: `reports/Minecraft and Hytale Java mod setup.md`; reader doc `~/java/java-notes.md` (moved from this folder 2026-10-16; reachable as `java/java-notes.md` via the symlink).

- [x] **Link the Java learning folders:** done 2026-10-16. `java-notes.md` moved to `~/java` (own git repo, private github.com/davelongdev/java); `java/` here is a relative symlink to it (uncommitted; `git status` shows `D java-notes.md` + `?? java`). Open: move the two general research notes there too? Details in `~/robotics/TODO.md` (FTC section).
- [ ] IntelliJ IDEA 2026.2.3 installed 2026-10-15 (`intellij-idea-oss` from `extra`, bundled JetBrains Runtime, pulled in `jdk21-openjdk`; launcher `idea`). First launch not yet done; when opening a mod project set Gradle JVM to 25 (after installing it) or 21, never 27.

- [ ] `sudo pacman -S jdk25-openjdk`, then `sudo archlinux-java set java-25-openjdk` or
  `org.gradle.java.home=/usr/lib/jvm/java-25-openjdk` in `~/.gradle/gradle.properties`
  (JDK 27 can't run the template wrappers; the path is Arch's naming convention,
  unverified until installed).
- [ ] Generate a Fabric 26.3 template (fabricmc.net/develop/template), `./gradlew
  runClient`, then `build` and copy the jar into the Prism 26.3 instance after
  installing Fabric Loader 0.19.5 + Fabric API 0.162.0+26.3 there (Edit → Version →
  Install).
- [ ] Pick the editor route and test the report's untested snippets: nvim-jdtls
  ftplugin (Mason jdtls / java-debug-adapter / java-test, exclude jdtls from
  `automatic_enable`, `-Xmx`, `java.import.gradle.java.home`), or Emacs lsp-java /
  eglot-java, or `pacman -S intellij-idea-community-edition` + Minecraft Development.
- [ ] Start the learning sequence from the report (dev.java → Runestone "Java for
  Python Programmers" → Exercism → first item mod; Kaupenjoe Fabric-Tutorial-26.X
  branches via `git diff`).
- [ ] Hytale: decide whether to buy an account ($19.99) and try
  `HytaleModding/plugin-template` on JDK 25; whether the server runs on JDK 27 is
  unverified; the API is unstable (Update 7 broke plugins).
- [ ] Kids track (later): pre-built per-laptop project, seeded Gradle cache for
  `--offline`, the account question (Prism needs an owning Microsoft account per
  laptop).
- [ ] Unverified claims to check on first use: Loom's run dir (`run/`), Prism
  "export instance" path, measured build times on the studio laptops.

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
