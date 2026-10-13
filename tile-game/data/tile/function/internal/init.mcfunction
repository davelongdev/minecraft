# One-time world setup. The board is 3x3 tiles; each tile is a 3x3x3 box. Tile (tx,tz), tx/tz in -1..1,
# occupies x 3tx-1..3tx+1, y 64..66, z 3tz-1..3tz+1, so the centre tile (0,0) is x/z -1..1 around the origin.
# A base plate at y 63 (build mode only) and a frame ring at y 63..64 mark the board; they are never part of a tile.
# Players stay in adventure mode so tiles only change as a whole, through the commands.
scoreboard players set global tile_init 1
# remove the vanilla "The Void" preset starting platform (33x33 stone at y -61)
fill -32 -64 -32 32 -60 32 air
fill -32 -59 -32 32 -55 32 air
function tile:internal/board_base
function tile:internal/board_floor
setworldspawn 0 65 0 0 0
spawnpoint @a 0 65 0
tp @a 0.5 65 0.5 0 0
time set 6000
gamerule advance_time false
gamerule respawn_radius 0
gamerule advance_weather false
defaultgamemode adventure
gamemode adventure @a
scoreboard players set mode tile_tmp 0
tellraw @a {"text":"Tile board loaded. /function tile:___help lists the commands.","color":"aqua"}
