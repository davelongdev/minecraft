# Locked chest + key door, (re)placed by ___play so every reset refills the
# chest and re-locks the door. Coordinates come from the course layout in
# internal/restore_course (corridor x 10..16, dirt wall x 17..19).

# Locked chest on the corridor floor against the north wall; only opens while
# holding the Rusty Key (lock matches the key's custom_data).
setblock 14 59 -1 minecraft:air
setblock 14 59 -1 minecraft:chest[facing=south]{lock:{items:"minecraft:trial_key",components:{"minecraft:custom_data":{oneblock_key:"rusty"}}},Items:[{Slot:12b,id:"minecraft:golden_apple",count:2},{Slot:14b,id:"minecraft:cookie",count:5}]}

# Iron door set into the dirt wall at z 0, passage carved behind it (the win
# sign at 19 59 0 is walk-through). No key? Dig through the dirt as usual.
setblock 18 59 0 minecraft:air
setblock 18 60 0 minecraft:air
setblock 19 60 0 minecraft:air
setblock 17 60 0 minecraft:air
setblock 17 59 0 minecraft:iron_door[facing=west,half=lower]
setblock 17 60 0 minecraft:iron_door[facing=west,half=upper]
