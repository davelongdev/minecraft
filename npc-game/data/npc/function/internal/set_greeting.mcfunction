# Macro (id, text)
$execute unless data storage npc:main npcs[{id:"$(id)"}] run return run tellraw @s {"text":"No character called $(id).","color":"red"}
$data modify storage npc:main npcs[{id:"$(id)"}].greeting set value "$(text)"
$execute unless score quiet npc_tmp matches 1 run tellraw @s {"text":"$(id) now says: $(text)","color":"green"}
