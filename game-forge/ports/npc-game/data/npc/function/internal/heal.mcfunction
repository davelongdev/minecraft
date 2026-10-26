# Every tick (from tick): rebuild any character whose entities are missing, so nobody can kill anyone's NPC for good.
data modify storage npc:main work set from storage npc:main npcs
execute if data storage npc:main work[0] run function npc:internal/heal_loop
