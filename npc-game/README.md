# NPC game (namespace `npc`)

Bedrock-style NPCs in Java, made and edited **in game**: right-click a character and a dialog screen opens with up to
three buttons that run commands or say lines. World `npc-game` in the `26.3_mini_games` Prism instance (a fenced grass
island in the void with two starter characters, Bob the Baker and Mira the Guide). Pack format 107-121.

Making a character, kid style (2026-10-16): type `/trigger create_npc` and a form opens (Name, Look dropdown, Greeting);
Create places the character where you stand and then walks through the three buttons: each asks "What should
button n do?" (Dialogue / Command / No button), then a fill-in screen with the label and a text box whose label fits
the choice ("What does the NPC say?" or "Command to run (no slash; @s = the player...)"); Next saves and moves on. Sneak + right-click a character to edit it: a menu offers "Name, look,
and greeting", "Buttons" (both prefilled), "Bring here", and "Delete" (with an are-you-sure). Empty boxes keep the old
value (empty label = no button). The only typing rule left is no quote marks (`"`) in any box: the typed values are
pasted into a `/function` command, so a quote breaks it with a red command error. A leading `/` in the command box is
forgiven since 2026-10-17 (`form_button_set` strips it on save, `internal/strip_slash` on press for older buttons). `load` sets
`send_command_feedback false` so dialog buttons don't print "Triggered [npc_choice]" / "Running function …" in chat; that also hides the
success replies to commands players type (errors still show). Submitting runs `/function` as the
player, so players need op (cheats on), same as the commands below.

