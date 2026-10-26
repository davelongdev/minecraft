# Macro (name): why an edit/delete was refused (o npc_tmp 0 = a starter, else another player's)
$execute if score o npc_tmp matches 0 run tellraw @s {"text":"$(name) is a starter NPC. Starters can't be changed.","color":"red"}
$execute unless score o npc_tmp matches 0 run tellraw @s {"text":"$(name) was made by someone else. You can only change your own NPCs.","color":"red"}
