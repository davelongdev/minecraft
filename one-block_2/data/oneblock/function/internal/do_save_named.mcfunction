# Macro: performs the named save for ___save_as and sets ok=1 on completion.
# The never-guarded place line exists only to force $(name) to parse as a
# resource location at compile time — with an invalid name this whole function
# fails to load, nothing runs, and ___save_as reports the failure.
$execute if score never ob_saves matches 1 run place template oneblock:save-$(name) -4 55 -6
$setblock -4 54 -6 minecraft:structure_block{mode:"SAVE",name:"oneblock:save-$(name)",posX:0,posY:1,posZ:0,sizeX:31,sizeY:16,sizeZ:13,showboundingbox:0b}
setblock -4 53 -6 minecraft:redstone_block
setblock -4 53 -6 minecraft:air
setblock -4 54 -6 minecraft:air
$execute unless data storage oneblock:main saves[{name:"$(name)"}] run data modify storage oneblock:main saves append value {name:"$(name)"}
$tellraw @a {"text":"Save point created: $(name)","color":"aqua"}
scoreboard players set ok ob_saves 1
