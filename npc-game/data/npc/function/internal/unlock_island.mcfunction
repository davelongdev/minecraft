# Reward of the Island Builder achievement (npc:three_npcs), runs as the player: the Island Button item.
# Adventure players can place it on grass, dirt, podzol, stone, or oak planks (26.3's #dirt tag has no grass_block). Placement is detected in tick (npc_placed stat).
give @s polished_blackstone_button[custom_name={text:"Island Button",color:"gold",italic:false},lore=[{text:"Place it on grass. Whoever presses it visits your island.",color:"gray",italic:false}],can_place_on={blocks:["minecraft:grass_block","minecraft:dirt","minecraft:coarse_dirt","minecraft:podzol","minecraft:stone","minecraft:oak_planks"]}]
# first-timers pick the name for their island sign
execute store result storage npc:main args.pid int 1 run scoreboard players get @s npc_pid
function npc:internal/name_prompt with storage npc:main args
tellraw @s {"text":"Island Builder! You made three NPCs, so you get your own island. Place the Island Button on the grass: anyone who presses it visits your island. A button there brings you back.","color":"gold"}
