# /trigger clear_one_npc: a screen with one button per character; picking one opens confirm_delete.
execute unless data storage npc:main npcs[0] run return run tellraw @s {"text":"There are no NPCs to clear.","color":"yellow"}
data modify storage npc:main pick set value {actions:[]}
data modify storage npc:main work set from storage npc:main npcs
function npc:internal/pick_delete_loop
execute unless data storage npc:main pick.actions[0] run return run tellraw @s {"text":"You haven't made any NPCs yet. /trigger create_npc makes one.","color":"yellow"}
function npc:internal/pick_delete_show with storage npc:main pick
