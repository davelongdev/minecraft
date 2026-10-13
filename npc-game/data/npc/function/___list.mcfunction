# All characters
execute unless data storage npc:main npcs[0] run tellraw @s {"text":"No characters yet. /function npc:___new {id:\"zed\",name:\"Zed\"} makes one where you stand.","color":"yellow"}
execute if data storage npc:main npcs[0] run tellraw @s {"text":"Characters:","color":"aqua"}
data modify storage npc:main work set from storage npc:main npcs
execute if data storage npc:main work[0] run function npc:internal/list_loop
