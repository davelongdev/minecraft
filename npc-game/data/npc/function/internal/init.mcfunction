# One-time world setup: a small island in the void, two starter characters on it.
scoreboard players set global npc_init 1
fill -32 -64 -32 32 -60 32 air
fill -32 -59 -32 32 -55 32 air
fill -6 63 -6 6 63 6 grass_block
fill -6 62 -6 6 62 6 dirt
fill -7 64 -7 7 64 -7 oak_fence
fill -7 64 7 7 64 7 oak_fence
fill -7 64 -7 -7 64 7 oak_fence
fill 7 64 -7 7 64 7 oak_fence
setworldspawn 0 65 0 0 0
spawnpoint @a 0 65 0
tp @a 0.5 65 0.5 0 0
time set 6000
gamerule advance_time false
gamerule advance_weather false
gamerule respawn_radius 0
defaultgamemode adventure
gamemode adventure @a
function npc:internal/starters
tellraw @a {"text":"NPC island loaded. Right-click a character to talk. /function npc:___help shows how to make your own.","color":"aqua"}
