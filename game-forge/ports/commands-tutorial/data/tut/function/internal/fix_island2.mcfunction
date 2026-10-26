# Macro (px). Rebuild island 2 (section 2 placeholder) from scratch and put the player on it.
# The player is teleported first so the chunks are loaded when the fills run.
$execute positioned $(px) 100 1024 run tp @s ~1.5 ~ ~18.5 -90 0
$execute positioned $(px) 100 1024 run spawnpoint @s ~1 ~ ~18
# signs/buttons first so they don't drop as items when their support goes, then everything else
$execute positioned $(px) 100 1024 run fill ~ ~ ~ ~35 ~2 ~35 air
$execute positioned $(px) 100 1024 run fill ~ ~-2 ~ ~35 ~20 ~35 air
# current banner plane (x 44) and the old 12x12-era banner plane (x 20)
$execute positioned $(px) 100 1024 run fill ~44 ~2 ~1 ~44 ~15 ~34 air
$execute positioned $(px) 100 1024 run fill ~20 ~2 ~-11 ~20 ~15 ~22 air
$execute positioned $(px) 100 1024 run kill @e[type=item,distance=..80]
$execute positioned $(px) 100 1024 run function tut:internal/island2_rel
