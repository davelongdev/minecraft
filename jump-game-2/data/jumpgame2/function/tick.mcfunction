# Runs every game tick (20x per second)
scoreboard players add @a jg2_cd 0
execute as @a[scores={jg2_cd=1..}] run function jumpgame2:cooldown_tick
execute as @a[scores={jumps=5..,jg2_cd=..0}] run function jumpgame2:celebrate
