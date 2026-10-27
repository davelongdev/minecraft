# Positioned at island 2's origin (px, 100, 1024): a 36x36 island edged with a 2-high copper grate wall for section 2 (placeholder).
# Layout: spawn 1.5,18.5 facing east, sign 7,18 (quest sign once a quest runs), posts 7,20/16/14, GO BACK TO FIRST ISLAND post 1,11 (west edge, sign facing east into the island), banner 44 east (banner2_rel).
# 1024 south = out of render distance of island 1. Its chunks load only once the player is teleported
# there, so next_island tries this right after the tp and all_done retries every tick until the bedrock
# marker exists. Floor goes in as stone; ensure_plot recolours it to prismarine bricks next tick (light update for void chunks; island2_recolor_rel).
execute unless block ~1 ~-2 ~18 bedrock run fill ~ ~-1 ~ ~35 ~-1 ~35 stone
# the floor spans nine chunks and fill fails silently unless all are loaded: no marker (so ensure_plot retries next tick) until every corner is in
execute unless block ~ ~-1 ~ stone run return fail
execute unless block ~35 ~-1 ~ stone run return fail
execute unless block ~ ~-1 ~35 stone run return fail
execute unless block ~35 ~-1 ~35 stone run return fail
setblock ~1 ~-2 ~18 bedrock
# section 2 markers (blue block, red spot, TARGET pad); re-placed by island2_recolor_rel after the floor recolour
function tut:internal/island2_marks_rel
fill ~ ~ ~ ~35 ~1 ~ copper_grate
fill ~ ~ ~35 ~35 ~1 ~35 copper_grate
fill ~ ~ ~ ~ ~1 ~35 copper_grate
fill ~35 ~ ~ ~35 ~1 ~35 copper_grate
# GO BACK TO FIRST ISLAND post (button handled in internal/buttons -> internal/back_island1)
setblock ~1 ~ ~11 oak_log
setblock ~1 ~1 ~11 stone_button[face=floor,facing=east]
setblock ~2 ~ ~11 dark_oak_wall_sign[facing=east]{allow_op_features:1b,front_text:{messages:[{"font":"minecraft:uniform","text":"","color":"white"},{"font":"minecraft:uniform","text":"GO BACK TO","color":"red","bold":true},{"font":"minecraft:uniform","text":"FIRST ISLAND","color":"red","bold":true},{"font":"minecraft:uniform","text":"press the button","color":"white"}],color:"white",has_glowing_text:1b},is_waxed:1b}
setblock ~7 ~ ~18 dark_oak_sign[rotation=4]{allow_op_features:1b,front_text:{messages:[{"font":"minecraft:uniform","text":"Section 2","color":"yellow","bold":true},{"font":"minecraft:uniform","text":"Command Blocks","color":"white"},{"font":"minecraft:uniform","text":"Press a button","color":"white"},{"font":"minecraft:uniform","text":"to begin.","color":"white"}],color:"white",has_glowing_text:1b},is_waxed:1b}
# QUEST / NEXT QUEST / PREVIOUS QUEST posts, same offsets as island 1 from the quest origin (origin + 12 south)
execute positioned ~ ~ ~12 run function tut:internal/posts_rel
# COMMAND / BLOCKS block letters floating east of island 2
function tut:internal/banner2_rel
