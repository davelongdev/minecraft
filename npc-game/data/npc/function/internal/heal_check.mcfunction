# Macro (id, num, x, y, z, ...cur): keep exactly one set of entities per character.
# Skipped when no player is near its home: in unloaded chunks @e can't see the entities and a summon would duplicate them.
$execute positioned $(x) $(y) $(z) unless entity @a[distance=..64] run return run scoreboard players set h$(num) npc_tmp 0
# duplicates (a chunk's entities load a few ticks after its blocks, so an early respawn used to double the cast): rebuild once
$execute store result score n npc_tmp if entity @e[type=villager,tag=npc_$(id)]
execute if score n npc_tmp matches 2.. run return run function npc:internal/spawn_entities with storage npc:main cur
# all three present: fine
$execute if entity @e[type=villager,tag=npc_$(id),limit=1] if entity @e[type=interaction,tag=npc_$(id),limit=1] if entity @e[type=text_display,tag=npc_$(id),limit=1] run return run scoreboard players set h$(num) npc_tmp 0
# something missing: respawn only after 40 consecutive ticks (2 s), long enough for late-loading entities to show up
$scoreboard players add h$(num) npc_tmp 1
$execute if score h$(num) npc_tmp matches 40.. run function npc:internal/spawn_entities with storage npc:main cur
$execute if score h$(num) npc_tmp matches 40.. run scoreboard players set h$(num) npc_tmp 0
