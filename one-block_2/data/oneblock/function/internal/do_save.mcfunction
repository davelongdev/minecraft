# Macro: saves the course region as structure oneblock:game-$(n).
# Called from ___save_game with storage oneblock:main {n:<save number>}.
# A temporary structure block is pulsed by a redstone block, then both removed.
$setblock -4 54 -6 minecraft:structure_block{mode:"SAVE",name:"oneblock:game-$(n)",posX:0,posY:1,posZ:0,sizeX:31,sizeY:16,sizeZ:13,showboundingbox:0b}
setblock -4 53 -6 minecraft:redstone_block
setblock -4 53 -6 minecraft:air
setblock -4 54 -6 minecraft:air
$tellraw @a {"text":"Save point created: game-$(n)","color":"aqua"}
