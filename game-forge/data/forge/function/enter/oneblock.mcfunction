# One Block (copy of the one-block server, dimension forge:oneblock): the start block. Its join (next tick,
# adventure players with ob_joined 0) sets the spawn point and gives the shovel, keys, and 3 lives.
function forge:internal/reset_player
execute in forge:oneblock run tp @s 0.5 65 0.5 -90 0
gamemode adventure @s
scoreboard players set @s ob_joined 0
