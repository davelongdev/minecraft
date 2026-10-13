# Macro (id, name, job). Positioned where the character should stand: register it and spawn its three entities.
$execute if data storage npc:main npcs[{id:"$(id)"}] run return run tellraw @s {"text":"There is already a character called $(id). Pick another id, or ___delete it first.","color":"red"}
scoreboard players add next npc_tmp 1
execute store result storage npc:main new.num int 1 run scoreboard players get next npc_tmp
$data modify storage npc:main new.id set value "$(id)"
$data modify storage npc:main new.name set value "$(name)"
$data modify storage npc:main new.job set value "$(job)"
data modify storage npc:main new.greeting set value "Hello!"
summon marker ~ ~ ~ {Tags:["npc_pos"]}
data modify storage npc:main new.pos set from entity @e[type=marker,tag=npc_pos,limit=1] Pos
kill @e[type=marker,tag=npc_pos]
data modify storage npc:main new.x set from storage npc:main new.pos[0]
data modify storage npc:main new.y set from storage npc:main new.pos[1]
data modify storage npc:main new.z set from storage npc:main new.pos[2]
data modify storage npc:main npcs append value {}
data modify storage npc:main npcs[-1] set from storage npc:main new
function npc:internal/spawn_entities with storage npc:main new
$tellraw @s [{"text":"Created $(name) (id $(id)). Now give them something to say: ","color":"green"},{"text":"/function npc:___greeting {id:\"$(id)\",text:\"...\"}","color":"aqua"}]
