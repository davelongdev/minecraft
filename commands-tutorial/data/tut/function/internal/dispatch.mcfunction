# Route to the current exercise. Exercise functions run positioned at the section's quest origin
# (args.pz: island 1 = z 0, section 2 = z 1036 on island 2; see internal/store_args).
$execute if score @s tut_tick matches 1 positioned $(px) 100 $(pz) run function tut:s$(sec)/e$(ex)/start
$execute positioned $(px) 100 $(pz) run function tut:s$(sec)/e$(ex)/tick
# section 2: the quest sign again a bit later (island 2's chunks may not have been loaded when start ran)
$execute if score @s tut_sec matches 2.. if score @s tut_tick matches 40 positioned $(px) 100 $(pz) run function tut:s$(sec)/e$(ex)/title
# the quest-11 area must not linger on other quests (however the player left quest 12)
$execute if score @s tut_sec matches 1 unless score @s tut_ex matches 11 positioned $(px) 100 0 if block ~26 ~0 ~5 gold_block run function tut:s1/e11/clear
# quest 9's barrier wall must not linger either (marker: the west wall's middle at the top)
$execute if score @s tut_sec matches 1 unless score @s tut_ex matches 8 positioned $(px) 100 0 if block ~-1 ~20 ~6 barrier run function tut:s1/e8/wall_clear
$execute if score @s tut_sec matches 2.. positioned $(px) 100 0 if block ~-1 ~20 ~6 barrier run function tut:s1/e8/wall_clear
# leftovers from older layouts of the cage (island corner; platforms south of the island)
$execute positioned $(px) 100 0 if block ~9 ~0 ~9 gold_block run fill ~8 ~0 ~8 ~10 ~3 ~10 air
$execute positioned $(px) 100 0 if block ~7 ~0 ~10 dark_oak_sign run setblock ~7 ~0 ~10 air
$execute positioned $(px) 100 0 if block ~5 ~0 ~21 gold_block run fill ~-4 ~-1 ~12 ~15 ~5 ~35 air
$execute positioned $(px) 100 0 if block ~5 ~0 ~26 gold_block run fill ~-4 ~-1 ~12 ~15 ~5 ~35 air
$execute positioned $(px) 100 0 unless block ~4 ~ ~11 oak_fence unless block ~5 ~0 ~26 gold_block unless block ~5 ~0 ~21 gold_block run fill ~4 ~ ~11 ~6 ~ ~11 oak_fence
