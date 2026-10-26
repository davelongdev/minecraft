# Positioned at the island origin. A sealed black_concrete room over the west end of the walkway (x -31..-27, z 4..8,
# y 0..2; interior x -30..-28, z 5..7, two high; the path floor stays). It exists ONLY during the arrival intro: intro_tick
# builds it around the player (every tick, so a rebuild can't remove it), intro_wait tears it down on the space bar
# (dark_room_clear_rel restores the fence and lanterns), and ensure_plot clears any leftover once the player is out of the
# intro. Inside: no sky, no lanterns, nothing to see whatever the brightness setting. (Dave 2026-10-18: the square must
# not be visible on the normal path.)
fill ~-31 ~ ~4 ~-27 ~2 ~8 black_concrete
fill ~-30 ~ ~5 ~-28 ~1 ~7 air
execute positioned ~-29 ~ ~6 run kill @e[type=item,distance=..6]
