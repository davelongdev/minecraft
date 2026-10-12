# Edge-triggered island buttons (positioned at the island origin).
# right (z8) = QUEST: press 1 prints part 1, press 2 part 2, ... (extra presses repeat the last part)
$execute positioned $(px) 100 0 if block ~7 ~1 ~8 stone_button[powered=true] unless entity @s[tag=tut_pressed] unless score @s tut_sec > maxsec tut_const run scoreboard players add @s tut_lp 1
execute if score @s tut_parts matches 1.. if score @s tut_lp > @s tut_parts run scoreboard players operation @s tut_lp = @s tut_parts
execute store result storage tut:main args.part int 1 run scoreboard players get @s tut_lp
$execute positioned $(px) 100 0 if block ~7 ~1 ~8 stone_button[powered=true] unless entity @s[tag=tut_pressed] unless score @s tut_sec > maxsec tut_const run function tut:internal/show_part with storage tut:main args
$execute positioned $(px) 100 0 if block ~7 ~1 ~8 stone_button[powered=true] run tag @s add tut_pressed
$execute positioned $(px) 100 0 unless block ~7 ~1 ~8 stone_button[powered=true] run tag @s remove tut_pressed
# middle (z4) = next quest: completes the current quest if its check passes, else says so
$execute positioned $(px) 100 0 if block ~7 ~1 ~4 stone_button[powered=true] unless entity @s[tag=tut_done] unless score @s tut_sec > maxsec tut_const if function tut:s$(sec)/e$(ex)/check run function tut:internal/complete with storage tut:main args
$execute positioned $(px) 100 0 if block ~7 ~1 ~4 stone_button[powered=true] unless entity @s[tag=tut_done] unless score @s tut_sec > maxsec tut_const unless function tut:s$(sec)/e$(ex)/check run tellraw @s [{"font":"minecraft:uniform","text":"Quest not completed yet! ","color":"red","bold":true},{"font":"minecraft:uniform","text":"Press the QUEST button to see what to do.","color":"red","bold":false}]
$execute positioned $(px) 100 0 if block ~7 ~1 ~4 stone_button[powered=true] unless entity @s[tag=tut_done] if score @s tut_sec > maxsec tut_const run tellraw @s [{"font":"minecraft:uniform","text":"You finished every quest built so far!","color":"light_purple"}]
$execute positioned $(px) 100 0 if block ~7 ~1 ~4 stone_button[powered=true] run tag @s add tut_done
$execute positioned $(px) 100 0 unless block ~7 ~1 ~4 stone_button[powered=true] run tag @s remove tut_done
# left (z2) = previous lesson
$execute positioned $(px) 100 0 if block ~7 ~1 ~2 stone_button[powered=true] unless entity @s[tag=tut_prev] run function tut:___previous
$execute positioned $(px) 100 0 if block ~7 ~1 ~2 stone_button[powered=true] run tag @s add tut_prev
$execute positioned $(px) 100 0 unless block ~7 ~1 ~2 stone_button[powered=true] run tag @s remove tut_prev
