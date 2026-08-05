# A runner got past the dirt wall (as the runner): stop the timer, announce
# the time, update their personal best, announce a top-5 spot when their best
# improved, then show the leaderboard. ob_ds/ob_dt are fresh from this tick's
# speedrun_hud call. pb/cur/myrank are fake players in ob_work.
scoreboard players reset @s ob_run
tellraw @a [{"selector":"@s","color":"aqua"},{"text":" finished in "},{"score":{"name":"@s","objective":"ob_ds"}},{"text":"."},{"score":{"name":"@s","objective":"ob_dt"}},{"text":"s"}]
scoreboard players add @s ob_best 0
scoreboard players set pb ob_work 0
execute unless score @s ob_best matches 1.. run scoreboard players set pb ob_work 1
execute if score @s ob_best matches 1.. if score @s ob_timer < @s ob_best run scoreboard players set pb ob_work 1
execute if score @s ob_best matches 1.. if score @s ob_timer < @s ob_best run tellraw @a {"text":"New personal best!","color":"gold"}
execute if score pb ob_work matches 1 run scoreboard players operation @s ob_best = @s ob_timer
# their spot = 1 + players with a strictly better best
scoreboard players operation cur ob_work = @s ob_best
scoreboard players set myrank ob_work 1
execute as @a[scores={ob_best=1..}] if score @s ob_best < cur ob_work run scoreboard players add myrank ob_work 1
execute if score pb ob_work matches 1 if score myrank ob_work matches ..5 run tellraw @a [{"selector":"@s","color":"gold"},{"text":" takes spot #"},{"score":{"name":"myrank","objective":"ob_work"}},{"text":" on the leaderboard!"}]
function oneblock:___top_times
