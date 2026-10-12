# Runs as and at each joined player, every tick.
scoreboard players add @s tut_tick 1
function tut:internal/store_args

# plot chunks may not have been loaded when join ran: (re)build until the marker exists
function tut:internal/ensure_plot with storage tut:main args

# walking in from the end of the path: night turns to day
execute if score @s tut_walk matches 2 run function tut:internal/intro_tick with storage tut:main args
execute if score @s tut_walk matches 3 run function tut:internal/intro_wait
execute if score @s tut_walk matches 1 run function tut:internal/walk_in

# fell off the world
execute if entity @s[y=-200,dy=199] run function tut:internal/void_catch with storage tut:main args

# chat links and the book all go through /trigger tut_btn (1 = a quest's chat link was clicked)
execute if score @s tut_btn matches 1 run scoreboard players set @s tut_flag 1
execute if score @s tut_btn matches 3 run function tut:___start
execute if score @s tut_btn matches 4 run function tut:internal/give_book
execute if score @s tut_btn matches 5 run function tut:___quest

# paced quest text keeps printing after the QUEST press: timed parts (tut_pm 0) advance
# every tick, space-paced parts (tut_pm 1) advance on a jump, which is consumed here
execute if score @s tut_pp matches 0.. if score @s tut_lp matches 1.. if score @s tut_pm matches 0 run function tut:internal/print_tick
execute if score @s tut_pp matches 0.. if score @s tut_lp matches 1.. if score @s tut_pm matches 1 if score @s tut_jump matches 1.. run function tut:internal/print_tick
execute if score @s tut_pp matches 0.. if score @s tut_lp matches 1.. if score @s tut_pm matches 1 run scoreboard players set @s tut_jump 0

function tut:internal/buttons with storage tut:main args

execute if score @s tut_sec > maxsec tut_const run function tut:internal/all_done
execute unless score @s tut_sec > maxsec tut_const run function tut:internal/dispatch with storage tut:main args

# dev mode (___dev): shift + space = ___rr (reload + reset player, back to quest 1 and the intro),
# anywhere; space on the island = ___rq (reload + restart quest). tut_jump is consumed here
# every tick, so intro_wait (above) sees a jump only on the tick it happened
execute if score dev tut_const matches 1 if score @s tut_jump matches 1.. if predicate tut:sneaking run function tut:___rr
execute if score dev tut_const matches 1 if score @s tut_walk matches 0 if score @s tut_jump matches 1.. unless predicate tut:sneaking run function tut:___rq
scoreboard players set @s tut_jump 0

scoreboard players set @s tut_btn 0
scoreboard players enable @s tut_btn
