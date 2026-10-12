# Runs as and at each joined player, every tick.
scoreboard players add @s tut_tick 1
function tut:internal/store_args

# plot chunks may not have been loaded when join ran: (re)build until the marker exists
function tut:internal/ensure_plot with storage tut:main args

# fell off the world
execute if entity @s[y=-200,dy=199] run function tut:internal/void_catch with storage tut:main args

# chat links and the book all go through /trigger tut_btn (1 = a quest's chat link was clicked)
execute if score @s tut_btn matches 1 run scoreboard players set @s tut_flag 1
execute if score @s tut_btn matches 3 run function tut:___start
execute if score @s tut_btn matches 4 run function tut:internal/give_book
execute if score @s tut_btn matches 5 run function tut:___quest

function tut:internal/buttons with storage tut:main args

execute if score @s tut_sec > maxsec tut_const run function tut:internal/all_done
execute unless score @s tut_sec > maxsec tut_const run function tut:internal/dispatch with storage tut:main args

scoreboard players set @s tut_btn 0
scoreboard players enable @s tut_btn
