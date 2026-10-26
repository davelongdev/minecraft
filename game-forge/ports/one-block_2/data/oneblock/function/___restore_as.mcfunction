# Restore a specific save point: run with /function oneblock:___restore_as {n:2}
# where the number is from the "Save point created: game-<n>" chat message.
# Validates the number against the save counter, then restores game-<n> and
# resets items/time/spawn like ___restore_from_save.
scoreboard players reset arg ob_saves
$scoreboard players set arg ob_saves $(n)
execute unless score arg ob_saves matches 1.. run tellraw @s {"text":"That isn't a valid save number — try e.g. /function oneblock:___restore_as {n:1}","color":"yellow"}
execute if score arg ob_saves > global ob_saves run tellraw @s [{"text":"No such save point yet — the latest is game-","color":"yellow"},{"score":{"name":"global","objective":"ob_saves"},"color":"yellow"}]
execute if score arg ob_saves matches 1.. unless score arg ob_saves > global ob_saves store result storage oneblock:main n int 1 run scoreboard players get arg ob_saves
execute if score arg ob_saves matches 1.. unless score arg ob_saves > global ob_saves run function oneblock:internal/restore_n
