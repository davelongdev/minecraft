# Teacher tool (/function npc:internal/delete_all): remove EVERY character, whoever made them. Players' /trigger clear_all_npcs
# runs delete_mine instead. The starters are not reseeded (npc_seed stays 1).
kill @e[distance=0..,tag=npc]
data modify storage npc:main npcs set value []
scoreboard players set global npc_seed 1
tellraw @s {"text":"All characters deleted. /trigger create_npc makes a new one.","color":"yellow"}
