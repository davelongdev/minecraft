# Clear the tile you stand in: /function tile:___remove_here  (you will drop to the base plate)
function tile:internal/here
execute if score ok tile_tmp matches 1 run function tile:internal/do_remove with storage tile:main args
