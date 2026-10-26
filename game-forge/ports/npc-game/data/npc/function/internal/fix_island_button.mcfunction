# One-off for players who got the first Island Button (can_place_on #dirt, which excludes grass in 26.3): swap it for the fixed item.
# Run as the player from tick once (tag npc_btnfix), harmless for players without the old button.
tag @s add npc_btnfix
execute if items entity @s container.* polished_blackstone_button[can_place_on~{blocks:"#minecraft:dirt"}] run clear @s polished_blackstone_button[can_place_on~{blocks:"#minecraft:dirt"}]
execute if entity @s[advancements={npc:three_npcs=true}] unless items entity @s container.* polished_blackstone_button run function npc:internal/unlock_island
