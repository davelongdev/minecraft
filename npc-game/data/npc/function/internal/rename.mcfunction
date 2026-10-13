# Macro (id, name): new display name on the entry, the body, and the floating name
$execute unless data storage npc:main npcs[{id:"$(id)"}] run return run tellraw @s {"text":"No character called $(id).","color":"red"}
$data modify storage npc:main npcs[{id:"$(id)"}].name set value "$(name)"
$data merge entity @e[type=villager,tag=npc_$(id),limit=1] {CustomName:{text:"$(name)"}}
$data merge entity @e[type=text_display,tag=npc_$(id),limit=1] {text:{text:"$(name)",color:"gold",bold:true}}
$tellraw @s {"text":"$(id) is now called $(name).","color":"green"}
