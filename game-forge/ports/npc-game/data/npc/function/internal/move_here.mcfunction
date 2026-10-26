# Macro (id): bring the character to the caller and make that its home spot
$execute unless data storage npc:main npcs[{id:"$(id)"}] run return run tellraw @s {"text":"No character called $(id).","color":"red"}
$tp @e[distance=0..,tag=npc_$(id)] @s
$data modify storage npc:main npcs[{id:"$(id)"}].pos set from entity @s Pos
$tellraw @s {"text":"$(id) moved here.","color":"green"}
