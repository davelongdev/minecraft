# Positioned at the quest origin: the PREVIOUS QUEST post at z4, so it and SHOW QUEST (z8) sit evenly either side of
# the quest sign (z6) (Dave 2026-10-26, after the NEXT QUEST post at z4 was dropped: quests complete on their own,
# internal/auto_check). It was at z2 until then; ensure_plot moves old posts (old_posts_clear_rel).
setblock ~7 ~ ~4 oak_log
setblock ~7 ~1 ~4 stone_button[face=floor,facing=west]
setblock ~6 ~ ~4 dark_oak_wall_sign[facing=west]{allow_op_features:1b,front_text:{messages:[{"font":"minecraft:uniform","text":""},{"font":"minecraft:uniform","text":"PREVIOUS QUEST","color":"red","bold":true},{"font":"minecraft:uniform","text":"press the button","color":"white"},{"font":"minecraft:uniform","text":""}],color:"white",has_glowing_text:1b},is_waxed:1b}
