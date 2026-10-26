# One-time world setup
scoreboard players set global ob_init 1
# Remove the vanilla "The Void" preset starting platform (33x33 stone at y -61)
fill -32 -64 -32 32 -60 32 minecraft:air
fill -32 -59 -32 32 -55 32 minecraft:air
setblock 0 64 0 minecraft:sea_lantern
# [game-forge: set world-wide by the game-forge pack] setworldspawn 0 65 0 -90 0
time set 37300
# [game-forge: set world-wide by the game-forge pack] gamerule advance_time false
# [game-forge: set world-wide by the game-forge pack] gamerule respawn_radius 0
defaultgamemode adventure
gamemode adventure @a[distance=0..]
spawnpoint @a[distance=0..] 0 65 0
tp @a[distance=0..] 0.5 65 0.5 -90 0
give @a[distance=0..] minecraft:iron_shovel[minecraft:can_break={blocks:"#minecraft:dirt"}]
scoreboard players set @a[distance=0..] ob_joined 1
scoreboard players set @a[distance=0..] ob_lives 3
scoreboard players set @a[distance=0..] ob_deaths 0
tellraw @a[distance=0..] {"text":"Welcome to the void. One block, one shovel.","color":"aqua"}
