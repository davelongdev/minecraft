# Invisible wall (Dave 2026-10-26: no flying off the island or more than 20 up in creative): a barrier shell one block
# outside the island edge, from the floor to 20 above, with a roof. Creative can break barriers, so it's refilled every
# tick (keep only fills air: the walkway end and its lanterns stay). dispatch removes it on any other quest (wall_clear).
fill ~-1 ~-1 ~-1 ~-1 ~20 ~12 barrier keep
fill ~12 ~-1 ~-1 ~12 ~20 ~12 barrier keep
fill ~ ~-1 ~-1 ~11 ~20 ~-1 barrier keep
fill ~ ~-1 ~12 ~11 ~20 ~12 barrier keep
fill ~-1 ~21 ~-1 ~12 ~21 ~12 barrier keep
