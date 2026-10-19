# Macro (id): as a player. Sets ok npc_tmp to 1 if they made this character, else 0; o npc_tmp = the owner id (0 = starter).
scoreboard players set ok npc_tmp 0
scoreboard players set o npc_tmp 0
$execute store result score o npc_tmp run data get storage npc:main npcs[{id:"$(id)"}].owner
execute if score o npc_tmp = @s npc_pid run scoreboard players set ok npc_tmp 1
# entries from before ownership (2026-10-18) have no owner key: anyone may change them until they are remade
$execute unless data storage npc:main npcs[{id:"$(id)"}].owner run scoreboard players set ok npc_tmp 1
