# Cancel your speedrun: run with /function oneblock:___stop_speedrun
# Stops the timer without recording a time.
scoreboard players reset @s ob_run
tellraw @s {"text":"Speedrun cancelled.","color":"yellow"}
