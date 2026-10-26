# After ___goto / ___goto_quest set tut_sec/tut_ex: clamp, fix the island state, replay the quest, report.
execute unless score @s tut_sec matches 1.. run scoreboard players set @s tut_sec 1
execute if score @s tut_sec > maxsec tut_const run scoreboard players operation @s tut_sec = maxsec tut_const
execute unless score @s tut_ex matches 0.. run scoreboard players set @s tut_ex 0
function tut:internal/store_args
function tut:internal/goto_clamp with storage tut:main args
# section 1 again after finishing: bring the quest posts back (unfinish_rel also zeroes tut_end/tut_cage)
execute if score @s tut_sec matches 1 if score @s tut_end matches 1.. run function tut:internal/unfinish with storage tut:main args
# section 2 lives on island 2 (tut_end 2 = ensure_plot keeps island 2 built while the player is there)
execute if score @s tut_sec matches 2.. run scoreboard players set @s tut_end 2
function tut:___start
tellraw @s [{"font":"minecraft:uniform","text":"Jumped to section ","color":"gray"},{"font":"minecraft:uniform","score":{"name":"@s","objective":"tut_sec"}},{"font":"minecraft:uniform","text":", quest "},{"font":"minecraft:uniform","score":{"name":"@s","objective":"tut_ex"}},{"font":"minecraft:uniform","text":" (0-based)."}]
