# As a player who just arrived on a player island: build it under them once the chunks are in (two passes: stone, then grass).
scoreboard players remove @s npc_bld 1
execute store result score bx npc_tmp run data get entity @s Pos[0]
scoreboard players add bx npc_tmp 512
scoreboard players operation bx npc_tmp /= c1024 npc_tmp
scoreboard players operation bx npc_tmp *= c1024 npc_tmp
execute store result storage npc:main args.px int 1 run scoreboard players get bx npc_tmp
execute if score @s npc_bld matches 30..55 run function npc:internal/isl_build with storage npc:main args
execute if score @s npc_bld matches 1..20 run function npc:internal/isl_grass with storage npc:main args
execute if score @s npc_bld matches 1..20 run function npc:internal/isl_back with storage npc:main args
