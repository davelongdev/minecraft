# Start a speedrun: run with /function oneblock:___start_speedrun
# Teleports you to the start and times you until you get past the dirt wall
# (x >= 20). The elapsed time shows on your actionbar; finishing announces
# your time and tracks your personal best. Restore or reset the course first
# if it's already dug through. Cancel with ___stop_speedrun.
scoreboard players set @s ob_run 1
scoreboard players set @s ob_timer 0
tp @s 0.5 65 0.5 -90 0
tellraw @s {"text":"GO! Dig east and get past the wall.","color":"aqua"}
