# Reset the course for the next player: run with /function oneblock:___reset_game
# internal/restore_course rebuilds every block of the course (platforms, dirt
# wall, torches, start block, win sign) from its generated snapshot.
function oneblock:internal/restore_course
kill @e[distance=0..,type=item]
clear @a[distance=0..]
time set 37300
spawnpoint @a[distance=0..] 0 65 0
function oneblock:___play
