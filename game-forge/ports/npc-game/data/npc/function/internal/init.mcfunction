# One-time world setup: a small island in the void, two starter characters on it.
scoreboard players set global npc_init 4
fill -32 -64 -32 32 -60 32 air
fill -32 -59 -32 32 -55 32 air
fill -25 63 -25 24 63 24 grass_block
fill -25 62 -25 24 62 24 dirt
fill -25 64 -25 24 64 -25 oak_fence
fill -25 64 24 24 64 24 oak_fence
fill -25 64 -25 -25 64 24 oak_fence
fill 24 64 -25 24 64 24 oak_fence
# [game-forge: set world-wide by the game-forge pack] setworldspawn 0 65 0 0 0
spawnpoint @a[distance=0..] 0 65 0
tp @a[distance=0..] 0.5 65 0.5 0 0
time set 6000
# [game-forge: set world-wide by the game-forge pack] gamerule advance_time false
# [game-forge: set world-wide by the game-forge pack] gamerule advance_weather false
# [game-forge: set world-wide by the game-forge pack] gamerule respawn_radius 0
defaultgamemode adventure
gamemode adventure @a[distance=0..]
function npc:internal/starters
tellraw @a[distance=0..] {"text":"NPC island loaded. Right-click a character to talk. The NPC Forge Book in your inventory tells you how to make your own.","color":"aqua"}
