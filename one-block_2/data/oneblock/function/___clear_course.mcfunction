# Wipe the course back to the original one-block start: run with /function oneblock:___clear_course
# Clears the whole course region to air, leaving just the sea lantern at 0 64 0.
# The region matches the snapshot bounds internal/restore_course was generated
# from; run /function oneblock:internal/restore_course to bring the course back.
fill -4 55 -6 26 70 6 minecraft:air
setblock 0 64 0 minecraft:sea_lantern
kill @e[type=item]
spawnpoint @a 0 65 0
tp @a 0.5 65 0.5 -90 0
tellraw @a {"text":"Course cleared — back to one block.","color":"aqua"}
