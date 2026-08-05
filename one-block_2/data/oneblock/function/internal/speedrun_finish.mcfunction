# A runner got past the dirt wall (as the runner): stop the timer, announce
# the time, track their personal best. ob_ds/ob_dt are fresh from this tick's
# speedrun_hud call.
scoreboard players reset @s ob_run
tellraw @a [{"selector":"@s","color":"aqua"},{"text":" finished in "},{"score":{"name":"@s","objective":"ob_ds"}},{"text":"."},{"score":{"name":"@s","objective":"ob_dt"}},{"text":"s"}]
scoreboard players add @s ob_best 0
execute if score @s ob_best matches 1.. if score @s ob_timer < @s ob_best run tellraw @a {"text":"New personal best!","color":"gold"}
execute unless score @s ob_best matches 1.. run tellraw @s {"text":"First time recorded — that's your PB to beat.","color":"gold"}
execute unless score @s ob_best matches 1.. run scoreboard players operation @s ob_best = @s ob_timer
execute if score @s ob_timer < @s ob_best run scoreboard players operation @s ob_best = @s ob_timer
