# Positioned at island 2's origin: the section 2 build markers in the floor (re-placed after every floor recolour).
# In quest-origin terms (origin + 12 south): blue block (blue concrete) ~12 ~-1 ~6, red spot ~12 ~-1 ~9, target pad ~29..31 ~-1 ~5..7.
setblock ~12 ~-1 ~18 blue_concrete
setblock ~12 ~-1 ~21 red_concrete
fill ~29 ~-1 ~17 ~31 ~-1 ~19 gold_block
function tut:internal/target_sign with storage tut:main args
