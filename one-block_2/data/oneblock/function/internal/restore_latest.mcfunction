# Restores the newest game-<n> save point, then does the same player/world
# reset as ___reset_game. Only called (guarded) from ___restore_from_save.
execute store result storage oneblock:main n int 1 run scoreboard players get global ob_saves
function oneblock:internal/do_restore with storage oneblock:main
kill @e[type=item]
clear @a
time set 37300
spawnpoint @a 0 65 0
function oneblock:___play
