# Switch everyone to play mode: run with /function oneblock:___play
gamemode adventure @a
clear @a minecraft:iron_shovel
give @a minecraft:iron_shovel[minecraft:can_break={blocks:"#minecraft:dirt"}]
clear @a minecraft:trial_key
clear @a minecraft:ominous_trial_key
give @a minecraft:trial_key[custom_name={"text":"Rusty Key","color":"gold","italic":false},lore=[{"text":"Opens a locked chest","color":"gray","italic":false}],enchantment_glint_override=true,custom_data={oneblock_key:"rusty"}]
give @a minecraft:ominous_trial_key[custom_name={"text":"Golden Key","color":"yellow","italic":false},lore=[{"text":"Opens the iron door","color":"gray","italic":false}],enchantment_glint_override=true,custom_data={oneblock_key:"gold"}]
function oneblock:internal/place_locks
scoreboard players set @a ob_joined 1
scoreboard players set @a ob_lives 3
scoreboard players set @a ob_deaths 0
tp @a 0.5 65 0.5 -90 0
tellraw @a {"text":"Game on!","color":"aqua"}
