# Positioned at the quest origin: remove the PREVIOUS post (and an old NEXT post) (buttons and signs first: a log cleared under them drops them)
fill ~7 ~1 ~2 ~7 ~1 ~4 air
fill ~6 ~ ~2 ~6 ~ ~4 air
fill ~7 ~ ~2 ~7 ~ ~4 air
execute positioned ~7 ~ ~3 run kill @e[type=item,distance=..4]
