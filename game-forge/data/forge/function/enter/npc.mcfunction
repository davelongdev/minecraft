# NPC Forge (copy of the npc-game server, dimension forge:npc): the main island. Dropping the book tags
# makes its tick hand the books (and an earned Island Button) back.
function forge:internal/reset_player
execute in forge:npc run tp @s 0.5 65 0.5 0 0
execute in forge:npc run spawnpoint @s 0 65 0
gamemode adventure @s
tag @s remove npc_book
tag @s remove npc_btnfix
