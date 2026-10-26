# One-time setup for a player who joined mid-game in adventure mode
scoreboard players set @s ob_joined 1
scoreboard players set @s ob_lives 3
scoreboard players set @s ob_deaths 0
spawnpoint @s 0 65 0
clear @s minecraft:iron_shovel
give @s minecraft:iron_shovel[minecraft:can_break={blocks:"#minecraft:dirt"}]
give @s minecraft:trial_key[custom_name={"text":"Rusty Key","color":"gold","italic":false},lore=[{"text":"Opens a locked chest","color":"gray","italic":false}],enchantment_glint_override=true,custom_data={oneblock_key:"rusty"}]
give @s minecraft:ominous_trial_key[custom_name={"text":"Golden Key","color":"yellow","italic":false},lore=[{"text":"Opens the iron door","color":"gray","italic":false}],enchantment_glint_override=true,custom_data={oneblock_key:"gold"}]
tellraw @s {"text":"Welcome to the void. One block, one shovel.","color":"aqua"}
