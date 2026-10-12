# One-time world setup, guarded by global tut_init.
scoreboard players set global tut_init 1

# clear the Void preset's stone platform
fill -32 -64 -32 32 -60 32 air
fill -32 -59 -32 32 -55 32 air

# hub pad: world spawn only, players are moved to their plot one tick after joining
fill -4 99 -4 4 99 4 smooth_stone
setblock 0 100 0 oak_sign[rotation=8]{allow_op_features:1b,front_text:{messages:[{"font":"minecraft:uniform","text":"Learn Commands","color":"dark_green","bold":true},{"font":"minecraft:uniform","text":"Hang on..."},{"font":"minecraft:uniform","text":"sending you to"},{"font":"minecraft:uniform","text":"your island!"}],has_glowing_text:0b},is_waxed:1b}
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
