# PvP Arena (copy of the pvp-arena server, dimension forge:arena): the stands, where its world spawn was.
function forge:internal/reset_player
execute in forge:arena run tp @s 0.5 80 33.5 180 0
execute in forge:arena run spawnpoint @s 0 80 33
gamemode adventure @s
