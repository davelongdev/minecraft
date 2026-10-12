# While tut_walk is 1: keep the darkness effect going over the first part of
# the path (relative x -30..-1); past the halfway point it is no longer refreshed
# and fades out on its own as the player nears the island.
execute store result score @s tut_wx run data get entity @s Pos[0]
scoreboard players operation @s tut_wx -= @s tut_px
scoreboard players add @s tut_wx 30
execute if score @s tut_wx matches 30.. run function tut:internal/walk_done
execute if score @s tut_wx matches ..16 run effect give @s minecraft:darkness 2 0 true
