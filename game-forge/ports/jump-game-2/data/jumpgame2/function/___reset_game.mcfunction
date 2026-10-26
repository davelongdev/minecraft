# Reset everyone's jump count and cooldown: run with /function jumpgame2:___reset_game
scoreboard players set @a[distance=0..] jumps 0
scoreboard players set @a[distance=0..] jg2_cd 0
effect clear @a[distance=0..] minecraft:jump_boost
effect clear @a[distance=0..] minecraft:speed
effect clear @a[distance=0..] minecraft:slow_falling
execute as @a[distance=0..] run attribute @s minecraft:jump_strength modifier remove jumpgame2:jump_higher
tellraw @a[distance=0..] {"text":"Jump game reset.","color":"green"}
tellraw @a[distance=0..] {"text":"Jump 5 times for a boost (10s cooldown).","color":"green"}
