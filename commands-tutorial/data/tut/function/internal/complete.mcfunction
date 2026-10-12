# Called from an exercise tick when its check passes.
title @s times 5 40 10
title @s subtitle {"font":"minecraft:uniform","text":""}
title @s title {"font":"minecraft:uniform","text":"Great job!","color":"green","bold":true}
execute at @s run playsound minecraft:entity.player.levelup master @s ~ ~ ~ 1 1
execute at @s run particle minecraft:totem_of_undying ~ ~1 ~ 0.5 0.5 0.5 0.1 40 normal @s
scoreboard players add @s tut_ex 1
# quests done = furthest quest reached (so redoing one via PREVIOUS doesn't double count)
execute if score @s tut_ex > @s tut_quests run scoreboard players operation @s tut_quests = @s tut_ex
scoreboard players set @s tut_tick 0
scoreboard players set @s tut_lp 0
scoreboard players set @s tut_last -1
$execute if score @s tut_ex > s$(sec) tut_const run function tut:internal/section_complete with storage tut:main args
