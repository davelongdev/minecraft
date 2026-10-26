# One-time cleanup (from load, flag hub_gone tut_const): remove the old hub pad and its sign at the world origin.
# Spawn chunks are always loaded, so this works from anywhere.
scoreboard players set hub_gone tut_const 1
fill -4 99 -4 4 100 4 air
