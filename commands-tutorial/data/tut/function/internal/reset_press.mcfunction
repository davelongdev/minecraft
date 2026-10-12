# RESET ALL QUESTS button (island 1, post at 1,2). First press arms a 5 s window (tut_arm counts down in
# player_tick); a second press inside it starts the player over at quest 1 on their island (no intro walk; reset_now).
execute if score @s tut_arm matches 1.. run return run function tut:internal/reset_now
scoreboard players set @s tut_arm 100
tellraw @s [{"font":"minecraft:uniform","text":"Reset all quests and start over? ","color":"red","bold":true},{"font":"minecraft:uniform","text":"Press the button again within 5 seconds to confirm.","color":"red"}]
