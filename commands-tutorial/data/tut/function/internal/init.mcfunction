# One-time world setup, guarded by global tut_init.
scoreboard players set global tut_init 1

# clear the Void preset's stone platform
fill -32 -64 -32 32 -60 32 air
fill -32 -59 -32 32 -55 32 air

# hub pad: world spawn only, players are moved to their plot one tick after joining
fill -4 99 -4 4 99 4 smooth_stone
function tut:internal/hub_sign
setworldspawn 0 100 0 0 0

gamerule advance_time false
time set noon
gamerule advance_weather false
weather clear
gamerule respawn_radius 0
gamerule command_block_output false
gamerule send_command_feedback true
gamerule spawn_mobs false
gamerule fall_damage false
gamerule keep_inventory true
gamerule max_block_modifications 100000
defaultgamemode adventure

# sandbox floor (chunk is forceloaded in load)
fill -1024 0 -1024 -1009 0 -1009 bedrock
