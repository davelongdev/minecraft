# As the placer, at a block centre: stone post, button on top, marker at the button with the placer's id, name sign on the west side.
setblock ~ ~ ~ stone
setblock ~ ~1 ~ polished_blackstone_button[face=floor]
execute positioned ~ ~1 ~ unless entity @e[type=marker,tag=npc_isl,distance=..0.2] run summon marker ~ ~ ~ {Tags:["npc_isl","npc_new"]}
scoreboard players operation @e[type=marker,tag=npc_new,limit=1] npc_pid = @s npc_pid
tag @e[type=marker,tag=npc_new] remove npc_new
function npc:internal/my_name
function npc:internal/post_sign with storage npc:main args
tellraw @s {"text":"Island Button placed. Anyone who presses it visits your island.","color":"gold"}
