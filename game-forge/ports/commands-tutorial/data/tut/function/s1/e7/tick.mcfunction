scoreboard players set @s tut_tmp 0
execute if entity @s[gamemode=survival] run scoreboard players set @s tut_tmp 1
execute if entity @s[gamemode=spectator] run scoreboard players set @s tut_tmp 2
execute if score @s tut_tmp matches 1 unless score @s tut_last matches 1 run tellraw @s {"font":"minecraft:uniform","text":"Survival? Brave! But I need creative. Try /gamemode creative","color":"red"}
execute if score @s tut_tmp matches 2 unless score @s tut_last matches 2 run tellraw @s {"font":"minecraft:uniform","text":"Boo! You're a ghost. Spectator is spooky. Try /gamemode creative","color":"red"}
scoreboard players operation @s tut_last = @s tut_tmp
