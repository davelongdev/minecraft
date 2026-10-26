# Runs on every /reload. forge_go = the lobby NPC dialog button (enabled only while a dialog is open);
# lobby = /trigger lobby, back to the lobby from any game.
scoreboard objectives add forge_go trigger
scoreboard objectives add lobby trigger
scoreboard objectives add forge_tmp dummy
# right-clicks of the Magic Compass (a carrot on a stick underneath)
scoreboard objectives add forge_compass minecraft.used:minecraft.carrot_on_a_stick
# Command Forge halves: the quest each player was on in section 1 / 2 when they switched, and
# forge_s1 = finished section 1 (see enter/commands_in)
scoreboard objectives add forge_t1 dummy
scoreboard objectives add forge_t2 dummy
scoreboard objectives add forge_s1 dummy

# World-wide settings shared by every game (the game copies' own gamerule lines are commented out)
gamerule advance_time false
gamerule advance_weather false
gamerule keep_inventory true
gamerule respawn_radius 0
gamerule spawn_mobs false
gamerule fall_damage false
gamerule send_command_feedback false
gamerule command_block_output false
gamerule max_block_modifications 100000
gamerule pvp true
# nothing breaks blocks on its own: creepers/endermen, TNT, arrows/tridents, spreading fire
gamerule mob_griefing false
gamerule tnt_explodes false
gamerule projectiles_can_break_blocks false
gamerule fire_spread_radius_around_player 0
weather clear

# One sidebar per game: each game's players are on a team whose colour picks the sidebar
team add forge_lobby
team modify forge_lobby color white
team add forge_ob
team modify forge_ob color blue
team add forge_jump
team modify forge_jump color green
team add forge_arena
team modify forge_arena color red
team add forge_tut
team modify forge_tut color aqua
team add forge_npc
team modify forge_npc color light_purple
scoreboard objectives setdisplay sidebar
# the games' objectives may not exist yet while this runs
schedule function forge:internal/sidebars 2t
