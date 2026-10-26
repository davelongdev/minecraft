# Back to the hub, between the NPC platforms: /trigger lobby or the Magic Compass.
function forge:internal/reset_player
execute in minecraft:overworld run tp @s 22.5 63 0.5 -90 0
execute in minecraft:overworld run spawnpoint @s 22 63 0
gamemode adventure @s
