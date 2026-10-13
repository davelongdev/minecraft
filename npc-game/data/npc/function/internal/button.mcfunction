# As the player who pressed a dialog button: npc_choice = 100*num + k. Run that button's command as them.
scoreboard players operation v npc_tmp = @s npc_choice
scoreboard players operation k npc_tmp = v npc_tmp
scoreboard players operation k npc_tmp %= c100 npc_tmp
scoreboard players operation v npc_tmp /= c100 npc_tmp
execute store result storage npc:main args.num int 1 run scoreboard players get v npc_tmp
execute store result storage npc:main args.k int 1 run scoreboard players get k npc_tmp
function npc:internal/button_get with storage npc:main args
execute if data storage npc:main cmd run function npc:internal/exec with storage npc:main
execute if data storage npc:main say run function npc:internal/speak with storage npc:main
