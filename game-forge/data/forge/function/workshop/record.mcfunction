# Macro (kind), as a player who just claimed workshop #n: owner o<n> = their forge_id, and {n, v, name, kind,
# owner, c} appended to storage forge:main workshops (v = its button's trigger value, c = which of theirs it is).
# The name comes from a player head filled in by a loot table.
$data modify storage forge:main ws_new set value {n:0,v:0,name:"",kind:"$(kind)",owner:0,c:0}
execute store result storage forge:main ws_new.n int 1 run scoreboard players get #n forge_ws
execute store result storage forge:main ws_new.owner int 1 run scoreboard players get @s forge_id
execute store result storage forge:main ws_new.c int 1 run scoreboard players get @s forge_wc
scoreboard players operation #v forge_ws = #n forge_ws
scoreboard players add #v forge_ws 1000
execute store result storage forge:main ws_new.v int 1 run scoreboard players get #v forge_ws
function forge:workshop/set_owner with storage forge:main ws_new
execute at @s run loot spawn ~ ~ ~ loot forge:workshop_head
execute at @s run data modify storage forge:main ws_new.name set from entity @n[type=item,distance=..2,nbt={Item:{id:"minecraft:player_head"}}] Item.components."minecraft:profile".name
execute at @s run kill @e[type=item,distance=..2,nbt={Item:{id:"minecraft:player_head"}}]
execute if data storage forge:main ws_new{name:""} run data modify storage forge:main ws_new.name set value "Someone"
data modify storage forge:main workshops append from storage forge:main ws_new
