# As an island-button marker, at its block: a press (edge-triggered via the marker's npc_tmp) teleports the nearest player.
execute if block ~ ~ ~ polished_blackstone_button[powered=true] unless score @s npc_tmp matches 1 run function npc:internal/isl_press
execute if block ~ ~ ~ polished_blackstone_button[powered=true] run scoreboard players set @s npc_tmp 1
execute unless block ~ ~ ~ polished_blackstone_button[powered=true] run scoreboard players set @s npc_tmp 0
# a button placed before posts existed sits straight on the grass: upgrade it to a signed post (moves the marker up one)
# (return: the upgrade moves the button and the marker up one, so the "button gone" check below would see the new stone and kill it)
execute if block ~ ~ ~ polished_blackstone_button if block ~ ~-1 ~ grass_block if score @s npc_pid matches 1.. run return run function npc:internal/post_upgrade
# button gone (teacher removed it): forget it
execute unless block ~ ~ ~ polished_blackstone_button run kill @s
