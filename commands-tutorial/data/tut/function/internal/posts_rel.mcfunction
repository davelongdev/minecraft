# Positioned at the quest origin (island 1: the island origin; island 2: origin + 12 south): the SHOW QUEST post, and the
# NEXT QUEST / PREVIOUS QUEST posts once the player has completed a quest (Dave 2026-10-18: nothing but SHOW QUEST until
# quest 1 is done; quest 1's own dialog has an "I did it!" button that completes it). nav_posts_rel / nav_posts_clear_rel
# are also run from ensure_plot as tut_quests changes. Island 1: removed by finish_island after quest 11's cage visit;
# restored by unfinish_rel and build_plot_rel (with welcome_sign_rel). Island 2: island2_rel.
setblock ~7 ~ ~8 oak_log
setblock ~7 ~1 ~8 stone_button[face=floor,facing=west]
setblock ~6 ~ ~8 dark_oak_wall_sign[facing=west]{allow_op_features:1b,front_text:{messages:[{"font":"minecraft:uniform","text":""},{"font":"minecraft:uniform","text":"SHOW QUEST","color":"yellow","bold":true},{"font":"minecraft:uniform","text":"press the button","color":"white"},{"font":"minecraft:uniform","text":""}],color:"white",has_glowing_text:1b},is_waxed:1b}
execute if score @s tut_quests matches 1.. run function tut:internal/nav_posts_rel
