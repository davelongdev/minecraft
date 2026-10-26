# Macro (kind), as a player who just got workshop forge_ws: add {n, v, name, kind} to storage forge:main workshops
# (v = the visit button's trigger value). The name comes from a player head filled in by a loot table.
$data modify storage forge:main ws_new set value {n:0,v:0,name:"",kind:"$(kind)"}
execute store result storage forge:main ws_new.n int 1 run scoreboard players get @s forge_ws
scoreboard players operation #v forge_ws = @s forge_ws
scoreboard players add #v forge_ws 1000
execute store result storage forge:main ws_new.v int 1 run scoreboard players get #v forge_ws
execute at @s run loot spawn ~ ~ ~ loot forge:workshop_head
execute at @s run data modify storage forge:main ws_new.name set from entity @n[type=item,distance=..2,nbt={Item:{id:"minecraft:player_head"}}] Item.components."minecraft:profile".name
execute at @s run kill @e[type=item,distance=..2,nbt={Item:{id:"minecraft:player_head"}}]
execute if data storage forge:main ws_new{name:""} run data modify storage forge:main ws_new.name set value "Someone"
data modify storage forge:main workshops append from storage forge:main ws_new
