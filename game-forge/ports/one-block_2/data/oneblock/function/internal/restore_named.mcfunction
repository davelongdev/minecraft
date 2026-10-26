# Macro: restores named save save-$(name), then the same player/world reset as
# ___reset_game. Only called (validated) from ___restore_named.
$place template oneblock:save-$(name) -4 55 -6
$tellraw @a[distance=0..] {"text":"Restored save point $(name)","color":"aqua"}
kill @e[distance=0..,type=item]
clear @a[distance=0..]
time set 37300
spawnpoint @a[distance=0..] 0 65 0
function oneblock:___play
