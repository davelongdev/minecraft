# Macro: restores named save save-$(name), then the same player/world reset as
# ___reset_game. Only called (validated) from ___restore_named.
$place template oneblock:save-$(name) -4 55 -6
$tellraw @a {"text":"Restored save point $(name)","color":"aqua"}
kill @e[type=item]
clear @a
time set 37300
spawnpoint @a 0 65 0
function oneblock:___play
