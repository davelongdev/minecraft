# Go back one quest (also works after finishing everything).
execute if score @s tut_sec > maxsec tut_const run function tut:internal/back_from_done
execute unless score @s tut_sec > maxsec tut_const if score @s tut_sec matches 1 if score @s tut_ex matches ..0 run tellraw @s [{"font":"minecraft:uniform","text":"This is the first quest. There's nothing before it!","color":"red"}]
execute unless score @s tut_sec > maxsec tut_const if score @s tut_sec matches 1 if score @s tut_ex matches ..0 run return fail
function tut:internal/store_args
function tut:internal/leave_quest with storage tut:main args
execute unless score @s tut_sec > maxsec tut_const if score @s tut_ex matches 1.. run scoreboard players remove @s tut_ex 1
tellraw @s [{"font":"minecraft:uniform","text":"Moving to the previous quest.","color":"yellow"}]
function tut:___restart_exercise
