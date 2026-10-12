# Positioned at island 1's origin: the RESET ALL QUESTS post, only in the finished state (tut_end 1.., with the
# TP TO NEXT ISLAND post; finish_post_rel places it, unfinish_rel removes it) on the west edge, north of spawn (1,2), sign facing
# east into the island. Pressing it twice within 5 s runs internal/reset_player (see internal/reset_press).
setblock ~1 ~ ~2 oak_log
setblock ~1 ~1 ~2 stone_button[face=floor,facing=east]
setblock ~2 ~ ~2 dark_oak_wall_sign[facing=east]{allow_op_features:1b,front_text:{messages:[{"font":"minecraft:uniform","text":"","color":"white"},{"font":"minecraft:uniform","text":"RESET","color":"dark_red","bold":true},{"font":"minecraft:uniform","text":"ALL QUESTS","color":"dark_red","bold":true},{"font":"minecraft:uniform","text":"press twice","color":"white"}],color:"white",has_glowing_text:1b},is_waxed:1b}
