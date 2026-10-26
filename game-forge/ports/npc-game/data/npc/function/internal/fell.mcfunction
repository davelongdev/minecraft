# As a player who fell into the void: back onto the island they fell from (islands are 1024 apart on x; main = 0).
execute store result score fx npc_tmp run data get entity @s Pos[0]
scoreboard players add fx npc_tmp 512
scoreboard players operation fx npc_tmp /= c1024 npc_tmp
scoreboard players operation fx npc_tmp *= c1024 npc_tmp
execute store result storage npc:main args.px int 1 run scoreboard players get fx npc_tmp
function npc:internal/fell_tp with storage npc:main args
