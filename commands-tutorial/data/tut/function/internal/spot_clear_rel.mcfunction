# Positioned at the quest origin: empty the blue block (column above the glowstone) for a new quest.
fill ~12 ~ ~6 ~12 ~3 ~6 air
execute positioned ~12 ~ ~6 run kill @e[type=item,distance=..3]
