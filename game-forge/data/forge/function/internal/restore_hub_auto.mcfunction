# Macro (name): put the hub back to automatic snapshot <name> (see ___hub_snapshots), then clear dropped items.
$execute in minecraft:overworld run place template forge:hub_auto/$(name)_west -16 55 -21
$execute in minecraft:overworld run place template forge:hub_auto/$(name)_east 16 55 -21
execute in minecraft:overworld run kill @e[type=item,x=-16,y=55,z=-21,dx=80,dy=26,dz=43]
$tellraw @s {text:"Hub restored to $(name).",color:"aqua"}
