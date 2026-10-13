# Tile "tree": grass with a little oak
# Only runs from internal/do_place (which snaps to a slot); run by hand it just points at the right command.
execute unless score placing tile_tmp matches 1 run return run tellraw @s {"text":"Tiles only go on the board's slots: use /function tile:___place_here {name:\"tree\"} or ___tiles.","color":"red"}
fill ~ ~ ~ ~2 ~ ~2 grass_block
fill ~ ~2 ~ ~2 ~2 ~2 oak_leaves[persistent=true]
setblock ~1 ~1 ~1 oak_log
setblock ~1 ~2 ~1 oak_log
scoreboard players set ok tile_tmp 1
