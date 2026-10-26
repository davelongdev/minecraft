# Teacher: jump to a quest by section.quest, 1-based. Run as the kid:
#   /execute as Name run function tut:___goto_quest {q:"1.4"}     (section 1, quest 4)
# Quotes are optional for single-digit quests (1.4); quests 10 and 11 need them ("1.10"), since 1.10 as a number is 1.1.
function tut:internal/store_args
function tut:internal/leave_quest with storage tut:main args
# split "s.q" at the dot: section = first character, quest = everything after the dot
$data modify storage tut:main g.q set value "$(q)"
data modify storage tut:main g.sec set string storage tut:main g.q 0 1
data modify storage tut:main g.ex set string storage tut:main g.q 2
function tut:internal/goto_set with storage tut:main g
scoreboard players remove @s tut_ex 1
function tut:internal/goto_apply
