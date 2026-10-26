# Edge-triggered island buttons. The quest posts (SHOW QUEST, PREVIOUS QUEST; NEXT QUEST was removed 2026-10-26,
# quests now complete on their own in internal/auto_check) are positioned at the section's quest origin
# (args.pz: island 1 = z 0, section 2 = z 1036 on island 2); the finish post and GO BACK post are fixed.
# right (z8) = QUEST: press 1 prints part 1, press 2 part 2, ... (extra presses repeat the last part)
$execute positioned $(px) 100 $(pz) if block ~7 ~1 ~8 stone_button[powered=true] unless entity @s[tag=tut_pressed] unless score @s tut_sec > maxsec tut_const run scoreboard players add @s tut_lp 1
execute if score @s tut_parts matches 1.. if score @s tut_lp > @s tut_parts run scoreboard players operation @s tut_lp = @s tut_parts
execute store result storage tut:main args.part int 1 run scoreboard players get @s tut_lp
$execute positioned $(px) 100 $(pz) if block ~7 ~1 ~8 stone_button[powered=true] unless entity @s[tag=tut_pressed] unless score @s tut_sec > maxsec tut_const run function tut:internal/show_part with storage tut:main args
$execute positioned $(px) 100 $(pz) if block ~7 ~1 ~8 stone_button[powered=true] run tag @s add tut_pressed
$execute positioned $(px) 100 $(pz) unless block ~7 ~1 ~8 stone_button[powered=true] run tag @s remove tut_pressed
# left (z4) = previous lesson
$execute positioned $(px) 100 $(pz) if block ~7 ~1 ~4 stone_button[powered=true] unless entity @s[tag=tut_prev] run function tut:___previous
$execute positioned $(px) 100 $(pz) if block ~7 ~1 ~4 stone_button[powered=true] run tag @s add tut_prev
$execute positioned $(px) 100 $(pz) unless block ~7 ~1 ~4 stone_button[powered=true] run tag @s remove tut_prev
# finish post (7,6; exists only after quest 11's cage visit, tut_end 1..) = TP TO NEXT ISLAND
$execute positioned $(px) 100 0 if block ~7 ~1 ~6 stone_button[powered=true] unless entity @s[tag=tut_fin] if score @s tut_end matches 1.. run function tut:internal/next_island with storage tut:main args
$execute positioned $(px) 100 0 if block ~7 ~1 ~6 stone_button[powered=true] run tag @s add tut_fin
$execute positioned $(px) 100 0 unless block ~7 ~1 ~6 stone_button[powered=true] run tag @s remove tut_fin
# island 2 (px, 100, 1024; 36x36), post at 1,11 (west edge, sign faces east) = GO BACK TO FIRST ISLAND
$execute positioned $(px) 100 1024 if block ~1 ~1 ~11 stone_button[powered=true] unless entity @s[tag=tut_back] run function tut:internal/back_island1 with storage tut:main args
$execute positioned $(px) 100 1024 if block ~1 ~1 ~11 stone_button[powered=true] run tag @s add tut_back
$execute positioned $(px) 100 1024 unless block ~1 ~1 ~11 stone_button[powered=true] run tag @s remove tut_back
# island 1 west edge, post at 1,2 (finished state only) = RESET ALL QUESTS (two presses within 5 s; internal/reset_press)
$execute positioned $(px) 100 0 if block ~1 ~1 ~2 stone_button[powered=true] unless entity @s[tag=tut_rst] if score @s tut_end matches 1.. run function tut:internal/reset_press
$execute positioned $(px) 100 0 if block ~1 ~1 ~2 stone_button[powered=true] run tag @s add tut_rst
$execute positioned $(px) 100 0 unless block ~1 ~1 ~2 stone_button[powered=true] run tag @s remove tut_rst
