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
  tools). 2026-10-18: quest text moved from chat to dialog screens (SHOW
  QUEST post; TrueType font + pale blue + darker menu blur via the no-moon
  resource pack, sun and moon hidden), sealed pitch-black intro room, NEXT/
  PREVIOUS posts only after quest 1 (quest 1 completes from its own Try it /
  I did it! buttons), Stuck page dropped from the book. Open from that
  evening: Dave reported "a white box around the text" in a dialog before the
  world was reopened — get a screenshot and check; the intro, welcome, and
  the two notice dialogs still use the normal font; the resource pack must be
  on every laptop that plays singleplayer (or the dialogs show boxes) — fine
  once the server sends it; review all 20 quest dialogs in the new style;
  remember dialog JSON needs a world re-enter, not /reload. Older open items:
  a second-player LAN test (per-player islands, the
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
"Studio server"). It's at the studio since 2026-10-20, on the studio Wi-Fi at
192.168.0.250 (router reservation), reachable with `ssh dell`.

- [x] **Decide Docker vs plain** (2026-10-19): plain Java per the report; Dave's
  version-juggling worry is covered by one launcher jar per game folder and
  side-by-side `jre17/21/25` packages. The box came back on `linux-lts`
  6.18.57.
- [x] **First server** (2026-10-19): `/srv/mc/npc-game/` on 25565 with the
  `npc-game` world + pack, whitelist + op for `lazerbrain6562`, LAN join from
  the laptop works (state in CLAUDE.md "First server running").
