# Positioned at the island origin: remove the welcome/quest sign, the three posts, and the finish post.
# Signs and buttons first (clearing a log under them drops them as items), then logs, then sweep items.
setblock ~7 ~ ~6 air
fill ~7 ~1 ~2 ~7 ~1 ~8 air
fill ~6 ~ ~2 ~6 ~ ~8 air
fill ~7 ~ ~2 ~7 ~ ~8 air
execute positioned ~7 ~ ~5 run kill @e[type=item,distance=..6]
