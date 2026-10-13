# Macro (id, job): villager look (farmer, librarian, cleric, armorer, butcher, cartographer, fisherman, fletcher,
# leatherworker, mason, nitwit, shepherd, toolsmith, weaponsmith, none)
$execute unless data storage npc:main npcs[{id:"$(id)"}] run return run tellraw @s {"text":"No character called $(id).","color":"red"}
$data modify storage npc:main npcs[{id:"$(id)"}].job set value "$(job)"
$data merge entity @e[type=villager,tag=npc_$(id),limit=1] {VillagerData:{profession:"minecraft:$(job)",level:1,type:"minecraft:plains"}}
$tellraw @s {"text":"$(id) now looks like a $(job).","color":"green"}
