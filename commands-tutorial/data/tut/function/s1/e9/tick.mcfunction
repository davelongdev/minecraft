execute unless block ~9 ~0 ~9 gold_block run function tut:s1/e9/build
execute unless block ~9 ~3 ~9 glass run function tut:s1/e9/build
execute unless block ~8 ~1 ~9 glass run function tut:s1/e9/build
execute unless block ~7 ~0 ~10 dark_oak_sign run function tut:s1/e9/build
scoreboard players set @s tut_tmp 0
execute positioned ~9 ~4 ~9 if entity @s[dx=0,dy=2,dz=0] run scoreboard players set @s tut_tmp 1
execute positioned ~-40 ~-50 ~-40 unless entity @s[dx=91,dy=119,dz=91] run scoreboard players set @s tut_tmp 2
execute if score @s tut_tmp matches 1 unless score @s tut_last matches 1 run tellraw @s {"font":"minecraft:uniform","text":"So close! You're ON the cage. The middle number is how high. Try 101.","color":"red"}
execute if score @s tut_tmp matches 2 unless score @s tut_last matches 2 run tellraw @s [{"font":"minecraft:uniform","text":"Whoa, that's far! ","color":"red"},{"font":"minecraft:uniform","text":"[Bring me back]","color":"green","bold":true,"click_event":{"action":"run_command","command":"trigger tut_btn set 3"}}]
scoreboard players operation @s tut_last = @s tut_tmp
