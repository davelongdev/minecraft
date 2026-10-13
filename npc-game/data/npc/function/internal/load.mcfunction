# Runs on every /reload; one-time setup lives in init.
# Characters live in storage npc:main npcs = [{num, id, name, job, greeting, pos:[x,y,z], b1:{label,cmd}, b2, b3}, ...].
# Each character's three entities (villager body, interaction click box, text_display name) are tagged npc and
# npc_<id> and carry the character's num as an entity score (npc_num), which is how a click finds its entry.
scoreboard objectives add npc_init dummy
scoreboard objectives add npc_choice trigger
scoreboard objectives add npc_num dummy
scoreboard objectives add npc_tmp dummy
scoreboard players enable @a npc_choice
execute unless data storage npc:main npcs run data modify storage npc:main npcs set value []
scoreboard players add next npc_tmp 0
scoreboard players set c100 npc_tmp 100
scoreboard players set c0 npc_tmp 0
scoreboard players set c1 npc_tmp 1
execute unless score global npc_init matches 1 run function npc:internal/init
# a world from the earlier generated version has entities but no storage entries: start the cast over
execute if score global npc_init matches 1 unless data storage npc:main npcs[0] run kill @e[tag=npc]
execute if score global npc_init matches 1 unless data storage npc:main npcs[0] run function npc:internal/starters
