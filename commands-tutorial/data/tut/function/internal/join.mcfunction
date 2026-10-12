# First time a player is seen: give them an id, a plot, a book, and the intro.
scoreboard players set @s tut_joined 1
scoreboard players add global tut_id 1
scoreboard players operation @s tut_id = global tut_id
scoreboard players operation @s tut_px = @s tut_id
scoreboard players operation @s tut_px *= c128 tut_const
# (c128 is 1024 since 2026-10-12: islands must be out of render distance of each other)
scoreboard players set @s tut_sec 1
scoreboard players set @s tut_ex 0
scoreboard players set @s tut_quests 0
scoreboard players set @s tut_pts 0
scoreboard players set @s tut_tick 0
scoreboard players set @s tut_last -1
function tut:internal/store_args
function tut:internal/build_plot with storage tut:main args
function tut:internal/give_book
gamemode adventure @s
function tut:internal/start_intro
