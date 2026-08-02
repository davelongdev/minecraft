# Reset everyone's jump count and cooldown: run with /function jumpgame2:___reset_game
scoreboard players set @a jumps 0
scoreboard players set @a jg2_cd 0
effect clear @a minecraft:jump_boost
effect clear @a minecraft:speed
effect clear @a minecraft:slow_falling
execute as @a run attribute @s minecraft:jump_strength modifier remove jumpgame2:jump_higher
tellraw @a {"text":"Jump game reset.","color":"green"}
tellraw @a {"text":"Jump 5 times for a boost (10s cooldown).","color":"green"}
