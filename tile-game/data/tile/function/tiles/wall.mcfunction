# Tile "wall": solid 3x3x3 stone-brick block
# Only runs from internal/do_place (which snaps to a slot); run by hand it just points at the right command.
execute unless score placing tile_tmp matches 1 run return run tellraw @s {"text":"Tiles only go on the board's slots: use /function tile:___place_here {name:\"wall\"} or ___tiles.","color":"red"}
fill ~ ~ ~ ~2 ~2 ~2 stone_bricks
scoreboard players set ok tile_tmp 1
