execute store result storage npc:main args.num int 1 run data get storage npc:main work[0].num
function npc:internal/load_cur with storage npc:main args
function npc:internal/heal_check with storage npc:main cur
data remove storage npc:main work[0]
execute if data storage npc:main work[0] run function npc:internal/heal_loop
