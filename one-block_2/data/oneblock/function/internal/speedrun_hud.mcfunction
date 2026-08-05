# Actionbar timer for a running speedrun (as the runner): ob_timer ticks
# rendered as seconds.tenths via ob_ds / ob_dt. c20/c2 constants from load.
scoreboard players operation @s ob_ds = @s ob_timer
scoreboard players operation @s ob_ds /= c20 ob_timer
scoreboard players operation @s ob_dt = @s ob_timer
scoreboard players operation @s ob_dt %= c20 ob_timer
scoreboard players operation @s ob_dt /= c2 ob_timer
title @s actionbar [{"text":"","color":"aqua"},{"score":{"name":"@s","objective":"ob_ds"}},{"text":"."},{"score":{"name":"@s","objective":"ob_dt"}},{"text":"s"}]
