# Macro: places saved structure oneblock:game-$(n) back over the course region.
# Called from internal/restore_latest with storage oneblock:main {n:<number>}.
$place template oneblock:game-$(n) -4 55 -6
$tellraw @a {"text":"Restored save point game-$(n)","color":"aqua"}
