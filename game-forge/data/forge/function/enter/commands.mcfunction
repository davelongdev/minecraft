# Commands = Command Forge section 1 (copy of the command-forge server, dimension forge:commands).
function forge:internal/reset_player
gamemode adventure @s
execute in forge:commands positioned 0 100 0 run function forge:enter/commands_in
