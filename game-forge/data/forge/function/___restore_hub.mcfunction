# Teacher: put the hub back the way it was snapshotted (every block in the hub box x -16..41, y 55..80,
# z -21..21, air included, so anything built or broken since is undone), then clear dropped items.
# The snapshot ships in this pack (structure/hub/west.nbt, east.nbt); after changing the hub on purpose,
# retake it with tools/snapshot_hub.py.
execute in minecraft:overworld run place template forge:hub/west -16 55 -21
execute in minecraft:overworld run place template forge:hub/east 16 55 -21
execute in minecraft:overworld run kill @e[type=item,x=-16,y=55,z=-21,dx=58,dy=26,dz=43]
tellraw @s {"text":"Hub restored.","color":"aqua"}
