# Macro (px). One tick of the intro: keep the effects topped up, print the story
# on a schedule (tut_wx = ticks since start_intro), then hand over to state 3.
scoreboard players add @s tut_wx 1
effect give @s minecraft:blindness 5 0 true
effect give @s minecraft:darkness 5 0 true
effect give @s minecraft:slowness 5 6 true
$execute if score @s tut_wx matches 30 positioned $(px) 100 0 run tp @s ~-28.5 ~ ~6.5 -90 0
execute if score @s tut_wx matches 40 run function tut:internal/clear_chat
execute if score @s tut_wx matches 40 run tellraw @s [{"text":"Welcome to ","color":"white","font":"minecraft:uniform"},{"text":"Command Forge","color":"gold","bold":true,"font":"minecraft:uniform"},{"text":" !!!","color":"white","font":"minecraft:uniform"}]
execute if score @s tut_wx matches 80 run tellraw @s {"text":""}
execute if score @s tut_wx matches 80 run tellraw @s {"text":"Scientists have located a black hole in time and space that threatens to engulf the whole universe !!!","color":"red","font":"minecraft:uniform"}
execute if score @s tut_wx matches 180 run tellraw @s {"text":""}
execute if score @s tut_wx matches 180 run tellraw @s {"text":"To stop this, you must learn about commands !!!","color":"yellow","font":"minecraft:uniform"}
execute if score @s tut_wx matches 260 run tellraw @s {"text":""}
execute if score @s tut_wx matches 260 run tellraw @s {"text":"Follow the quests to become a great hero and save the universe from destruction !!!","color":"gold","font":"minecraft:uniform"}
execute if score @s tut_wx matches 360 run tellraw @s {"text":""}
execute if score @s tut_wx matches 360 run tellraw @s {"text":"Press the space bar to get started on your epic journey !!!","color":"green","bold":true,"font":"minecraft:uniform"}
execute if score @s tut_wx matches 360 run scoreboard players set @s tut_jump 0
execute if score @s tut_wx matches 360 run scoreboard players set @s tut_walk 3
