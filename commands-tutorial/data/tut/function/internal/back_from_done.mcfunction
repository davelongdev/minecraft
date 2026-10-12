# Macro (ms = maxsec). ___previous after everything is finished: back onto the last quest (and nothing further).
scoreboard players operation @s tut_sec = maxsec tut_const
$scoreboard players operation @s tut_ex = s$(ms) tut_const
tellraw @s [{"font":"minecraft:uniform","text":"Moving to the previous quest.","color":"yellow"}]
function tut:___restart_exercise
