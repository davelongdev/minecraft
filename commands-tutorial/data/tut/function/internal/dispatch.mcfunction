# Route to the current exercise. Exercise functions run positioned at the island origin.
$execute if score @s tut_tick matches 1 positioned $(px) 100 0 run function tut:s$(sec)/e$(ex)/start
$execute positioned $(px) 100 0 run function tut:s$(sec)/e$(ex)/tick
# the quest-10 area must not linger on other quests (however the player left quest 10)
$execute unless score @s tut_ex matches 9 positioned $(px) 100 0 if block ~5 ~0 ~26 gold_block run function tut:s1/e9/clear
# leftovers from older layouts of the cage (island corner; small platform at z 16..27)
$execute positioned $(px) 100 0 if block ~9 ~0 ~9 gold_block run fill ~8 ~0 ~8 ~10 ~3 ~10 air
$execute positioned $(px) 100 0 if block ~7 ~0 ~10 dark_oak_sign run setblock ~7 ~0 ~10 air
$execute positioned $(px) 100 0 if block ~5 ~0 ~21 gold_block run function tut:s1/e9/clear
