# Teacher: jump to an exercise. Run as the kid: /execute as Name run function tut:___goto {sec:1,ex:3}
function tut:internal/store_args
function tut:internal/leave_quest with storage tut:main args
$scoreboard players set @s tut_sec $(sec)
$scoreboard players set @s tut_ex $(ex)
execute unless score @s tut_sec matches 1.. run scoreboard players set @s tut_sec 1
execute if score @s tut_sec > maxsec tut_const run scoreboard players operation @s tut_sec = maxsec tut_const
execute unless score @s tut_ex matches 0.. run scoreboard players set @s tut_ex 0
execute if score @s tut_ex > s1 tut_const run scoreboard players operation @s tut_ex = s1 tut_const
function tut:___start
tellraw @s [{"font":"minecraft:uniform","text":"Jumped to section ","color":"gray"},{"font":"minecraft:uniform","score":{"name":"@s","objective":"tut_sec"}},{"font":"minecraft:uniform","text":", exercise "},{"font":"minecraft:uniform","score":{"name":"@s","objective":"tut_ex"}}]
