# Positioned at the island origin. A 30-block walkway west of the island (x -30..-1), 3 wide
# (z 5..7) with fence rails and lanterns on z 4 and z 8. New players arrive at its far end
# facing east and walk toward the island and the COMMAND FORGE banner behind it.
# Floor goes in as stone; ensure_plot swaps it to stone_bricks next tick (light update).
# lanterns first: clearing the fence under a lantern makes it drop as an item
fill ~-30 ~1 ~4 ~-1 ~1 ~4 air
fill ~-30 ~1 ~8 ~-1 ~1 ~8 air
fill ~-31 ~-2 ~3 ~-1 ~20 ~9 air
# sweep anything that still dropped
execute positioned ~-15 ~ ~6 run kill @e[type=item,distance=..25]
fill ~-30 ~-1 ~4 ~-1 ~-1 ~8 stone
setblock ~-29 ~-2 ~6 bedrock
fill ~-30 ~ ~4 ~-1 ~ ~4 oak_fence
fill ~-30 ~ ~8 ~-1 ~ ~8 oak_fence
# fence across the back of the path
fill ~-30 ~ ~4 ~-30 ~ ~8 oak_fence
# lanterns on every sixth post
setblock ~-30 ~1 ~4 lantern
setblock ~-30 ~1 ~8 lantern
setblock ~-24 ~1 ~4 lantern
setblock ~-24 ~1 ~8 lantern
setblock ~-18 ~1 ~4 lantern
setblock ~-18 ~1 ~8 lantern
setblock ~-12 ~1 ~4 lantern
setblock ~-12 ~1 ~8 lantern
setblock ~-6 ~1 ~4 lantern
setblock ~-6 ~1 ~8 lantern
# gap in the island's west fence where the path meets it
fill ~ ~ ~5 ~ ~ ~7 air
