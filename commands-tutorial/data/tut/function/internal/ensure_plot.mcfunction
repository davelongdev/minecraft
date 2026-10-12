$execute positioned $(px) 100 0 unless block ~1 ~-2 ~6 bedrock run function tut:internal/build_plot_rel
$execute positioned $(px) 100 0 if block ~1 ~-1 ~6 stone run fill ~ ~-1 ~ ~11 ~-1 ~11 grass_block
$execute positioned $(px) 100 0 unless block ~20 ~3 ~-4 magma_block run function tut:internal/banner_rel
$execute positioned $(px) 100 0 unless block ~-29 ~-2 ~6 bedrock run function tut:internal/path_rel
$execute positioned $(px) 100 0 if block ~-29 ~-1 ~6 stone run fill ~-30 ~-1 ~4 ~-1 ~-1 ~8 stone_bricks
