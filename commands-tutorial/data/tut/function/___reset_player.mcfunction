# Run as a player: back to the very start, plot rebuilt, inventory cleared. Keeps their id/plot.
execute if score @s tut_joined matches 1 run function tut:internal/reset_player
execute unless score @s tut_joined matches 1 run tellraw @s {"font":"minecraft:uniform","text":"That player hasn't joined the course yet.","color":"red"}
