# As a player who just did something with a screen open (quest 1's [Done!] chat link, quest 3's book): set tut_flag 1
# and remember where they look and stand. internal/view_moved then says when that has changed, which can't happen
# while chat or the book is open (the mouse moves a cursor then), so "Great job!" waits until they've closed it
# (Dave 2026-10-26).
scoreboard players set @s tut_flag 1
execute store result score @s tut_ry run data get entity @s Rotation[0] 100
execute store result score @s tut_rp run data get entity @s Rotation[1] 100
execute store result score @s tut_rx run data get entity @s Pos[0] 10
execute store result score @s tut_rz run data get entity @s Pos[2] 10
