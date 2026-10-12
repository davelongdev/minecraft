$execute positioned $(px) 100 0 unless block ~1 ~-2 ~6 bedrock run function tut:internal/build_plot_rel
$execute positioned $(px) 100 0 if block ~1 ~-1 ~6 stone run fill ~ ~-1 ~ ~11 ~-1 ~11 grass_block
# the banner dissolves in quest 12 (s1/e11/anim) and stays gone afterwards (the platform is where it stood)
$execute if score @s tut_sec matches 1 unless score @s tut_ex matches 11 positioned $(px) 100 0 unless block ~20 ~3 ~-4 magma_block run function tut:internal/banner_rel
# RESET ALL QUESTS post only in the finished state
$execute if score @s tut_end matches 1.. positioned $(px) 100 0 if block ~1 ~-2 ~6 bedrock unless block ~1 ~ ~2 oak_log run function tut:internal/reset_post_rel
$execute unless score @s tut_end matches 1.. positioned $(px) 100 0 if block ~1 ~ ~2 oak_log run function tut:internal/reset_post_clear_rel
$execute positioned $(px) 100 0 unless block ~-29 ~-2 ~6 bedrock run function tut:internal/path_rel
$execute positioned $(px) 100 0 if block ~-29 ~-1 ~6 stone run fill ~-30 ~-1 ~4 ~-1 ~-1 ~8 stone_bricks
# after section 1, island 1 keeps its quest-11 area (bridge + platform + cage); floors go in as stone and get
# their colour next tick (light update), same as s1/e11/tick does during the quest
$execute if score @s tut_sec matches 2.. positioned $(px) 100 0 if block ~1 ~-2 ~6 bedrock unless block ~26 ~0 ~5 gold_block run function tut:s1/e11/build
$execute if score @s tut_sec matches 2.. positioned $(px) 100 0 if block ~13 ~-1 ~5 stone run fill ~12 ~-1 ~4 ~15 ~-1 ~6 stone_bricks
$execute if score @s tut_sec matches 2.. positioned $(px) 100 0 if block ~18 ~-1 ~5 stone run fill ~16 ~-1 ~-4 ~35 ~-1 ~15 grass_block
# island 2 (see island2_rel), only while the player is there (tut_end 2; its chunks are unloaded otherwise):
# build until its marker exists, then recolour the floor, then the banner
$execute if score @s tut_end matches 2 positioned $(px) 100 1024 unless block ~1 ~-2 ~18 bedrock run function tut:internal/island2_rel
$execute if score @s tut_end matches 2 positioned $(px) 100 1024 if block ~1 ~-1 ~18 stone run function tut:internal/island2_recolor_rel
$execute if score @s tut_end matches 2 positioned $(px) 100 1024 if block ~1 ~-2 ~18 bedrock unless block ~44 ~3 ~6 verdant_froglight run function tut:internal/banner2_rel
# the blue block was a sea lantern, then glowstone, for an hour on 2026-10-12: swap existing ones
$execute if score @s tut_end matches 2 positioned $(px) 100 1024 if block ~12 ~-1 ~18 sea_lantern run setblock ~12 ~-1 ~18 blue_concrete
$execute if score @s tut_end matches 2 positioned $(px) 100 1024 if block ~12 ~-1 ~18 glowstone run setblock ~12 ~-1 ~18 blue_concrete
$execute if score @s tut_end matches 2 positioned $(px) 100 1024 if block ~12 ~-1 ~18 blue_wool run setblock ~12 ~-1 ~18 blue_concrete
