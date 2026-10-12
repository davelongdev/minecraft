# Positioned at the island origin: replace the welcome/quest sign and the three posts with the single
# TP TO NEXT ISLAND post at 7,6. Blocks only (finish_island sets the state; build_plot_rel re-places it).
function tut:internal/posts_clear_rel
setblock ~7 ~ ~6 oak_log
setblock ~7 ~1 ~6 stone_button[face=floor,facing=west]
setblock ~6 ~ ~6 dark_oak_wall_sign[facing=west]{allow_op_features:1b,front_text:{messages:[{"font":"minecraft:uniform","text":"","color":"white"},{"font":"minecraft:uniform","text":"TP TO","color":"gold","bold":true},{"font":"minecraft:uniform","text":"NEXT ISLAND","color":"gold","bold":true},{"font":"minecraft:uniform","text":"press the button","color":"white"}],color:"white",has_glowing_text:1b},is_waxed:1b}
function tut:internal/reset_post_rel
