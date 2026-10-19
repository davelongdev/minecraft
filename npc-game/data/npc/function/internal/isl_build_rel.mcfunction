# Positioned at the island centre (px 63 0). Pass 1: dirt + stone floor (grass next pass: a floor filled into never-lit
# void chunks stays black, see CLAUDE.md), fence ring. Skipped once done (stone present) or finished (bedrock marker).
execute if block ~ ~-2 ~ bedrock run return 0
execute if block ~ ~ ~ stone run return 0
fill ~-10 ~-1 ~-10 ~10 ~-1 ~10 dirt
fill ~-10 ~ ~-10 ~10 ~ ~10 stone
fill ~-10 ~1 ~-10 ~10 ~1 ~-10 oak_fence
fill ~-10 ~1 ~10 ~10 ~1 ~10 oak_fence
fill ~-10 ~1 ~-10 ~-10 ~1 ~10 oak_fence
fill ~10 ~1 ~-10 ~10 ~1 ~10 oak_fence
