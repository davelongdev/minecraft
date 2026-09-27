# Show your remaining lives: run with /function oneblock:___lives
tellraw @s [{"text":"Lives: ","color":"gray"},{"score":{"name":"@s","objective":"ob_lives"},"color":"yellow"}]
