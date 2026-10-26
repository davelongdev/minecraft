# Positioned at the island origin. Clears and rebuilds the island (12x12, x/z 0..11), then puts @s on it.
# Layout (relative): spawn 1.5,6.5 facing east · main sign 7,6 · posts at x7: z2 previous, z4 next, z8 quest · RESET ALL QUESTS post at 1,2 once finished · quest 11 dissolves the banner and adds a bridge east (x 12..15, z 4..6) to a platform (x 16..35, z -4..15) holding the cage at 26,5 (see tools/gen_cage_area.py)
# clear the footprint: island, banner, quest-11 area east (x ..35, z -11..) and legacy south platforms (z ..35)
fill ~ ~-2 ~-11 ~35 ~20 ~11 air
fill ~ ~-2 ~12 ~35 ~20 ~35 air
fill ~-4 ~-2 ~12 ~-1 ~6 ~35 air
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
function tut:internal/welcome_sign_rel
function tut:internal/posts_rel
# a player who already finished the cage trip keeps the TP TO NEXT ISLAND + RESET ALL QUESTS posts instead
execute if score @s tut_end matches 1.. run function tut:internal/finish_post_rel
# COMMAND / FORGE block letters floating east of the island
function tut:internal/banner_rel
# walkway west of the island; new arrivals start at its far end and walk in
function tut:internal/path_rel
spawnpoint @s ~1 ~ ~6
# (the arrival sequence is internal/start_intro, run by join and reset_player)
