# Jump Game (copy of the jump-game server, dimension forge:jump): its world spawn, in adventure (its server was survival).
function forge:internal/reset_player
execute in forge:jump run tp @s -47.5 63 -15.5 0 0
execute in forge:jump run spawnpoint @s -48 63 -16
gamemode adventure @s
