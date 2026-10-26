# Macro (name): the name form was saved. Runs as the player.
$data modify storage npc:main args.name set value "$(name)"
execute if data storage npc:main args{name:""} run return run tellraw @s {"text":"Type a name first.","color":"red"}
execute store result storage npc:main args.pid int 1 run scoreboard players get @s npc_pid
function npc:internal/name_set with storage npc:main args
