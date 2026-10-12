# Arrival sequence, run as the player right after their island is (re)built.
# tut_walk states: 2 = intro (pitch black, story lines in chat, pinned in place),
# 3 = waiting for the space bar, 1 = walking in (darkness fades), 0 = done.
# Effects go on first; intro_tick moves the player to the end of the path
# 30 ticks later, once the fog has fully closed in.
effect give @s minecraft:blindness 20 0 true
effect give @s minecraft:darkness 20 0 true
effect give @s minecraft:slowness 20 6 true
scoreboard players set @s tut_walk 2
scoreboard players set @s tut_wx 0
