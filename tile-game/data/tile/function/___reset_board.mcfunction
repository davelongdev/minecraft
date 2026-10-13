# Back to nine plain floor tiles and build mode (plate and frame rebuilt): /function tile:___reset_board
scoreboard players set mode tile_tmp 0
function tile:internal/board_base
function tile:internal/board_floor
tellraw @s {"text":"Board reset: nine floor tiles.","color":"yellow"}
