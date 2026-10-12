# Rebuild this player's island and replay the current quest, keeping progress (after TNT, griefing, etc.).
# Run as the player: /function tut:___fix_island
function tut:internal/store_args
# section 1: rebuild island 1 (floor, fences, sign, posts, banner, path), replay the quest, go home
execute if score @s tut_sec matches 1 run function tut:internal/build_plot with storage tut:main args
execute if score @s tut_sec matches 1 run function tut:___restart_exercise
execute if score @s tut_sec matches 1 run function tut:internal/go_home with storage tut:main args
# section 2 (and after): rebuild island 2, go there, replay the quest
execute if score @s tut_sec matches 2.. run function tut:internal/fix_island2 with storage tut:main args
execute if score @s tut_sec matches 2.. run function tut:___restart_exercise
tellraw @s {"font":"minecraft:uniform","text":"Island rebuilt! Press QUEST to read the quest again.","color":"aqua"}
