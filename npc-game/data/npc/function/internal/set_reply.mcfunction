# Macro (id, n, label, text): button n makes the character say a line (replaces any command on that button).
$execute unless data storage npc:main npcs[{id:"$(id)"}] run return run tellraw @s {"text":"No character called $(id). /function npc:___list shows them.","color":"red"}
$data modify storage npc:main npcs[{id:"$(id)"}].b$(n) set value {label:"$(label)",say:"$(text)"}
$tellraw @s {"text":"$(id) button $(n): [$(label)] -> says: $(text)","color":"green"}
