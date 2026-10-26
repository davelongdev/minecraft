# Runs as the player who reached 5 jumps with no active cooldown
scoreboard players set @s jumps 0
scoreboard players set @s jg2_cd 200
tellraw @s {"text":"5 jumps! Enjoy the boost — next one in 10s.","color":"gold"}
effect give @s minecraft:jump_boost 5 9 true
effect give @s minecraft:speed 5 5 true
# Slow falling outlasts the 5s buff so the long float down stays damage-free
effect give @s minecraft:slow_falling 10 0 true
# +18.3% jump strength = +40% jump height (height scales with velocity squared)
attribute @s minecraft:jump_strength modifier remove jumpgame2:jump_higher
attribute @s minecraft:jump_strength modifier add jumpgame2:jump_higher 0.1832 add_multiplied_total
playsound minecraft:entity.player.levelup master @s