**Ownership (2026-10-18, Dave's rule):** every player gets a permanent number (`npc_pid`, assigned by the tick) and each character
records its maker as `owner` (0 = the shared starters Bob and Mira; entries from before this change have no owner key and
count as anyone's). Anyone can talk to
any character; editing (sneak + right-click), deleting, `clear_one_npc` (lists only yours) and `clear_all_npcs` (deletes only
yours, via `internal/delete_mine`) work only on your own. Refusals print "… was made by someone else" or "… is a starter NPC"
(`internal/owns {id}` sets `ok npc_tmp`, `not_yours {name}` prints). The teacher's everything-goes, `___delete_all`, stays in `retired/`
until Dave adds it (no `/function` commands for anyone unless he adds them, 2026-10-18).
Characters can't be killed for good: bodies are `Invulnerable`, and every tick `internal/heal` rebuilds any character whose
body, click box, or name is missing (creative punches, `/kill`), as long as a player is within 64 blocks of its home spot.

**Achievement: Island Builder (2026-10-18).** The pack has an NPC Forge tab on the Advancements screen (L): `advancement/root.json`
(auto-granted by a `tick` trigger) and `three_npcs.json` (`impossible` trigger, granted by `internal/create` when a player's `npc_made`
reaches 3; announced in chat). Its reward function `internal/unlock_island` gives an **Island Button** (a polished blackstone button
with `can_place_on` listing grass, dirt, podzol, stone, and oak planks; 26.3's `#minecraft:dirt` tag has no grass_block, which made the first version unplaceable; `fix_island_button` swaps old copies once). Placing one bumps the `npc_placed` stat; the
tick raycasts along the placer's view (`button_placed` → `ray` → `ray_hit`) and leaves a `marker` tagged `npc_isl` in the block with
the placer's `npc_pid`. `isl_tick` watches each marker: a press (edge-triggered) runs `isl_press` → `visit {px}` for the nearest
player: teleport to (1024·owner, 66, 0) with slow falling. `isl_ensure` (tick, for every player at x ≥ 512) builds and repairs the
21×21 island at (px, 63, 0) under them in guarded passes (stone, then grass + a BACK TO MAIN ISLAND button whose marker has no id = main island).
A placed Island Button becomes a stone post with the button on top and an oak wall sign on its west face reading "<name>'s island"
(`ray_hit` → `island_post` → `post_sign {name}`; `my_name`/`my_name_get` resolve the chosen name or "Player <pid>"; `name_set` refreshes the
signs when the name changes; `post_upgrade` converts a button placed before posts existed). Gotcha fixed 2026-10-18: integer coordinates in
`positioned` are centred to .5, so markers are placed with `align xyz positioned ~0.5 ~0.5 ~0.5`; the first back-button marker landed in
the air and was deleted as "button gone" (`isl_back_rel` runs from `isl_ensure` every tick). Falling into the void returns you to the island you fell from (`fell`, x rounded to the nearest 1024).

Player commands (all `/trigger ...`, no op needed to type them; the forms they open run `/function` as the player, so cheats on):

    /trigger create_npc      New character form (name, look, greeting, then its three buttons)
    /trigger clear_one_npc   a screen listing every character; pick one, then are-you-sure (`internal/pick_delete` builds the
                             button list in storage and pastes it into an inline multi_action via macro)
    /trigger clear_all_npcs  delete every character (asks first; was `clear_npcs` until 2026-10-17)
    /trigger refresh_starter_npcs    Bob the Baker and Mira the Guide come back, fresh
    /trigger give_new_books        both books again (also given once on first join)
    /trigger choose_name           pick the name shown on your island sign (one text box; stored in storage npc:main names
                                   [{pid,name}]; the Island Builder reward opens it once if no name is set)

**Two instruction books** (2026-10-17), generated by `tools/gen_book.py` into `internal/give_book`: the **NPC Forge Book** and, kept as a second book for now at Dave's request, the original eight-page **Little NPC Book** (`custom_data={npc_book2:1b}`). The NPC Forge Book has
(edit the Python, run it from the pack root, rebuild the zip). Thirteen short pages: NPC Forge welcome, Get started (the three triggers), five command-basics pages lifted from the first Command Forge quests (Chat, Commands, Handy keys, /give, Spots), then Make a character, Buttons,
Command ideas, Edit a character, Rules (no quote marks, falling, how to get the book back), Start over (the two reset
triggers), Ideas. The tick gives it to anyone without the `npc_book` tag; `/trigger give_new_books` replaces the old copy
(the item carries `custom_data={npc_book:1b}` so only this book is cleared).

**Teacher functions (the only `___` ones in the pack, added by Dave 2026-10-18):** `/function npc:___reset_server` asks "Reset the whole
server?" then `internal/reset_server`: kills every character and island-button marker (player posts cleared by `post_clear`), empties
`npcs` and `names`, resets `npc_made`/`npc_pid`/`pidnext`/`next`, revokes `npc:root` and children for everyone, removes the book and
button-fix tags (books come back next tick), clears Island Buttons, adventure + spawn for all, re-seeds the starters. Old player islands
stay in the void and get reused by whoever draws that id again. `/function npc:___reset_player` (`internal/reset_player`, as the runner;
`/execute as <kid> run …` for someone else): revoke the achievement, reset `npc_made`, `delete_mine`, clear their posts, forget their
name (`name_forget`), clear buttons, re-give books, adventure + spawn. `starters` now forces `owner 0` on Bob and Mira even when a
player ran the refresh.

Hand commands, retired 2026-10-17 (Dave: the function list was too long; the forms cover everything). The files sit in
`retired/` outside the pack, unchanged, and are to be added back **one at a time** when a need shows up: `cp
retired/___x.mcfunction data/npc/function/` and rebuild. They are thin macro wrappers over the `internal/` functions
listed, which are all still in the pack (the forms and the starters use them):

    ___make                                                  open the New character form        -> internal/form_char_open {id:"new"}
    ___new {id:"zed",name:"Zed the Wizard"}                  a character where you stand        -> internal/create (job none)
    ___greeting {id:"zed",text:"Greetings, mortal."}         what they say when clicked         -> internal/set_greeting
    ___button {id:"zed",n:1,label:"Zap me",cmd:"effect give @s levitation 3 1"}   button n runs a command as the presser -> internal/set_button
    ___reply {id:"zed",n:2,label:"Who are you?",text:"I am Zed."}                 button n says a line                   -> internal/set_reply
    ___job {id:"zed",job:"cleric"}                           villager look                      -> internal/set_job
    ___rename {id:"zed",name:"Zed the Great"}                                                   -> internal/rename
    ___wander {id:"zed",on:0}                                1 strolls, 0 stays put             -> internal/set_wander
    ___here {id:"zed"}                                       bring them to you (new home spot)  -> internal/move_here
    ___clear_button {id:"zed",n:3}                                                              -> internal/clear_button
    ___delete {id:"zed"}                                                                        -> internal/delete
    ___delete_all                                            no are-you-sure                    -> internal/delete_all
    ___list                                                  who exists (ids)                   -> internal/list_loop (own logic in the file)
    ___respawn                                               put everyone back on their spot    -> internal/respawn_loop (own logic in the file)
    ___starters                                              same as /trigger refresh_starter_npcs      -> internal/respawn_starters
    ___help                                                  printed this list in chat (the book replaces it)

Ids are lowercase, no spaces; the form picks `c<n>`. Text can't contain double quotes (it's pasted into SNBT); commands
have no leading slash and run as the presser (@s). Buttons must be filled in order (1, then 2, then 3) when set by
hand; the form handles that.

How it works: characters are entries in storage `npc:main npcs` (`{num, id, name, job, greeting, pos, b1..b3}`). Each
one is three entities tagged `npc` + `npc_<id>` with the entry's `num` as an entity score (`npc_num`): a villager body
(no trades, so its own trade screen never opens; AI on unless `___wander 0`), an `interaction` click box, and a
`text_display` name; the tick teleports box and name onto the body. A right-click sets the box's `interaction` NBT;
`internal/clicked` loads the entry into `storage npc:main cur` (`load_cur` flattens labels and trigger numbers),
`execute on target` makes the clicker @s, and `show<n>` runs `dialog show @s {...inline multi_action...}` built by macro,
so no dialog JSON exists on disk. The forms are dialogs too (`internal/form_char`, `form_button_ask1`/`form_button_askn` + `form_button_screen`, `edit_menu`,
`confirm_delete`): `confirmation` dialogs with `inputs` (`text`, `single_option`) whose yes button is a
`dynamic/run_command` whose `template` pastes the typed values into `function npc:internal/form_apply {...}` /
`form_button_apply {...}` via `$(key)` placeholders. Those placeholders clash with mcfunction macro syntax, so `load`
stores the literal strings `"$(name)"` etc. in `storage npc:main ph` (a non-macro line) and the form macros receive them
as values (`ph_*`); `form_char_open {id}` / `form_buttons_open {id}` prefill from the entry (`id:"new"` = blank form,
`form_create` picks id `c<n>`), `form_jobflags` sets one `initial:true` flag for the Look dropdown, `form_button_kind {id,n,k}` → `form_button_prep {n}`
prefills button n's label/text and picks the text-box label for the kind; `form_button_apply`/`form_button_skip` → `form_button_next` chains on. Sneak-click is detected in `clicked` with `predicate/sneaking.json`. Buttons run `/trigger npc_choice set 100*num+k` and the tick decodes that in `button`. The trigger is enabled only while an NPC screen is open (`show` enables it and starts a 2-minute `npc_open` countdown; the press or the countdown resets it), so it stays out of `/trigger` Tab completion, which lists enabled triggers only (it must stay a trigger: a dialog button running an op-level command such as `/function` makes the client show a "Confirm Command Execution" screen first; `/trigger` doesn't. Tried `function npc:internal/press` and reverted 2026-10-17, file in `retired/`). The form submits do run `/function`, so they get that confirmation screen every time; no way around it in vanilla yet. `button` fetches
`b<k>.cmd` / `b<k>.say` and runs it (`exec` = `$$(cmd)`) or prints it (`speak`). Fallen bodies are sent home by the tick.

Build and install:

    cd npc-game
    zip -qr ../zips/npc-game.new.zip pack.mcmeta data && mv ../zips/npc-game.new.zip ../zips/npc-game.zip
    cp ../zips/npc-game.zip ~/.var/app/org.prismlauncher.PrismLauncher/data/PrismLauncher/instances/26.3_mini_games/minecraft/saves/npc-game/datapacks/
