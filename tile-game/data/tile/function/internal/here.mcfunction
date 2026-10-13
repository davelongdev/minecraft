# Which tile is @s standing in? -> px/pz tile_tmp (tile coords), ok = 1 if that is on the board.
# tile = floor((block coordinate + 1) / 3); scoreboard /= rounds down, which is what we want for negatives.
execute store result score px tile_tmp run data get entity @s Pos[0]
execute store result score pz tile_tmp run data get entity @s Pos[2]
scoreboard players add px tile_tmp 1
scoreboard players add pz tile_tmp 1
scoreboard players operation px tile_tmp /= c3 tile_tmp
scoreboard players operation pz tile_tmp /= c3 tile_tmp
function tile:internal/check_bounds
