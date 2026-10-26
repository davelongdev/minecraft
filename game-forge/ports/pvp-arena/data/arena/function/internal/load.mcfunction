# Runs on every load/reload. The stadium is built once, from internal/tick, as soon as its chunks are loaded.
# arena_tmp fake players: built = build progress (0 not yet, 1..19 waiting for pass 2, 100 done),
# timer = piston cycle tick (0..119), pads_on = pistons running, clock = arrow cleanup counter.
scoreboard objectives add arena_tmp dummy
scoreboard objectives add arena_kills playerKillCount {"text":"Kills","color":"gold"}
scoreboard objectives add arena_deaths deathCount
scoreboard objectives add fight trigger
scoreboard objectives add leave trigger
# [game-forge: set world-wide by the game-forge pack] scoreboard objectives setdisplay sidebar arena_kills
scoreboard players add built arena_tmp 0
scoreboard players add timer arena_tmp 0
scoreboard players add pads_on arena_tmp 0
forceload add -48 -48 47 47
# [game-forge: set world-wide by the game-forge pack] gamerule pvp true
# [game-forge: set world-wide by the game-forge pack] gamerule keep_inventory true
# [game-forge: set world-wide by the game-forge pack] gamerule advance_time false
# [game-forge: set world-wide by the game-forge pack] gamerule advance_weather false
# [game-forge: set world-wide by the game-forge pack] gamerule respawn_radius 0
time set 6000
weather clear
defaultgamemode adventure
# [game-forge: set world-wide by the game-forge pack] setworldspawn 0 80 33 180 0
