# Runs as and at each joined player, every tick.
scoreboard players add @s tut_tick 1
# make sure 'matches 0' tests see a score (unset scores match nothing)
scoreboard players add @s tut_end 0
scoreboard players add @s tut_cage 0
scoreboard players add @s tut_arm 0
scoreboard players add @s tut_quests 0
# points (Leaderboard sidebar) = 1 per section 1 quest, 2 per section 2 quest, derived from the furthest quest reached
# every tick, so redoing a quest adds nothing and players from before points existed get theirs
scoreboard players operation @s tut_pts = @s tut_quests
execute if score @s tut_quests > n1 tut_const run scoreboard players operation @s tut_pts -= n1 tut_const
execute if score @s tut_quests > n1 tut_const run scoreboard players operation @s tut_pts *= c2 tut_const
execute if score @s tut_quests > n1 tut_const run scoreboard players operation @s tut_pts += n1 tut_const
# RESET ALL QUESTS confirmation window (internal/reset_press)
execute if score @s tut_arm matches 1.. run scoreboard players remove @s tut_arm 1
function tut:internal/store_args

# islands are 1024·id apart (c128 tut_const); plots placed by the old 128 spacing get moved once
scoreboard players operation @s tut_tmp = @s tut_id
scoreboard players operation @s tut_tmp *= c128 tut_const
execute unless score @s tut_px = @s tut_tmp run function tut:internal/migrate_island with storage tut:main args

# plot chunks may not have been loaded when join ran: (re)build until the marker exists
function tut:internal/ensure_plot with storage tut:main args

# walking in from the end of the path: night turns to day
execute if score @s tut_walk matches 2 run function tut:internal/intro_tick with storage tut:main args
execute if score @s tut_walk matches 3 run function tut:internal/intro_wait with storage tut:main args
execute if score @s tut_walk matches 1 run function tut:internal/walk_in

# fell off the world
execute if entity @s[y=-200,dy=199] run function tut:internal/void_catch with storage tut:main args

# chat links and the book all go through /trigger tut_btn (1 = a quest's chat link was clicked)
execute if score @s tut_btn matches 1 run scoreboard players set @s tut_flag 1
execute if score @s tut_btn matches 3 run function tut:___start
execute if score @s tut_btn matches 4 if score @s tut_quests matches 2.. run function tut:internal/give_book
execute if score @s tut_btn matches 5 run function tut:___quest
execute if score @s tut_btn matches 6 run function tut:internal/try_complete with storage tut:main args

# tut_sneak counts consecutive ticks spent sneaking (0 when not), so "matches 1" is the
# tick shift was pressed: holding it pages once, not every tick
execute if predicate tut:sneaking run scoreboard players add @s tut_sneak 1
execute unless predicate tut:sneaking run scoreboard players set @s tut_sneak 0

# paced quest text keeps printing after the QUEST press: timed parts (tut_pm 0) advance
# every tick, shift-paced parts (tut_pm 1) advance on a shift press
execute if score @s tut_pp matches 0.. if score @s tut_lp matches 1.. if score @s tut_pm matches 0 run function tut:internal/print_tick
execute if score @s tut_pp matches 0.. if score @s tut_lp matches 1.. if score @s tut_pm matches 1 if score @s tut_sneak matches 1 run function tut:internal/print_tick

function tut:internal/buttons with storage tut:main args

execute if score @s tut_sec > maxsec tut_const run function tut:internal/all_done with storage tut:main args
execute unless score @s tut_sec > maxsec tut_const run function tut:internal/dispatch with storage tut:main args

# tut_jump is consumed here every tick, so intro_wait (above) sees a jump only on the tick it happened
# (the dev-mode space / shift+space reload shortcuts were removed 2026-10-16: space must stay free for flying)
scoreboard players set @s tut_jump 0

scoreboard players set @s tut_btn 0
scoreboard players enable @s tut_btn
