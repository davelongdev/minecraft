# Runs as the player who reached 10 jumps
scoreboard players set @s jumps 0
tellraw @s {"text":"10 jumps! Enjoy the boost.","color":"gold"}
effect give @s minecraft:jump_boost 10 4 true
effect give @s minecraft:speed 10 2 true
playsound minecraft:entity.player.levelup master @s
