# The whole world over (from ___reset_server's confirmation). Runs as the teacher.
# characters, island buttons (player posts cleared; back buttons on player islands are re-marked by isl_ensure), names
kill @e[tag=npc]
execute as @e[type=marker,tag=npc_isl,scores={npc_pid=1..}] at @s run function npc:internal/post_clear
kill @e[type=marker,tag=npc_isl]
data modify storage npc:main npcs set value []
data modify storage npc:main names set value []
# progress: ids are handed out again by the tick, so a returning player keeps nothing
scoreboard players reset * npc_made
scoreboard players reset * npc_pid
scoreboard players set pidnext npc_tmp 0
scoreboard players set next npc_tmp 0
advancement revoke @a from npc:root
# books and items
tag @a remove npc_book
tag @a remove npc_btnfix
clear @a polished_blackstone_button
# everyone back to the start, starters again
gamemode adventure @a
tp @a 0.5 65 0.5 0 0
function npc:internal/starters
tellraw @a {"text":"The server was reset. Everyone starts over. Right-click Bob or Mira to begin.","color":"yellow"}
