$execute unless data storage npc:main npcs[{id:"$(id)"}] run return run tellraw @s {"text":"No character called $(id).","color":"red"}
$function npc:internal/owns {id:"$(id)"}
$execute unless score ok npc_tmp matches 1 run return run function npc:internal/not_yours {name:"$(id)"}
$kill @e[distance=0..,tag=npc_$(id)]
$data remove storage npc:main npcs[{id:"$(id)"}]
$tellraw @s {"text":"$(id) deleted.","color":"yellow"}
