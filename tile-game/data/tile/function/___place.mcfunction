# Place a tile at grid coords: /function tile:___place {name:"grass",x:1,z:0}   (x and z from -1 to 1)
$scoreboard players set px tile_tmp $(x)
$scoreboard players set pz tile_tmp $(z)
$data modify storage tile:main args.name set value "$(name)"
function tile:internal/check_bounds
function tile:internal/place
