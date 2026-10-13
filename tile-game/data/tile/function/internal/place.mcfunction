# Place tile args.name at args.tx/tz (after check_bounds). Unknown names leave ok at 0.
execute unless score ok tile_tmp matches 1 run return fail
scoreboard players set ok tile_tmp 0
function tile:internal/do_place with storage tile:main args
execute if score ok tile_tmp matches 1 run function tile:internal/msg_placed with storage tile:main args
execute unless score ok tile_tmp matches 1 run function tile:internal/msg_unknown with storage tile:main args
