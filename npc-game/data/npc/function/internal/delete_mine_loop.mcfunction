# no owner key (made before ownership): counts as yours in the list
execute unless data storage npc:main work[0].owner store result storage npc:main work[0].owner int 1 run scoreboard players get @s npc_pid
function npc:internal/delete_mine_line with storage npc:main work[0]
data remove storage npc:main work[0]
execute if data storage npc:main work[0] run function npc:internal/delete_mine_loop
