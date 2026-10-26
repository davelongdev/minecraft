# Replay the current exercise from the top and go back to your island.
scoreboard players set @s tut_tick 0
scoreboard players set @s tut_lp 0
scoreboard players set @s tut_pp -1
scoreboard players set @s tut_last -1
function tut:internal/store_args
function tut:internal/go_home with storage tut:main args
