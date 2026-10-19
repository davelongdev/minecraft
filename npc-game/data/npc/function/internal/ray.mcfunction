# step 0.25 blocks forward up to 30 times (7.5 blocks) looking for the freshly placed button
execute if block ~ ~ ~ polished_blackstone_button run return run function npc:internal/ray_hit
scoreboard players add ray npc_tmp 1
execute if score ray npc_tmp matches 30.. run return 0
execute positioned ^ ^ ^0.25 run function npc:internal/ray
