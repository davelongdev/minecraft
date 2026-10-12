scoreboard players add rank tut_const 1
execute if score rank tut_const matches 1 run team join tut_gold @s
execute if score rank tut_const matches 2 run team join tut_silver @s
execute if score rank tut_const matches 3 run team join tut_bronze @s
tag @s add tut_ranked
tag @a remove tut_pick
