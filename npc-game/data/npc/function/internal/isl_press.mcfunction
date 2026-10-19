# As the marker: its npc_pid is the island owner (0 or unset = the main island). px = 1024 * owner.
scoreboard players set px npc_tmp 0
scoreboard players operation px npc_tmp = @s npc_pid
scoreboard players operation px npc_tmp *= c1024 npc_tmp
execute store result storage npc:main args.px int 1 run scoreboard players get px npc_tmp
execute as @p[distance=..6] run function npc:internal/visit with storage npc:main args
