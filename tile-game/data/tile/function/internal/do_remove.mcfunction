# Macro (ox, oz, tx, tz): clear a tile to air.
$execute positioned $(ox) 64 $(oz) run fill ~ ~ ~ ~2 ~2 ~2 air
$execute positioned $(ox) 64 $(oz) run kill @e[type=item,distance=..4]
$tellraw @s {"text":"Removed tile ($(tx), $(tz)).","color":"yellow"}
