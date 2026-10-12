# a command block in the trap square that has run, with a pressure plate on top
execute unless block ~12 ~-1 ~9 command_block run return fail
execute unless block ~12 ~ ~9 #minecraft:pressure_plates run return fail
execute store result score @s tut_tmp run data get block ~12 ~-1 ~9 SuccessCount
execute if score @s tut_tmp matches 1.. run return 1
return fail
