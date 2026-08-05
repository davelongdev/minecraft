# Runs on every load/reload; only calls init the first time
scoreboard objectives add ob_init dummy
scoreboard objectives add ob_joined dummy
scoreboard objectives add ob_saves dummy
scoreboard objectives add ob_run dummy
scoreboard objectives add ob_timer dummy
scoreboard objectives add ob_best dummy
scoreboard objectives add ob_ds dummy
scoreboard objectives add ob_dt dummy
scoreboard objectives add ob_work dummy
scoreboard objectives add ob_id dummy
scoreboard players set c20 ob_timer 20
scoreboard players set c2 ob_timer 2
execute unless score global ob_init matches 1 run function oneblock:internal/init
