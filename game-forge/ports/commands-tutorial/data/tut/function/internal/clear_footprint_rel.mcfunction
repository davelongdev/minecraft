# Positioned at an island origin: wipe everything a plot ever placed there (island, banner, walkway,
# quest-11 area east, legacy south platforms). Used when islands move (migrate_island) and by ___clear_legacy.
fill ~ ~-2 ~-11 ~35 ~20 ~11 air
fill ~ ~-2 ~12 ~35 ~20 ~35 air
fill ~-4 ~-2 ~12 ~-1 ~6 ~35 air
fill ~-31 ~-2 ~3 ~-1 ~3 ~9 air
execute positioned ~16 ~8 ~16 run kill @e[type=item,distance=..60]
