# As a villager body that fell into the void: back to its home spot.
execute store result storage npc:main args.num int 1 run scoreboard players get @s npc_num
function npc:internal/load_cur with storage npc:main args
function npc:internal/tp_home with storage npc:main cur
