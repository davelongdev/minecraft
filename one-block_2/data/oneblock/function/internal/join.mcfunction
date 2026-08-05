# One-time setup for a player who joined mid-game in adventure mode
scoreboard players set @s ob_joined 1
spawnpoint @s 0 65 0
clear @s minecraft:iron_shovel
give @s minecraft:iron_shovel[minecraft:can_break={blocks:"#minecraft:dirt"}]
tellraw @s {"text":"Welcome to the void. One block, one shovel.","color":"aqua"}
