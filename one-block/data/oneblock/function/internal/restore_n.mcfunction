# Restores save point game-<n> (n already in storage oneblock:main), then does
# the same player/world reset as ___reset_game. Called from
# internal/restore_latest and ___restore_as, which set and validate n.
function oneblock:internal/do_restore with storage oneblock:main
kill @e[type=item]
clear @a
time set 37300
spawnpoint @a 0 65 0
function oneblock:___play
