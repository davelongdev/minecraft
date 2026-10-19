# Positioned at the quest origin: the NEXT QUEST (z4) and PREVIOUS QUEST (z2) posts
setblock ~7 ~ ~4 oak_log
setblock ~7 ~1 ~4 stone_button[face=floor,facing=west]
setblock ~6 ~ ~4 dark_oak_wall_sign[facing=west]{allow_op_features:1b,front_text:{messages:[{"font":"minecraft:uniform","text":""},{"font":"minecraft:uniform","text":"NEXT QUEST","color":"green","bold":true},{"font":"minecraft:uniform","text":"press the button","color":"white"},{"font":"minecraft:uniform","text":""}],color:"white",has_glowing_text:1b},is_waxed:1b}
setblock ~7 ~ ~2 oak_log
setblock ~7 ~1 ~2 stone_button[face=floor,facing=west]
setblock ~6 ~ ~2 dark_oak_wall_sign[facing=west]{allow_op_features:1b,front_text:{messages:[{"font":"minecraft:uniform","text":""},{"font":"minecraft:uniform","text":"PREVIOUS QUEST","color":"red","bold":true},{"font":"minecraft:uniform","text":"press the button","color":"white"},{"font":"minecraft:uniform","text":""}],color:"white",has_glowing_text:1b},is_waxed:1b}
