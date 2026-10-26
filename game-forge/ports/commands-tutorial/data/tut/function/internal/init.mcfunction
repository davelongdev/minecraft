# One-time world setup, guarded by global tut_init.
scoreboard players set global tut_init 1

# clear the Void preset's stone platform
fill -32 -64 -32 32 -60 32 air
fill -32 -59 -32 32 -55 32 air

# world spawn: no hub pad any more (removed 2026-10-12, it was visible as a 'second island');
# a new player hangs in the air here for one tick, then join moves them to their plot
# [game-forge: set world-wide by the game-forge pack] setworldspawn 0 100 0 0 0

# [game-forge: set world-wide by the game-forge pack] gamerule advance_time false
time set noon
# [game-forge: set world-wide by the game-forge pack] gamerule advance_weather false
weather clear
# [game-forge: set world-wide by the game-forge pack] gamerule respawn_radius 0
# [game-forge: set world-wide by the game-forge pack] gamerule command_block_output false
# [game-forge: set world-wide by the game-forge pack] gamerule send_command_feedback true
# [game-forge: set world-wide by the game-forge pack] gamerule spawn_mobs false
# [game-forge: set world-wide by the game-forge pack] gamerule fall_damage false
# [game-forge: set world-wide by the game-forge pack] gamerule keep_inventory true
# [game-forge: set world-wide by the game-forge pack] gamerule max_block_modifications 100000
defaultgamemode adventure

# sandbox floor (chunk is forceloaded in load)
fill -1024 0 -1024 -1009 0 -1009 bedrock
