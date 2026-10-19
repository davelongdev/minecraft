# Macro (id, n, label, cmd): button n (1..3) of a character; cmd runs as the player who presses it (no leading /).
$execute unless data storage npc:main npcs[{id:"$(id)"}] run return run tellraw @s {"text":"No character called $(id).","color":"red"}
$data modify storage npc:main npcs[{id:"$(id)"}].b$(n) set value {label:"$(label)",cmd:"$(cmd)"}
$execute unless score quiet npc_tmp matches 1 run tellraw @s {"text":"$(id) button $(n): [$(label)] -> $(cmd)","color":"green"}
