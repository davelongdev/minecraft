# Teacher: jump to an exercise (0-based). Run as the kid: /execute as Name run function tut:___goto {sec:1,ex:3}
# Friendlier: ___goto_quest {q:"1.4"} (section.quest, 1-based).
function tut:internal/store_args
function tut:internal/leave_quest with storage tut:main args
$scoreboard players set @s tut_sec $(sec)
$scoreboard players set @s tut_ex $(ex)
function tut:internal/goto_apply
