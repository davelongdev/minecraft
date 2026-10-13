# Play mode: the base plate disappears, so a removed tile is a hole into the void. /function tile:___play
scoreboard players set mode tile_tmp 1
fill -4 63 -4 4 63 4 air
gamemode adventure @a
tellraw @a {"text":"Play mode! The base plate is gone - don't fall. /function tile:___build brings it back.","color":"gold","bold":true}
