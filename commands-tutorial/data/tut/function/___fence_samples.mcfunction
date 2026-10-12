# Temporary (2026-10-12): show candidate edge blocks for island 2, east of spawn. Remove with ___fix_island.
function tut:internal/store_args
function tut:internal/fence_samples with storage tut:main args
tellraw @s {"font":"minecraft:uniform","text":"Samples placed east of you. /function tut:___fix_island removes them.","color":"gray"}
