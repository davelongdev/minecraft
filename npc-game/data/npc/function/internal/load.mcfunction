# Runs on every /reload; one-time setup lives in init.
# Characters live in storage npc:main npcs = [{num, id, name, job, greeting, pos:[x,y,z], b1:{label,cmd}, b2, b3}, ...].
# Each character's three entities (villager body, interaction click box, text_display name) are tagged npc and
# npc_<id> and carry the character's num as an entity score (npc_num), which is how a click finds its entry.
scoreboard objectives add npc_init dummy
# npc_choice stays a trigger on purpose: a dialog button that runs /function pops Minecraft's "Confirm Command Execution"
# screen (op-level command), /trigger does not (tried and reverted 2026-10-17)
scoreboard objectives add npc_choice trigger
scoreboard objectives add npc_open dummy
scoreboard objectives add create_npc trigger
scoreboard objectives add clear_all_npcs trigger
scoreboard objectives add clear_one_npc trigger
scoreboard objectives add refresh_starter_npcs trigger
scoreboard objectives add give_new_books trigger
scoreboard objectives add choose_name trigger
scoreboard objectives add npc_num dummy
# npc_pid = permanent per-player number (assigned in tick); each character's entry records its maker as owner (0 = shared starter)
scoreboard objectives add npc_pid dummy
# achievements: npc_made counts a player's creations (3 -> npc:three_npcs); npc_placed = Island Button placements
scoreboard objectives add npc_made dummy
scoreboard objectives add npc_placed minecraft.used:minecraft.polished_blackstone_button
scoreboard objectives add npc_tmp dummy
# leftovers in older worlds: the first names of the player triggers; removed so they stay out of /trigger autocomplete
scoreboard objectives remove npc
scoreboard objectives remove clear_npc
scoreboard objectives remove clear_npcs
scoreboard objectives remove starters_npc
scoreboard objectives remove npc_book
scoreboard objectives remove starter_npcs
# npc_choice is enabled per player in show, not here: enabled triggers show in /trigger Tab (confusing, Dave 2026-10-18)
scoreboard players reset @a npc_choice
scoreboard players enable @a create_npc
scoreboard players enable @a clear_all_npcs
scoreboard players enable @a clear_one_npc
scoreboard players enable @a refresh_starter_npcs
scoreboard players enable @a give_new_books
scoreboard players enable @a choose_name
# The form dialogs paste typed values into a command via $(key) templates, which clash with mcfunction macro syntax,
# so the forms get these placeholder strings as macro values (this line is not a macro line, so nothing is substituted).
data modify storage npc:main ph set value {name:"$(name)",job:"$(job)",greeting:"$(greeting)",k:"$(k)",l:"$(l)",t:"$(t)"}
# no "Running function npc:internal/press" / "...form_apply" lines in chat after every dialog button (Dave, 2026-10-17).
# Side effect: the success replies to commands the kids type themselves ("Gave 5 cookie") are hidden too; errors still show.
gamerule send_command_feedback false
execute unless data storage npc:main npcs run data modify storage npc:main npcs set value []
# chosen player names: [{pid, name}] (choose_name form; shown on island signs)
execute unless data storage npc:main names run data modify storage npc:main names set value []
scoreboard players add next npc_tmp 0
scoreboard players add pidnext npc_tmp 0
scoreboard players set c100 npc_tmp 100
scoreboard players set c0 npc_tmp 0
scoreboard players set c1 npc_tmp 1
scoreboard players set c1024 npc_tmp 1024
execute unless score global npc_init matches 1.. run function npc:internal/init
function npc:internal/repair_markers
# older worlds: grow the island to 50x50 with the fence on the edge (init now builds it that way; flag 1..3 -> 4)
execute if score global npc_init matches 1..3 run function npc:internal/island_grow
# a world from the earlier generated version has entities but no storage entries: start the cast over (once;
# starters sets npc_seed, so a deliberate /trigger clear_all_npcs stays empty)
execute if score global npc_init matches 1.. unless score global npc_seed matches 1 unless data storage npc:main npcs[0] run kill @e[tag=npc]
execute if score global npc_init matches 1.. unless score global npc_seed matches 1 unless data storage npc:main npcs[0] run function npc:internal/starters
