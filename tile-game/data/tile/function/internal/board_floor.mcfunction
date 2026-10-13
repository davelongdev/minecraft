# Every tile becomes a plain floor tile (same as placing "floor" on all nine).
fill -4 64 -4 4 66 4 air
fill -4 64 -4 4 64 4 smooth_stone
kill @e[type=item,distance=..20]
