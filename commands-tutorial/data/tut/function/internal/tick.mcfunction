scoreboard players add @a tut_joined 0
execute as @a[scores={tut_joined=..0}] run function tut:internal/join
execute as @a[scores={tut_joined=1}] at @s run function tut:internal/player_tick
