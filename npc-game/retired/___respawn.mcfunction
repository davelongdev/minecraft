# Put every character back on its home spot (after a /kill, a crash, or a reload that lost them)
data modify storage npc:main work set from storage npc:main npcs
execute if data storage npc:main work[0] run function npc:internal/respawn_loop
tellraw @s {"text":"Characters respawned.","color":"green"}
