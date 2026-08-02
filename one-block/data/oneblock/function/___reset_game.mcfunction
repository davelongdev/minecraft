# Reset the course for the next player: run with /function oneblock:___reset_game
# Re-plug the dirt wall (x 17..19, y 59-60, z -2..2); "keep" fills only air,
# so the embedded sign and any undug dirt are untouched. Update this region if
# the course changes.
fill 17 59 -2 19 60 2 minecraft:dirt keep
setblock 0 64 0 minecraft:sea_lantern keep
kill @e[type=item]
clear @a
time set 37300
spawnpoint @a 0 65 0
function oneblock:___play
