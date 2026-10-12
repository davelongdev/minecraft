# Runs on every load/reload; only calls init the first time.
# tile_tmp holds scratch values under fake player names:
#   tx/tz = tile coords, ox/oz = world origin of that tile, ok = macro success flag,
#   c9/cm9 = constants, k/r/lo/hi = grid loop state
scoreboard objectives add tile_init dummy
scoreboard objectives add tile_tmp dummy
scoreboard players set c9 tile_tmp 9
scoreboard players set cm9 tile_tmp -9
execute unless score global tile_init matches 1 run function tile:internal/init
