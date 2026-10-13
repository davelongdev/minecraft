# Place a tile where you stand: /function tile:___place_here {name:"grass"}
$data modify storage tile:main args.name set value "$(name)"
function tile:internal/here
function tile:internal/place
