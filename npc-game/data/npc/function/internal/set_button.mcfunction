# Macro (id, n, label, cmd): button n (1..3) of a character; cmd runs as the player who presses it (no leading /).
$execute unless data storage npc:main npcs[{id:"$(id)"}] run return run tellraw @s {"text":"No character called $(id). /function npc:___list shows them.","color":"red"}
$data modify storage npc:main npcs[{id:"$(id)"}].b$(n) set value {label:"$(label)",cmd:"$(cmd)"}
$tellraw @s {"text":"$(id) button $(n): [$(label)] -> $(cmd)","color":"green"}
