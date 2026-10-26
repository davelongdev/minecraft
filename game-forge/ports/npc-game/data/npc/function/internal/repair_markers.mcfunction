# One-off (from load, 2026-10-18): the playtest world's first Island Button post at -7 65 -7 lost its marker to the upgrade bug.
# Re-creates it for player 1 if the post is still there and has no marker. Safe to delete once the playtest world is reset.
execute positioned -6.5 65.5 -6.5 if block ~ ~ ~ polished_blackstone_button unless entity @e[type=marker,tag=npc_isl,distance=..0.2] run summon marker ~ ~ ~ {Tags:["npc_isl","npc_new"]}
scoreboard players set @e[distance=0..,type=marker,tag=npc_new] npc_pid 1
tag @e[distance=0..,type=marker,tag=npc_new] remove npc_new
