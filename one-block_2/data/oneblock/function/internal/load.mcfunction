# Runs on every load/reload; only calls init the first time
scoreboard objectives add ob_init dummy
scoreboard objectives add ob_joined dummy
scoreboard objectives add ob_saves dummy
execute unless score global ob_init matches 1 run function oneblock:internal/init
