# Build mode: the base plate is back under the tiles, everyone is in adventure mode (tiles change only through
# the commands, never by hand), and anyone in spectator comes back onto the frame. /function tile:___build
scoreboard players set mode tile_tmp 0
function tile:internal/plate
execute as @a[gamemode=spectator] run tp @s -4.5 65 -4.5 -45 0
gamemode adventure @a
tellraw @a {"text":"Build mode. Place and remove tiles with the commands (/function tile:___help).","color":"aqua"}
