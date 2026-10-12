# One-time world setup. Tiles are 9x9x9 boxes: tile (tx,tz) occupies
# x 9tx..9tx+8, y 64..72, z 9tz..9tz+8. The grid floor (___grid) sits at y 63,
# just under the tiles, so it is never saved into or removed with a tile.
scoreboard players set global tile_init 1
# Remove the vanilla "The Void" preset starting platform (33x33 stone at y -61)
fill -32 -64 -32 32 -60 32 minecraft:air
fill -32 -59 -32 32 -55 32 minecraft:air
# A plain floor on tile (0,0) so there is somewhere to stand
fill 0 64 0 8 64 8 minecraft:stone
setworldspawn 4 65 4 0 0
spawnpoint @a 4 65 4
tp @a 4.5 65 4.5 0 0
time set 6000
gamerule advance_time false
gamerule respawn_radius 0
defaultgamemode creative
gamemode creative @a
# Scratch tile (-100,-100) = x/z -900..-892, kept loaded so starter tiles can be
# built and saved there without a player nearby
forceload add -900 -900 -892 -892
schedule function tile:internal/starters 40t
tellraw @a {"text":"Tile editor loaded. /function tile:___help lists the commands.","color":"aqua"}
