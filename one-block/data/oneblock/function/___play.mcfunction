# Switch everyone to play mode: run with /function oneblock:___play
gamemode adventure @a
clear @a minecraft:iron_shovel
give @a minecraft:iron_shovel[minecraft:can_break={blocks:"#minecraft:dirt"}]
scoreboard players set @a ob_joined 1
tp @a 0.5 65 0.5 -90 0
tellraw @a {"text":"Game on!","color":"aqua"}
