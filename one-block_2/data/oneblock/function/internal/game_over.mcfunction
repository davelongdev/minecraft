# Called as a player whose lives hit 0: out of the game until ___play.
scoreboard players set @s ob_lives 0
scoreboard players set @s ob_run 0
gamemode spectator @s
title @s times 10 70 20
title @s title {"text":"GAME OVER","color":"dark_red","bold":true}
title @s subtitle {"text":"Out of lives","color":"gray"}
tellraw @s {"text":"","color":"white"}
tellraw @s [{"text":"  [Play again]","color":"green","bold":true,"click_event":{"action":"run_command","command":"function oneblock:___play"}},{"text":"   "},{"text":"[Reset course + play]","color":"aqua","bold":true,"click_event":{"action":"run_command","command":"function oneblock:___reset_game"}}]
tellraw @a[gamemode=!spectator] [{"selector":"@s","color":"yellow"},{"text":" is out of lives!","color":"gray"}]
