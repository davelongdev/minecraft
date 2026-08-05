# One-time world setup
scoreboard players set global ob_init 1
# Remove the vanilla "The Void" preset starting platform (33x33 stone at y -61)
fill -32 -64 -32 32 -60 32 minecraft:air
fill -32 -59 -32 32 -55 32 minecraft:air
setblock 0 64 0 minecraft:sea_lantern
setworldspawn 0 65 0 -90 0
time set 37300
gamerule advance_time false
gamerule respawn_radius 0
defaultgamemode adventure
gamemode adventure @a
spawnpoint @a 0 65 0
tp @a 0.5 65 0.5 -90 0
give @a minecraft:iron_shovel[minecraft:can_break={blocks:"#minecraft:dirt"}]
scoreboard players set @a ob_joined 1
tellraw @a {"text":"Welcome to the void. One block, one shovel.","color":"aqua"}
