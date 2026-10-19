# Macro (id, name, job). Positioned where the character should stand: register it and spawn its three entities.
$execute if data storage npc:main npcs[{id:"$(id)"}] run return run tellraw @s {"text":"There is already a character called $(id). Pick another id.","color":"red"}
scoreboard players add next npc_tmp 1
execute store result storage npc:main new.num int 1 run scoreboard players get next npc_tmp
$data modify storage npc:main new.id set value "$(id)"
$data modify storage npc:main new.name set value "$(name)"
$data modify storage npc:main new.job set value "$(job)"
data modify storage npc:main new.greeting set value "Hello!"
# owner = the maker's npc_pid; stays 0 when there is no player (starters seeded by load/init)
data modify storage npc:main new.owner set value 0
execute store result storage npc:main new.owner int 1 run scoreboard players get @s npc_pid
summon marker ~ ~ ~ {Tags:["npc_pos"]}
data modify storage npc:main new.pos set from entity @e[type=marker,tag=npc_pos,limit=1] Pos
kill @e[type=marker,tag=npc_pos]
data modify storage npc:main new.x set from storage npc:main new.pos[0]
data modify storage npc:main new.y set from storage npc:main new.pos[1]
data modify storage npc:main new.z set from storage npc:main new.pos[2]
data modify storage npc:main npcs append value {}
data modify storage npc:main npcs[-1] set from storage npc:main new
function npc:internal/spawn_entities with storage npc:main new
$execute unless score quiet npc_tmp matches 1 run tellraw @s {"text":"Created $(name) (id $(id)).","color":"green"}
# achievement: three creations by a player (nothing happens when the server seeds the starters: no @s)
scoreboard players add @s npc_made 1
execute if score @s npc_made matches 3.. run advancement grant @s only npc:three_npcs
