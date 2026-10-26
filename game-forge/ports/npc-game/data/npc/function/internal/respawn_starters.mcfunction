# /trigger refresh_starter_npcs: Bob and Mira again, fresh (existing copies are replaced).
execute if data storage npc:main npcs[{id:"bob"}] run kill @e[distance=0..,tag=npc_bob]
data remove storage npc:main npcs[{id:"bob"}]
execute if data storage npc:main npcs[{id:"mira"}] run kill @e[distance=0..,tag=npc_mira]
data remove storage npc:main npcs[{id:"mira"}]
function npc:internal/starters
tellraw @s {"text":"Starter NPCs Bob the Baker and Mira the Guide have spawned.","color":"green"}
