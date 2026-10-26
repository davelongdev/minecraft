# As the player being reset.
# progress + achievement (root is re-granted by its tick trigger)
advancement revoke @s from npc:root
scoreboard players reset @s npc_made
# their characters (delete_mine prints its own line) and their island-button posts
function npc:internal/delete_mine
scoreboard players operation p npc_tmp = @s npc_pid
execute as @e[distance=0..,type=marker,tag=npc_isl] if score @s npc_pid = p npc_tmp at @s run function npc:internal/post_clear
# chosen name
execute store result storage npc:main args.pid int 1 run scoreboard players get @s npc_pid
function npc:internal/name_forget with storage npc:main args
# items and books (the tick re-gives the books to anyone without the tag)
clear @s polished_blackstone_button
tag @s remove npc_book
# back to the start
gamemode adventure @s
tp @s 0.5 65 0.5 0 0
tellraw @s {"text":"You start over: your NPCs, island button, name, and achievements are reset.","color":"yellow"}
