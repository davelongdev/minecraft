# Macro (pid, name): store it and refresh the sign on every island-button post this player owns
$data remove storage npc:main names[{pid:$(pid)}]
$data modify storage npc:main names append value {pid:$(pid),name:"$(name)"}
$tellraw @s {"text":"Your name is now $(name).","color":"green"}
scoreboard players operation p npc_tmp = @s npc_pid
execute as @e[type=marker,tag=npc_isl] if score @s npc_pid = p npc_tmp at @s positioned ~ ~-1 ~ if block ~ ~ ~ stone run function npc:internal/post_sign with storage npc:main args
