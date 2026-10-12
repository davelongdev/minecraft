# Commands tutorial map for 26.3 (in-game only, no videos)

## Context

Dave runs a Newburgh Creates program where kids (~8–12) design analog games and translate them into Minecraft/Scratch. He wants to teach Minecraft Java commands entirely inside the game: no videos, every explanation in the world. slicedlime's Command Training Grounds proves the architecture (outcome-based checks, re-asserted props, playful corrections) but is 1.19.3-only, single-player by construction, unlicensed, and never reached functions/data/components. We build our own from scratch, legally: copy the *ideas*, write all code and text ourselves. Research: `~/minecraft/reports/Teaching Minecraft Java commands.md`.

Decisions confirmed with Dave (2026-10-11):
- **Per-player progress** (scores on the player + a plot per player) so a LAN/Realm class works.
- **First slice = engine + Section 1** "Command Basics" (chat only, before command blocks), playable in one sitting.
- **Audience kids ~8–12**: short sentences, one idea per screen, playful first-person narrator ("Coach").
- Section 1 must cover: **Tab autocomplete**, **T opens chat and frees the mouse so you can click links** (Esc closes), **Up arrow recalls previous commands**, and the words **CLI** and **REPL** in kid terms.
- Target **Minecraft 26.3** (released 2026-09-15, data pack format **121.0**; Prism instance `26.3`), decided 2026-10-11 so the pack matches what kids install today. This is the first pack in the repo not on 26.2: install into the `26.3` instance's `saves/`, and read the `26.3` instance's `latest.log`. New pack dir `~/minecraft/commands-tutorial/`, namespace `tut` (distinct from slicedlime's `ctg`). Identifiers below were verified against the 26.2 jar and re-checked against the 26.3 jar (see "26.3 differences" section).

## Name

Working title **Command Forge** (chosen 2026-10-12; was "Learn Commands"). Alternates Dave wants kept on the list:

- Command Academy
- Command Lab
- Command Dojo
- Minecraft Command Lab

## Key design decisions

| Decision | Choice | Why |
|---|---|---|
| Plot layout | Plot `n` origin `(128·n, 100, 0)`, 32×32 floor at y 99, cleared volume to y 120. Hub pad at `0 99 0` is just world spawn + a sign (join auto-teleports). | 128 apart keeps a kid's later `fill`/`kill` mistakes local; short kid-friendly coordinates. |
| Sandbox chunk | One shared force-loaded chunk at `-1024 -1024` with a bedrock floor, reserved now, used from Section 2 (per-player tags, one check per tick). | Section 1 doesn't need it; cheap to reserve. |
| Exercise addressing | `dispatch` runs exercise functions `positioned <px> 100 0`; exercise files use `~` coordinates and are **plain non-macro functions**. Exercises needing per-player numbers (e5 sign text) call their own macro leaf `with storage tut:main args`. | Avoids calling non-macro functions `with` arguments (unverified behaviour). |
| Vehicles in Section 1 | `say`, `gamemode`, `give`, `tp`, `help`, `clear`. No `time`/`weather`/`gamerule` (world-global; two kids would collide). | Per-player verifiable. |
| `/say` verification | Not detectable (no event/stat). e1 is "do it, then click **[I did it!]**" via `trigger`. | The click *is* the T-frees-the-mouse lesson. Lowest-stakes exercise, trust is fine. |
| Game mode | New players start adventure; e2 has them switch to creative themselves; course runs creative afterwards. `defaultgamemode adventure`. | Real, per-player-verifiable change; protects the plot before they know anything. |
| Buttons | Every dialog/chat/book button runs `trigger tut_btn set <n>` (level 0). Tick routes 1=exercise "done/go", 2=hint, 3=restart exercise, 4=book; then resets to 0 + re-enables. | Dialog `run_command` runs with the *player's* permission; `trigger` works for non-ops. Students still need cheats for `give`/`tp` (README). |
| Dialogs | `pause:false`, `can_close_with_escape:true`, `after_action:"close"` everywhere. Lesson screens = `multi_action` chained with `show_dialog` "Next"; hints = `notice` with a `suggest_command` button that puts the command in the chat box. | Pausing would freeze ticks in SP and desync MP. One idea per screen via chaining. |
| Feedback rules | `send_command_feedback true` (kids must see the REPL "print"), `command_block_output false`. | |
| Void | `player_tick` catches y < 0 and tps home with a joke; `keep_inventory true`, `fall_damage false`. | Avoids death-screen state issues. |

## File tree

```
commands-tutorial/
  pack.mcmeta                      min_format/max_format 107; description "Command Coach: learn Minecraft commands in-game"
  README.md                        install (host-side zip copy), world creation (Void preset, cheats ON), running a class, teacher commands, troubleshooting (latest.log, red macro errors)
  data/minecraft/tags/function/load.json   ["tut:internal/load"]
  data/minecraft/tags/function/tick.json   ["tut:internal/tick"]
  data/tut/function/
    ___start                       tut_tick=0 (replays current exercise intro) + tp @s home
    ___hint                        store_args → internal/show_hint (macro `$dialog show @s tut:s$(sec)/e$(ex)/hint`)
    ___book                        re-give reference book
    ___restart_exercise            tut_tick=0, tut_last=-1 (start re-runs next tick)
    ___restart_section             tut_ex=0 + restart_exercise
    ___reset_player                run as player: sec=1 ex=0, clear inv, rebuild plot, re-give book, adventure, tp home (keeps tut_id)
    ___reset_world                 every online player → ___reset_player; re-floor sandbox (offline players reset on next join is NOT automatic; document)
    ___skip                        teacher: complete current exercise for @s (`execute as <kid> run function tut:___skip`)
    ___goto                        teacher macro: `function tut:___goto {sec:1,ex:3}` (validates ranges)
    internal/load                  objectives (idempotent), constants, forceload sandbox, enable tut_btn, init guard
    internal/init                  one-time: clear Void platform, hub pad+sign, setworldspawn, gamerules, sandbox floor, tut_init=1
    internal/tick                  join detection + `execute as @a[joined] at @s run player_tick`
    internal/join                  assign id/px, set scores, build plot, book, adventure, welcome tellraw
    internal/player_tick           tick++, store_args, void catch, button routing, all_done or dispatch, btn reset+enable
    internal/store_args            scores → storage tut:main args.{sec,ex,px}
    internal/dispatch              macro routing (below)
    internal/complete              title/sound/particles, ex++, tick=0, last=-1, section rollover
    internal/section_complete      macro `$dialog show @s tut:s$(sec)/done`, sec++, ex=0, tick=0
    internal/all_done              actionbar "free play" + one-time dialog when sec > maxsec
    internal/show_hint             macro dialog show
    internal/build_plot            macro `$execute positioned $(px) 100 0 run function tut:internal/build_plot_rel`
    internal/build_plot_rel        relative: clear volume, floor, welcome sign, spawnpoint @s, tp @s ~4.5 ~ ~16.5 -90 0
    internal/give_book             clear + give written_book
    internal/void_catch            macro tp @s to plot spawn + funny line
    s1/e0..e5/{start,tick,check}   exercises (e5 also has text_sign macro leaf)
  data/tut/dialog/
    s1/e0/p1..p5.json, hint.json   intro screens (T, slash, CLI, REPL; p5 has [Let's go!])
    s1/e1..e5/lesson.json (+p2,p3), hint.json
    s1/done.json, common/all_done.json
```

Build: `cd ~/minecraft/commands-tutorial && rm -f ../zips/commands-tutorial.zip && zip -r ../zips/commands-tutorial.zip pack.mcmeta data`.

## Data model

| Kind | Name | Meaning |
|---|---|---|
| dummy obj | `tut_init` | fake `global` = 1 after init |
| dummy obj | `tut_joined` | per player; `players add @a tut_joined 0` first so unset matches `..0` (one-block_2 idiom) |
| dummy obj | `tut_id`, `tut_px` | permanent per-player id (fake `global tut_id` counter, as `ob_id`); `tut_px = tut_id * 128` |
| dummy obj | `tut_sec`, `tut_ex` | course position; sec starts 1, ex starts 0 (= section intro) |
| dummy obj | `tut_tick` | ticks since exercise start (0 on complete/restart) |
| dummy obj | `tut_tmp`, `tut_last` | probe scratch; last probe value for edge-triggered correctives (-1 = none) |
| dummy obj | `tut_const` | fakes `c128`=128, `s1`=5 (last exercise index of section 1), `maxsec`=1 |
| trigger obj | `tut_btn` | button channel (1 go/done, 2 hint, 3 restart, 4 book) |
| storage | `tut:main args` | `{sec,ex,px,gx}` for the player being processed |
| forceload | chunk `-1024 -1024` | sandbox; bedrock floor y 0 |
| plot n | origin `(128n,100,0)`; floor `fill ~ ~-1 ~ ~31 ~-1 ~31 smooth_stone`; clear `~ ~ ~ ~31 ~20 ~31` (21,504 blocks, under 32,768 limit; also set `gamerule max_block_modifications 100000` in init for later sections); spawn `~4.5 ~ ~16.5` facing east; welcome sign `~5 ~ ~16`; cage centre `~24 ~0 ~16` |

Gamerules in init (snake_case, jar-verified): `advance_time false`, `time set noon`, `advance_weather false`, `respawn_radius 0`, `command_block_output false`, `send_command_feedback true`, `spawn_mobs false`, `fall_damage false`, `keep_inventory true`, `max_block_modifications 100000`, `defaultgamemode adventure`, `setworldspawn 0 100 0 0 0`. Void-platform clear = the two fills from `one-block_2/.../internal/init.mcfunction`.

## Pipeline

`internal/tick`
```
scoreboard players add @a tut_joined 0
execute as @a[scores={tut_joined=..0}] run function tut:internal/join
execute as @a[scores={tut_joined=1}] at @s run function tut:internal/player_tick
```
`internal/player_tick`
```
scoreboard players add @s tut_tick 1
function tut:internal/store_args
execute if entity @s[y=-300,dy=299] run function tut:internal/void_catch with storage tut:main args
execute if score @s tut_btn matches 2 run function tut:___hint
execute if score @s tut_btn matches 3 run function tut:___restart_exercise
execute if score @s tut_btn matches 4 run function tut:internal/give_book
execute if score @s tut_sec > maxsec tut_const run function tut:internal/all_done
execute unless score @s tut_sec > maxsec tut_const run function tut:internal/dispatch with storage tut:main args
scoreboard players set @s tut_btn 0
scoreboard players enable @s tut_btn
```
`internal/dispatch` (macro; exercise functions are plain)
```
$execute if score @s tut_tick matches 1 positioned $(px) 100 0 run function tut:s$(sec)/e$(ex)/start
$execute positioned $(px) 100 0 run function tut:s$(sec)/e$(ex)/tick
```
Exercise contract (`@s` = student, position = plot origin):
- `start`: once at tick 1. Reset props/state (clear items, gamemode, rebuild cage), `tut_last -1`.
- `tick`: every tick. (a) re-assert props with `unless block` guards; (b) `title @s actionbar <goal>`; (c) tick 30 → `dialog show @s tut:sX/eY/lesson`; tick 200 and 600 → tellraw nudge with clickable `[Show hint]`; (d) probe into `tut_tmp`; if `tut_tmp != tut_last` update and print the matching corrective (edge-triggered, no spam); (e) `execute if function tut:sX/eY/check run function tut:internal/complete with storage tut:main args`.
- `check`: only `return 1` / `return fail`.

`internal/complete`: `title times 5 40 10`, title "Great job!" green bold, `playsound entity.player.levelup`, totem particles, `tut_ex += 1`, `tut_tick 0`, `tut_last -1`, `$execute if score @s tut_ex > s$(sec) tut_const run function tut:internal/section_complete with storage tut:main args`.
`internal/join`: `tut_joined 1`; `global tut_id += 1`; `@s tut_id = global`; `tut_px = tut_id * c128`; sec 1, ex 0, tick 0, last -1; store_args; build_plot (with storage); give_book; `gamemode adventure @s`; welcome tellraw. Next tick → `s1/e0/start`, intro dialog at tick 30.

## Section 1 exercises (Coach voice; dialogs ≤3 short sentences per screen)

| # | Actionbar goal | Screens | start | check | Correctives / hint |
|---|---|---|---|---|---|
| e0 Intro | "Read Coach's screens, then click Let's go!" | p1 "Hi there!" I'm Coach. Commands are magic words that make Minecraft do things. · p2 "The chat box" Press T. Chat opens and your mouse is free, so you can click things. Esc closes it. · p3 "Every command starts with /" Type / first so Minecraft knows it's a command. Enter runs it. · p4 "Big word: CLI" Controlling a program by typing words instead of clicking = command-line interface. The chat box is your CLI. · p5 "Big word: REPL" You type a line. Minecraft Reads it, Evaluates (runs) it, Prints an answer, Loops back for your next line. Button **[Let's go!]** → `trigger tut_btn set 1` | none | `tut_btn matches 1` | nudge: "Psst! Press T, then click [Let's go!]" (clickable). Hint: press T so the mouse is free, click the green words. |
| e1 Say hello | "Say hello: /say hello, then click [I did it!]" | p1 Press T. Type exactly `/say hello`. Enter. Everyone sees it, even me. · p2 Press T again and click the green **[I did it!]** in chat. | tellraw `[I did it!]` at tick 1 and nudges | `tut_btn matches 1` | Hint: slash first; suggest `/say hello`. |
| e2 Tab + help → creative | "Switch to Creative: /gamemode creative" | p1 "Tab is your friend" Type `/gam` and press Tab. Minecraft finishes the word! · p2 Type `/gamemode ` and press Tab to see the choices. Pick creative. Enter. · p3 "Lost? Ask for help" `/help gamemode` shows what a command wants. | `gamemode adventure @s` | `@s[gamemode=creative]` | probe gamemode code: spectator → "Boo! You're a ghost. Try creative." survival → "Survival? Brave. But I need creative." Complete subtitle: "You can fly now: double-tap Space." |
| e3 Give with count | "Give yourself exactly 10 cookies: /give @s cookie 10" | p1 "Snack time" (item body cookie ×10) `/give @s cookie 10`. @s means me. 10 is how many. · p2 "Full names" Every item has a full name like minecraft:cookie; the minecraft: part is optional. Tab shows the names! | `clear @s cookie` | `execute store result score @s tut_tmp run clear @s cookie 0` → `matches 10` | 1..9: "Only N cookies? My tummy says 10." 11..: "N cookies?! Too many. Type /clear @s cookie and try again." (N via `{"score":...}`) |
| e4 Up arrow | "Now 10 bread: press Up arrow, change cookie to bread" | p1 "The Up arrow" Press T, then Up. Your last command comes back! Change cookie to bread. Enter. | `clear @s bread` | `clear @s bread 0` → `matches 10` | same two messages with bread. |
| e5 tp to X Y Z | "Teleport into the glass cage. The numbers are on the sign." | p1 "Where am I?" Every spot has 3 numbers: X Y Z. X is east, Y is up, Z is south. · p2 "Teleport!" See the glass cage with a gold block? You can't walk in. `/tp @s X Y Z` with the sign's numbers can. · p3 "Tab trick" Look at a block and press Tab in `/tp @s ` and Minecraft types that block's numbers. | build cage: `fill ~23 ~0 ~15 ~25 ~3 ~17 glass`, `setblock ~24 ~0 ~16 gold_block`, `fill ~24 ~1 ~16 ~24 ~2 ~16 air`; sign at `~22 ~0 ~16` via macro leaf `text_sign` (`gx = px+24` stored in `args.gx`): `oak_sign{front_text:{messages:[{text:"Cage inside:"},{text:"$(gx) 101 16",color:"gold"},"",""],has_glowing_text:true},is_waxed:true}`; all re-asserted each tick with `unless block` | `execute positioned ~24 ~1 ~16 if entity @s[dx=0,dy=1,dz=0] run return 1` | on top (`positioned ~24 ~4 ~16 … dy=2`): "So close! You're ON the cage. The middle number is how high: try 101." Far off plot: "Whoa, that's far! [Bring me back]" (`trigger tut_btn set 3`). Hint: suggest `/tp @s ` and point at the sign. |

`s1/done.json`: "Section 1 done! You can open chat, autocomplete, repeat commands, say, gamemode, give and tp. Section 2 (command blocks) is coming soon." `common/all_done.json`: free play.

Dialog JSON shape (jar-verified fields):
```json
{"type":"minecraft:multi_action","title":{"text":"Snack time","color":"gold"},"external_title":{"text":"Lesson 1.3"},
 "pause":false,"can_close_with_escape":true,"after_action":"close",
 "body":[{"type":"minecraft:plain_message","width":300,"contents":[{"text":"Type this and press Enter:\n"},{"text":"/give @s cookie 10","color":"aqua","bold":true}]},
         {"type":"minecraft:item","item":{"id":"minecraft:cookie","count":10},"description":{"text":"Ten cookies, please."},"show_decorations":true,"show_tooltip":true}],
 "columns":1,
 "actions":[{"label":{"text":"Next"},"action":{"type":"minecraft:show_dialog","dialog":"tut:s1/e3/p2"}},
            {"label":{"text":"Copy the command"},"action":{"type":"minecraft:copy_to_clipboard","value":"/give @s cookie 10"}}],
 "exit_action":{"label":{"text":"Close"}}}
```
Hint = `minecraft:notice` with `action.action = {"type":"minecraft:suggest_command","command":"/give @s cookie 10"}` labelled "Put it in my chat box".

Reference book `written_book[written_book_content={title:"Coach's Little Book",author:"Coach",pages:[...]}]`: 1 How to type a command (T, /, Enter, Esc) · 2 Tab = finish my word (cycles choices; fills in the block you look at) · 3 Up arrow = last command · 4 Big words: CLI, REPL · 5 Commands I know (`say`, `gamemode`, `give @s <item> <count>`, `clear`, `tp @s X Y Z`, `help`) · 6 Names (`minecraft:cookie` = `cookie`; `@s` = me) · 7 Stuck? clickable `[Show hint]` (btn 2), `[Restart this exercise]` (btn 3) · 8 For teachers (`___skip`, `___goto`, `___reset_player`, `___reset_world`).

Chat/sign/book links: SNBT `click_event:{action:"run_command",command:"trigger tut_btn set 2"}` (no leading slash), `hover_event:{action:"show_text",value:"..."}`.

## 26.3 differences that affect this pack (verified against the 26.3 jar, 2026-10-11)
- `pack.mcmeta`: `"min_format": 121, "max_format": 121` (plain integers, as in the jar's built-in pack).
- **Signs:** new `allow_op_features` boolean, default false. Without it, sign `click_event`s (even `trigger`) are skipped with "Click actions are disabled for this sign", and score/selector components don't resolve. Every sign we place gets `allow_op_features:1b`, with `click_event` on the root component of each line. (Signs saved before 26.3 are auto-upgraded; ours are new.)
- `gamerule <x> <same value>` and `time set <same>` now **error** instead of no-op: fine in `init` (runs once), but never rely on their success inside tick logic.
- `execute if items entity @s weapon.mainhand <item>` still parses (slot names are tried first under the new "slot source" argument). New `execute if slots`, `/item fill|override`, `/compute`, `/posteffect`: not used in slice 1; `/compute` is a candidate for later scoreboard-maths lessons.
- `give` over the stack limit errors instead of returning 0 (irrelevant for `give @s cookie 10`).
- Dialog JSON, `/dialog`, text style keys, `trigger` (level 0), command-block NBT, `written_book_content`, interaction/text_display fields, gamerule IDs, macros, `return`, `forceload`, `place template`: unchanged from 26.2.

## Repo housekeeping (same change)
- **First step after approval:** copy this plan into the repo as `commands-tutorial/PLAN.md` (Dave's request, 2026-10-11) and keep it updated as sections are built; it is the pack's design doc.
- Add `commands-tutorial/` entry to `~/minecraft/CLAUDE.md` "What this is" and tick the TODO item to "in progress (Section 1 built)".
- Pack README documents: students need cheats/op; `/reload` after zip update; check `latest.log` for "Failed to load function"; dialog JSON parse errors also appear in the log.

## Verification

1. Build zip; `unzip -l` shows `pack.mcmeta` + `data/` at root.
2. Fresh void world host-side (clone an existing void save per CLAUDE.md, or in-game Superflat → The Void, Allow Commands ON). Copy zip to `$SAVES/<world>/datapacks/` (26.2 instance; confirm no ` (1)` suffix).
3. `/reload`; `grep -A3 "Failed to load function" "$SAVES/../logs/latest.log"`; also grep `dialog` for parse failures. Expect none.
4. Engine: `/scoreboard objectives list` shows all `tut_*`; `/forceload query -1024 -1024`; `global tut_init` = 1; landed at plot 1 (~`132 100 16`) facing east with sign + book, adventure.
5. Walk Section 1 as player 1: intro at ~1.5 s; [Let's go!] → "Great job!", `tut_ex`=1. `/say hello` + [I did it!]. `/gamemode spectator` (ghost joke) then creative. `/give @s cookie 7` ("Only 7…"), `+3` passes. Up arrow → bread. `/tp @s 152 100 16` (corrective or pass), `/tp @s 152 101 16` passes → done dialog → all-done screen.
6. Hints: `/function tut:___hint`, book `[Show hint]`, nudge link all open the right hint; "Put it in my chat box" fills the chat line.
7. Two players (Open to LAN, cheats ON, second account): player 2 at plot 2 (x 256..287), own intro and scores; cookies/tp/clicks don't cross over.
8. Teacher: `execute as <kid> run function tut:___skip` advances one; `___goto {sec:1,ex:5}` rebuilds cage within a tick; `___reset_player` clears inv/plot, re-gives book, adventure, back to e0, same `tut_id`; `___reset_world` for all online.
9. Destructive: break cage glass/gold in creative → replaced next tick; walk off the plot → caught below y 0 and sent home.

## Risks to confirm in-game
- `dialog show` from a tick function running `as` the player opens once (we call it only at tick 30) and works with chat open.
- `pause:false` keeps SP ticking (set explicitly on every dialog).
- `clear @s cookie 0` result = count (lang key `commands.clear.test.single "Found %s matching item(s)"` suggests yes).
- `score`/`nbt` components inside dialog bodies may not resolve per viewer → keep dialog text static; per-player numbers go on the sign/actionbar via macros.
- `tp` into the gold block: push-out lands in the pocket or on top; either path handled.
- Tab on a `/tp` position argument suggesting the looked-at block's coordinates in 26.2 (e5 p3; downgrade to a tip if not).
- Dialog `run_command` from a non-op: `trigger` is level 0 so should pass.
