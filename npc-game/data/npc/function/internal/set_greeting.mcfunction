# Macro (id, text)
$execute unless data storage npc:main npcs[{id:"$(id)"}] run return run tellraw @s {"text":"No character called $(id). /function npc:___list shows them.","color":"red"}
$data modify storage npc:main npcs[{id:"$(id)"}].greeting set value "$(text)"
$tellraw @s {"text":"$(id) now says: $(text)","color":"green"}
