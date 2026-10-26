# Once a second (tick): any lava or fire in the hub box (see ___restore_hub) turns back into air.
scoreboard players set clock forge_tmp 0
execute in minecraft:overworld run fill -16 55 -21 15 80 21 minecraft:air replace minecraft:lava
execute in minecraft:overworld run fill 16 55 -21 41 80 21 minecraft:air replace minecraft:lava
execute in minecraft:overworld run fill -16 55 -21 15 80 21 minecraft:air replace #minecraft:fire
execute in minecraft:overworld run fill 16 55 -21 41 80 21 minecraft:air replace #minecraft:fire
