# As a player: 1 if they finished NPC Forge (the Island Builder achievement: three NPCs made) or are tagged ws_admin.
execute if entity @s[tag=ws_admin] run return 1
execute if entity @s[advancements={npc:three_npcs=true}] run return 1
return fail
