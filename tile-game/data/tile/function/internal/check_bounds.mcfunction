# ok = 1 when px/pz are board coordinates (-1..1); also stores tx/tz and the tile's world origin (ox/oz = 3t-1).
scoreboard players set ok tile_tmp 0
execute if score px tile_tmp matches -1..1 if score pz tile_tmp matches -1..1 run scoreboard players set ok tile_tmp 1
execute unless score ok tile_tmp matches 1 run tellraw @s {"text":"That's not on the board. Tiles go from -1 to 1 in x and z.","color":"red"}
execute store result storage tile:main args.tx int 1 run scoreboard players get px tile_tmp
execute store result storage tile:main args.tz int 1 run scoreboard players get pz tile_tmp
scoreboard players operation ox tile_tmp = px tile_tmp
scoreboard players operation ox tile_tmp *= c3 tile_tmp
scoreboard players remove ox tile_tmp 1
scoreboard players operation oz tile_tmp = pz tile_tmp
scoreboard players operation oz tile_tmp *= c3 tile_tmp
scoreboard players remove oz tile_tmp 1
execute store result storage tile:main args.ox int 1 run scoreboard players get ox tile_tmp
execute store result storage tile:main args.oz int 1 run scoreboard players get oz tile_tmp
