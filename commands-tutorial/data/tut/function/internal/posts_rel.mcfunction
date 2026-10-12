# Positioned at the quest origin (island 1: the island origin; island 2: origin + 12 south): the three button posts (QUEST, NEXT QUEST, PREVIOUS QUEST).
# Island 1: removed by finish_island after quest 11's cage visit; restored by unfinish_rel and build_plot_rel (with welcome_sign_rel). Island 2: island2_rel.
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
