# Shared by reset_player (teacher ___reset_player: + intro walk) and reset_press (island button: no intro).
# Back to quest 1: progress, inventory, island rebuilt, book, adventure mode. Keeps the player's id/plot.
function tut:internal/clear_chat
scoreboard players set @s tut_sec 1
scoreboard players set @s tut_ex 0
scoreboard players set @s tut_quests 0
scoreboard players set @s tut_pts 0
scoreboard players set @s tut_tick 0
scoreboard players set @s tut_lp 0
scoreboard players set @s tut_pp -1
scoreboard players set @s tut_last -1
scoreboard players set @s tut_end 0
scoreboard players set @s tut_cage 0
scoreboard players set @s tut_arm 0
scoreboard players set @s tut_book 0
clear @s
function tut:internal/store_args
function tut:internal/build_plot with storage tut:main args
function tut:internal/give_book
gamemode adventure @s
