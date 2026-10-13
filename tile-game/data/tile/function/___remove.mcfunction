# Clear a tile to air: /function tile:___remove {x:1,z:0}
$scoreboard players set px tile_tmp $(x)
$scoreboard players set pz tile_tmp $(z)
function tile:internal/check_bounds
execute if score ok tile_tmp matches 1 run function tile:internal/do_remove with storage tile:main args
