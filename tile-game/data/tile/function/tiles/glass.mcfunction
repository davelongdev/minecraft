# Tile "glass": see-through glass floor
# Only runs from internal/do_place (which snaps to a slot); run by hand it just points at the right command.
execute unless score placing tile_tmp matches 1 run return run tellraw @s {"text":"Tiles only go on the board's slots: use /function tile:___place_here {name:\"glass\"} or ___tiles.","color":"red"}
fill ~ ~ ~ ~2 ~ ~2 glass
scoreboard players set ok tile_tmp 1
