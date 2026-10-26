# As a player: storage npc:main args.name = their chosen name (storage names[{pid}]), else "Player <pid>"
execute store result storage npc:main args.pid int 1 run scoreboard players get @s npc_pid
function npc:internal/my_name_get with storage npc:main args
