# Every tick. Fallen players: in build mode they come back to the frame corner; in play mode they're out.
execute as @a[y=-200,dy=190,gamemode=!spectator] at @s unless score mode tile_tmp matches 1 run function tile:internal/fell_build
execute as @a[y=-200,dy=190,gamemode=!spectator] at @s if score mode tile_tmp matches 1 run function tile:internal/fell_play
function tile:internal/triggers
