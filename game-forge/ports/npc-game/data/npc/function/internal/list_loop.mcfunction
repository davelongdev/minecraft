function npc:internal/list_line with storage npc:main work[0]
data remove storage npc:main work[0]
execute if data storage npc:main work[0] run function npc:internal/list_loop
