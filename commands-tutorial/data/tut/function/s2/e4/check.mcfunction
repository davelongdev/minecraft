# an impulse command block on the blue block whose command starts with "random" and that has run
execute unless block ~12 ~ ~6 command_block run return fail
data remove storage tut:main chk
data modify storage tut:main chk.c set string block ~12 ~ ~6 Command 0 6
execute unless data storage tut:main {chk:{c:"random"}} run return fail
execute store result score @s tut_tmp run data get block ~12 ~ ~6 SuccessCount
execute if score @s tut_tmp matches 1.. run return 1
return fail
