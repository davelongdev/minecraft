$execute unless data storage npc:main npcs[{id:"$(id)"}] run return run tellraw @s {"text":"No character called $(id).","color":"red"}
$kill @e[tag=npc_$(id)]
$data remove storage npc:main npcs[{id:"$(id)"}]
$tellraw @s {"text":"$(id) deleted.","color":"yellow"}
