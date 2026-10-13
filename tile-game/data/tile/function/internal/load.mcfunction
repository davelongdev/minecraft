# Runs on every load/reload; only calls init the first time.
# tile_tmp holds scratch values under fake player names: px/pz = tile coords being worked on,
# ok = success flag, c3 = constant, mode = 0 build / 1 play (___build / ___play), placing = tile functions allowed.
scoreboard objectives add tile_init dummy
scoreboard objectives add tile_tmp dummy
scoreboard players set c3 tile_tmp 3
scoreboard players add mode tile_tmp 0
# short commands: /trigger <name> (see internal/triggers)
scoreboard objectives add floor trigger
scoreboard objectives add grass trigger
scoreboard objectives add water trigger
scoreboard objectives add lava trigger
scoreboard objectives add wall trigger
scoreboard objectives add tree trigger
scoreboard objectives add glass trigger
scoreboard objectives add ice trigger
scoreboard objectives add gold trigger
scoreboard objectives add tiles trigger
scoreboard objectives add remove trigger
scoreboard objectives add where trigger
scoreboard objectives add play trigger
scoreboard objectives add build trigger
scoreboard objectives add reset trigger
scoreboard objectives add clear trigger
scoreboard objectives add help trigger
scoreboard players enable @a floor
scoreboard players enable @a grass
scoreboard players enable @a water
scoreboard players enable @a lava
scoreboard players enable @a wall
scoreboard players enable @a tree
scoreboard players enable @a glass
scoreboard players enable @a ice
scoreboard players enable @a gold
scoreboard players enable @a tiles
scoreboard players enable @a remove
scoreboard players enable @a where
scoreboard players enable @a play
scoreboard players enable @a build
scoreboard players enable @a reset
scoreboard players enable @a clear
scoreboard players enable @a help
execute unless score global tile_init matches 1 run function tile:internal/init
