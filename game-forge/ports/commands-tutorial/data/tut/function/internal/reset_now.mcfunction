# Confirmed RESET ALL QUESTS button press: fresh start without the intro walk, straight onto the island.
function tut:internal/reset_core
effect clear @s
scoreboard players set @s tut_walk 0
function tut:internal/go_home with storage tut:main args
tellraw @s {"font":"minecraft:uniform","text":"Fresh start! Back to quest 1. Press QUEST to begin.","color":"aqua"}