- [ ] **Next steps on the server, in order** (each step = Dave runs the
  commands, one at a time, with explanations; report section "Recommended
  setup for this box, in order" has the exact files):
  1. ~~Tidy-ups~~: ops level 4 confirmed 2026-10-20; `world.fresh/` (the
     default world the first start generated) stays as a blank test world
     (Dave, 2026-10-20) — rename/move it so it isn't mistaken for the live one.
  2.–6. [x] Done 2026-10-20: `paru` (built from source, `paru-bin` is stale
     against pacman 7.1), `mcrcon`, units + flags + `.env` installed,
     `minecraft@npc-game` enabled under `minecraft.target`, all checks
     passed (RCON list, clean stop, no `SYSCALL` lines, affinity 0-11). Open:
     the `notify@.service` oneshot for `OnFailure=`.
  7. [x] Firewall (2026-10-20): `server-config/nftables.conf` installed and
     enabled; SSH from the LAN (rate-limited) and `tailscale0`; PXE ports
     are a commented block. 2026-10-23: `mc_ports` narrowed back to the
     game ports (the 2026-10-22 widening to 25580 had exposed RCON
     25575–25580 to the LAN/Tailscale), now 25565–25573; widen by one per
     new server. Box timezone set to America/New_York the same day.
  8. [x] Backups (2026-10-23; state in CLAUDE.md "Backups running"):
     script + units installed, repo initialised, hourly timers for all
     nine games, restic password rotated (`pass minecraft-restic` = the
     entry's real name), laptop copy via `mc-pull` **by hand** (Dave: no
     timer; `/updates` reminds when `~/mc-backups/.last-pull` is > 1 day
     old). Two fixes went into `server-config/mc-backup` (`--retry-lock`,
     `RESTIC_CACHE_DIR`) and `laptop/mc-pull` (manual, stamp file,
     `GPG_TTY`). Open: `restic forget --tag survival-basic --tag
     creative-basic --prune` to drop the two pre-rename snapshots (Dave
     noticed them in the `mc-pull` table; asked, not yet answered); a sudo
     line for `/usr/bin/rsync` when NOPASSWD goes.
  9. [x] 2026-10-22: `survival-basic` 25566/25576 and `creative-basic`
     25567/25577 (vanilla, random seeds, keep_inventory) via
     `server-config/new-server.sh`. Same day: `command-forge` 25568/25578
     (+ `mc-www.service` on 8080 serving `no-moon.zip`, required pack),
     `tile-game` 25569/25579, `one-block` 25570/25580 (= one-block_2).
     Also 2026-10-22: `server-config/mc-lan-announce` + `.service` installed
     and enabled on the box — every server shows up under LAN worlds in the
     multiplayer screen on the studio Wi-Fi (verified from the laptop), so
     nobody types an address in the studio.
     2026-10-23: `survival-basic`/`creative-basic` renamed `survival-1`/
     `creative-1`; `survival-2` 25571/25581 and `creative-2` 25572/25582
     added (fresh worlds); `jump-game` 25573/25583 (the jump-game-2 world +
     zip, motd "Jump Game"); `max-players=20` everywhere; nine servers.
     Done 2026-10-23: the eleven studio accounts are whitelisted on every
     server and op level 2 on command-forge (`whitelist add` / `op` over
     RCON). **Standardize the account names at Microsoft:** the first account
     is `NCMC1` (no underscore; `NCMC_1` doesn't exist at Mojang, whitelisted
     as NCMC1 "for now"), and 2–4 are stored lowercase (`ncmc_2`, `ncmc_3`,
     `ncmc_4`) while 5–11 are `NCMC_5`..`NCMC_11`. Rename them to one
     pattern at account.xbox.com / minecraft.net (one free change per 30
     days per account); the whitelists follow the account ID, so no server
     change is needed after a rename.
     Rule for any new server: world from Prism + pack zip in
     `world/datapacks/`, `enable` the instance so `minecraft.target` owns
     it, widen `mc_ports`, enable its `mc-backup@` timer. `npc-game` and the
     two `oneblock` packs must stay in separate servers (same namespace /
     storage). Nothing hostable is left in the repo (the original
     jump-game and one-block are subsets of what runs).
  10. [x] Tailscale on the box (2026-10-20: `arch-dell` 100.97.207.31,
     `--ssh`) and the laptop (`arch-76` 100.117.24.107, logged in after the
     reboot; `ssh dell-ts` verified, direct 4 ms path on the studio LAN).
     Open: SSH hardening (key-only sshd drop-ins, `AllowUsers dave`); parent handout for the Xbox
     multiplayer toggle (under-16 accounts are blocked by default). The box
     left the house before this was done (2026-10-20); the studio router
     reservation is done.
  Open: joining takes ~9 s even on an immediate rejoin (not the empty-pause,
  not the network — both ends reach Mojang in 50 ms); client-side? compare
  with a join from another laptop. NTP was off on the box (clock 5 min fast)
  until 2026-10-20, fixed with `timedatectl set-ntp true`.
     2026-10-23: Tailscale SSH's `check` policy (browser re-auth every 12 h)
     changed to `accept` by Dave in the admin console; from home everything
     goes over Tailscale (relayed via DERP nyc, ~15 ms; no port forwarding
     wanted).
  Later: `%wheel NOPASSWD` → per-command lines, LUKS remote unlock (TPM2 or
  initramfs SSH), Uptime Kuma.
- [x] **Move the box to the studio** (2026-10-20): on studio Wi-Fi, DHCP
  reservation 192.168.0.250 on the TP-Link BE6500 (`ssh dell`). Still open:
  Ethernet cable (then a second reservation for `enp1s0`, e.g. .251);
  auto-restart of the game servers at boot = the service step above; LUKS
  passphrase still typed by hand at the box after any power cut (fine while
  nobody plays unattended; TPM unlock or a reinstall without LUKS if that
  changes).
- [ ] **PXE + Clonezilla imaging** for the studio laptops on the same box:
  dnsmasq proxy-DHCP + TFTP, iPXE menu, Clonezilla Live over HTTP/NFS, images
  on `/home`; Clonezilla SE for multicast class-set restores; needs a switch
  and wired laptops, UEFI boot files, Secure Boot off.
- [ ] **Housekeeping on the box:** merge/delete the `.pacnew` files (keep the
  live `mkinitcpio.conf`), decide whether `%wheel NOPASSWD` stays, weekly
  update + reboot habit when he's on site. Done 2026-10-19: `ssh dell` alias
  on the laptop (now 192.168.0.250 at the studio), fresh US
  mirrorlist, dotfiles (`dot-files-dell-arch`, cloned from the system76 repo
  with a `system76` remote for cherry-picks), nvim, tmux + tpm, wezterm.
- [x] **Git pushes from the box** (done 2026-10-19): `gh auth setup-git` +
  `git_protocol https`, so plain `git push` uses the gh token; its
  `id_ed25519` has a passphrase and no agent, so SSH pushes stay broken.
- [ ] **Trim the dell dotfiles** (`~/dot-files` on the box, repo
  `dot-files-dell-arch`): commit the polybar edits (dell interfaces, laptop
  modules dropped); strip kmonad, brightness keys, and the HDMI mirror toggle
  from the i3 config, the touchpad `xorg.conf.d` entry; pin
  `branch = 'master'` on nvim-treesitter (+ textobjects) in
  `neovim-config`'s `lazy-plugins.lua` (both machines), later migrate
  `treesitter-setup.lua` to the `main` API. Try `iw dev wlp2s0 set
  power_save off` for the SSH lag until the box is on Ethernet.
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
