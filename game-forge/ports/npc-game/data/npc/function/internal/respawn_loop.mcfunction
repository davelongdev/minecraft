# Recursive: re-create the entities of work[0], then the rest.
execute store result storage npc:main args.num int 1 run data get storage npc:main work[0].num
function npc:internal/respawn_one
data remove storage npc:main work[0]
execute if data storage npc:main work[0] run function npc:internal/respawn_loop
