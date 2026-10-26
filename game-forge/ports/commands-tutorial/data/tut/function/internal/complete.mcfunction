# Called from an exercise tick when its check passes.
title @s times 5 40 10
title @s subtitle {"font":"minecraft:uniform","text":""}
title @s title {"font":"minecraft:uniform","text":"Great job!","color":"green","bold":true}
execute at @s run playsound minecraft:entity.player.levelup master @s ~ ~ ~ 1 1
execute at @s run particle minecraft:totem_of_undying ~ ~1 ~ 0.5 0.5 0.5 0.1 40 normal @s
scoreboard players add @s tut_ex 1
# quests done = furthest quest reached over all sections (so redoing one via PREVIOUS doesn't double count);
# section 2 counts on top of section 1's 12 (n1 tut_const)
scoreboard players operation @s tut_tmp = @s tut_ex
execute if score @s tut_sec matches 2.. run scoreboard players operation @s tut_tmp += n1 tut_const
execute if score @s tut_tmp > @s tut_quests run scoreboard players operation @s tut_quests = @s tut_tmp
# (points are derived from tut_quests every tick in player_tick)
scoreboard players set @s tut_tick 0
scoreboard players set @s tut_lp 0
scoreboard players set @s tut_pp -1
scoreboard players set @s tut_last -1
# the Little Command Book arrives after quest 2 and gains a note for every quest completed (tools/gen_book.py)
execute if score @s tut_quests matches 2.. run function tut:internal/give_book
$execute if score @s tut_ex > s$(sec) tut_const run function tut:internal/section_complete with storage tut:main args
