# every player gets a permanent id once (owner checks compare it with the entry's owner)
execute as @a[distance=0..] unless score @s npc_pid matches 1.. run function npc:internal/new_pid
# clicks on a click box open that character's dialog for the clicker
execute as @e[distance=0..,type=interaction,tag=npc] if data entity @s interaction run function npc:internal/clicked
# /trigger create_npc opens the New character form (sneak + right-click a character edits it, see clicked)
execute as @a[distance=0..,scores={create_npc=1..}] at @s run function npc:internal/form_char_open {id:"new"}
scoreboard players reset @a[distance=0..] create_npc
scoreboard players enable @a[distance=0..] create_npc
# /trigger clear_all_npcs asks, then deletes every character the player made (not other players', not the starters)
execute as @a[distance=0..,scores={clear_all_npcs=1..}] run function npc:internal/confirm_clear
scoreboard players reset @a[distance=0..] clear_all_npcs
scoreboard players enable @a[distance=0..] clear_all_npcs
# /trigger clear_one_npc: pick a character from a list, then are-you-sure
execute as @a[distance=0..,scores={clear_one_npc=1..}] run function npc:internal/pick_delete
scoreboard players reset @a[distance=0..] clear_one_npc
scoreboard players enable @a[distance=0..] clear_one_npc
# /trigger refresh_starter_npcs brings Bob and Mira back
execute as @a[distance=0..,scores={refresh_starter_npcs=1..}] run function npc:internal/respawn_starters
scoreboard players reset @a[distance=0..] refresh_starter_npcs
scoreboard players enable @a[distance=0..] refresh_starter_npcs
# /trigger choose_name: the name form
execute as @a[distance=0..,scores={choose_name=1..}] run function npc:internal/form_name_open
scoreboard players reset @a[distance=0..] choose_name
scoreboard players enable @a[distance=0..] choose_name
# the Little NPC Book: once on first join, again on /trigger give_new_books
execute as @a[distance=0..,tag=!npc_book] run function npc:internal/give_book
execute as @a[distance=0..,scores={give_new_books=1..}] run function npc:internal/give_book
scoreboard players reset @a[distance=0..] give_new_books
scoreboard players enable @a[distance=0..] give_new_books
# dialog buttons: /trigger npc_choice set (100*num + button). A trigger, not /function: see load.
execute as @a[distance=0..,scores={npc_choice=100..}] at @s run function npc:internal/button
# reset only the presser: a blanket reset would also wipe the enable that show just set for someone whose screen is open
scoreboard players reset @a[distance=0..,scores={npc_choice=100..}] npc_choice
# a screen closed without a press would leave the trigger enabled (and in Tab): reset it when the countdown runs out
scoreboard players remove @a[distance=0..,scores={npc_open=1..}] npc_open 1
execute as @a[distance=0..,scores={npc_open=0}] run scoreboard players reset @s npc_choice
scoreboard players reset @a[distance=0..,scores={npc_open=0}] npc_open
# every tick: rebuild characters whose entities were killed (bodies are Invulnerable, but creative players and /kill get through);
# a handful of commands per character, so even a class's worth is cheap
function npc:internal/heal
# click box and name follow the body (wandering characters); fallen bodies go home
execute as @e[distance=0..,type=villager,tag=npc] at @s run function npc:internal/follow
execute as @e[distance=0..,type=villager,tag=npc,y=-200,dy=259] run function npc:internal/go_home
# Island Buttons (Island Builder achievement): a just-placed one gets a marker with the placer's id; a press teleports the
# nearest player to that player's island (marker without an id = back to the main island); islands build on first visit
# one-off: replace the unplaceable first-version Island Button (2026-10-18)
execute as @a[distance=0..,tag=!npc_btnfix,advancements={npc:three_npcs=true}] run function npc:internal/fix_island_button
execute as @a[distance=0..,scores={npc_placed=1..}] at @s anchored eyes positioned ^ ^ ^ anchored feet run function npc:internal/button_placed
scoreboard players reset @a[distance=0..] npc_placed
execute as @e[distance=0..,type=marker,tag=npc_isl] at @s run function npc:internal/isl_tick
execute as @a[distance=0..,x=512,dx=1000000] run function npc:internal/isl_ensure
# players who fell off: back onto the island they fell from
execute as @a[distance=0..,y=-200,dy=190] run function npc:internal/fell
