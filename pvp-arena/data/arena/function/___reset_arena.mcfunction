# Teacher reset: everyone to the stands, kills back to zero, stadium and pads rebuilt.
execute as @a[tag=arena_fighter] run function arena:internal/to_stands
scoreboard players reset * arena_kills
function arena:internal/pads_stop
kill @e[type=arrow]
kill @e[type=item]
scoreboard players set built arena_tmp 0
tellraw @a {"text":"The arena has been reset.","color":"gold"}
