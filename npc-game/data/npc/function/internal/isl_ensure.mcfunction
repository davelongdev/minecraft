# As any player standing on a player island (x >= 512): keep it built. All three passes are guarded, so this is cheap:
# isl_build_rel (dirt + stone + fence; skipped once stone or the bedrock marker is there), isl_grass_rel (grass + back
# button; needs the stone pass from an earlier tick, sets the bedrock marker), isl_back_rel (the back button's marker).
execute store result score bx npc_tmp run data get entity @s Pos[0]
scoreboard players add bx npc_tmp 512
scoreboard players operation bx npc_tmp /= c1024 npc_tmp
scoreboard players operation bx npc_tmp *= c1024 npc_tmp
execute store result storage npc:main args.px int 1 run scoreboard players get bx npc_tmp
function npc:internal/isl_build with storage npc:main args
function npc:internal/isl_grass with storage npc:main args
function npc:internal/isl_back with storage npc:main args
