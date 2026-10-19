# As an island-button marker at its button: remove the sign first (a wall sign pops off as an item when its post goes),
# then the button, then the stone post; sweep any dropped item just in case.
execute if block ~-1 ~-1 ~ oak_wall_sign run setblock ~-1 ~-1 ~ air
setblock ~ ~ ~ air
execute if block ~ ~-1 ~ stone run setblock ~ ~-1 ~ air
kill @e[type=item,distance=..3]
kill @s
