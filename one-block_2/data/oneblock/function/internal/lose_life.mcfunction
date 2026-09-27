# Called as a player who just died (ob_deaths >= 1): spend a life.
scoreboard players set @s ob_deaths 0
scoreboard players remove @s ob_lives 1
# The shovel fell into the void with them — re-equip survivors
execute if score @s ob_lives matches 1.. run clear @s minecraft:iron_shovel
execute if score @s ob_lives matches 1.. run give @s minecraft:iron_shovel[minecraft:can_break={blocks:"#minecraft:dirt"}]
execute if score @s ob_lives matches 1.. run tellraw @s [{"text":"You died! ","color":"red"},{"text":"Lives left: ","color":"gray"},{"score":{"name":"@s","objective":"ob_lives"},"color":"yellow"}]
execute if score @s ob_lives matches ..0 run function oneblock:internal/game_over
