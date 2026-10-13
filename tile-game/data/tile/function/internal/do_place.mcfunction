# Macro (name, ox, oz): empty the tile box, then build the tile. Tile functions set ok = 1 and only run while
# the placing flag is up (so running tile:tiles/<name> by hand can't build off-grid).
# Anyone standing in the slot is lifted onto the top of the new tile first, so a wall or tree can't trap them.
$execute positioned $(ox) 64 $(oz) run tp @a[dx=2,dy=2,dz=2] ~1.5 ~3 ~1.5
$execute positioned $(ox) 64 $(oz) run fill ~ ~ ~ ~2 ~2 ~2 air
$execute positioned $(ox) 64 $(oz) run kill @e[type=item,distance=..4]
scoreboard players set placing tile_tmp 1
$execute positioned $(ox) 64 $(oz) run function tile:tiles/$(name)
scoreboard players set placing tile_tmp 0
