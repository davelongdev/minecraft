# Macro (sec): keep tut_ex within the section's quests.
$execute if score @s tut_ex > s$(sec) tut_const run scoreboard players operation @s tut_ex = s$(sec) tut_const
