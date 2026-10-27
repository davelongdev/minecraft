# count here, not in tick: auto_check runs before the tick, and player_tick reuses tut_tmp in between
execute store result score @s tut_tmp run clear @s stick 0
execute if score @s tut_tmp matches 1.. run return 1
return fail
