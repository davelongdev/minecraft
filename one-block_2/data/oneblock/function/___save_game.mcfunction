# Save the current course as a new save point: run with /function oneblock:___save_game
# Each save gets a fresh number (game-1, game-2, ...) so an accidental save
# can't overwrite an older one. Snapshots the course region (x -4..26,
# y 55..70, z -6..6) into the world save at generated/oneblock/structures/
# game-<n>.nbt. Restore the newest with ___restore_from_save, or any older one
# manually: /place template oneblock:game-<n> -4 55 -6
scoreboard players add global ob_saves 1
execute store result storage oneblock:main n int 1 run scoreboard players get global ob_saves
function oneblock:internal/do_save with storage oneblock:main
