# Positioned at the island origin. Clears and rebuilds the island (12x12, x/z 0..11), then puts @s on it.
# Layout (relative): spawn 1.5,6.5 facing east · main sign 7,6 · posts at x7: z2 previous, z4 next, z8 quest · quest 10 adds a bridge south (x 4..6, z 12..15) to a platform (z 16..27) holding the cage at 5,21 (see s1/e9/build)
# clear the full 32x32 footprint (covers islands built by older versions of the pack)
fill ~ ~-2 ~ ~31 ~20 ~31 air
# sweep dropped items off the island
execute positioned ~16 ~8 ~16 run kill @e[type=item,distance=..40]
# two-pass floor: stone now, grass_block next tick (ensure_plot) so every block gets a light update
fill ~ ~-1 ~ ~11 ~-1 ~11 stone
setblock ~1 ~-2 ~6 bedrock
# fence around the edge so nobody walks off
fill ~ ~ ~ ~11 ~ ~ oak_fence
fill ~ ~ ~11 ~11 ~ ~11 oak_fence
fill ~ ~ ~ ~ ~ ~11 oak_fence
fill ~11 ~ ~ ~11 ~ ~11 oak_fence
setblock ~7 ~ ~6 dark_oak_sign[rotation=4]{allow_op_features:1b,front_text:{messages:[{"font":"minecraft:uniform","text":"Welcome to","color":"white"},{"font":"minecraft:uniform","text":"Command Forge","color":"yellow","bold":true},{"font":"minecraft:uniform","text":"Press a button","color":"white"},{"font":"minecraft:uniform","text":"to begin.","color":"white"}],color:"white",has_glowing_text:1b},is_waxed:1b}
# three posts with buttons, each labelled by a sign facing the player
setblock ~7 ~ ~8 oak_log
setblock ~7 ~1 ~8 stone_button[face=floor,facing=west]
setblock ~6 ~ ~8 dark_oak_wall_sign[facing=west]{allow_op_features:1b,front_text:{messages:[{"font":"minecraft:uniform","text":""},{"font":"minecraft:uniform","text":"QUEST","color":"yellow","bold":true},{"font":"minecraft:uniform","text":"press the button","color":"white"},{"font":"minecraft:uniform","text":""}],color:"white",has_glowing_text:1b},is_waxed:1b}
setblock ~7 ~ ~4 oak_log
setblock ~7 ~1 ~4 stone_button[face=floor,facing=west]
setblock ~6 ~ ~4 dark_oak_wall_sign[facing=west]{allow_op_features:1b,front_text:{messages:[{"font":"minecraft:uniform","text":""},{"font":"minecraft:uniform","text":"NEXT QUEST","color":"green","bold":true},{"font":"minecraft:uniform","text":"press the button","color":"white"},{"font":"minecraft:uniform","text":""}],color:"white",has_glowing_text:1b},is_waxed:1b}
setblock ~7 ~ ~2 oak_log
setblock ~7 ~1 ~2 stone_button[face=floor,facing=west]
setblock ~6 ~ ~2 dark_oak_wall_sign[facing=west]{allow_op_features:1b,front_text:{messages:[{"font":"minecraft:uniform","text":""},{"font":"minecraft:uniform","text":"PREVIOUS QUEST","color":"red","bold":true},{"font":"minecraft:uniform","text":"press the button","color":"white"},{"font":"minecraft:uniform","text":""}],color:"white",has_glowing_text:1b},is_waxed:1b}
# COMMAND / FORGE block letters floating east of the island
function tut:internal/banner_rel
# walkway west of the island; new arrivals start at its far end and walk in
function tut:internal/path_rel
spawnpoint @s ~1 ~ ~6
# (the arrival sequence is internal/start_intro, run by join and reset_player)
