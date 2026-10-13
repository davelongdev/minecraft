# Macro (id, on): 1 = strolls around, 0 = stays put
$execute unless data storage npc:main npcs[{id:"$(id)"}] run return run tellraw @s {"text":"No character called $(id).","color":"red"}
$execute if score c$(on) npc_tmp matches 1 run data merge entity @e[type=villager,tag=npc_$(id),limit=1] {NoAI:0b}
$execute if score c$(on) npc_tmp matches 0 run data merge entity @e[type=villager,tag=npc_$(id),limit=1] {NoAI:1b}
$tellraw @s {"text":"$(id) wander: $(on)","color":"green"}
