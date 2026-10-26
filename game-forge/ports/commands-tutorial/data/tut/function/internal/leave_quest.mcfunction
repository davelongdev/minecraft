# Macro (px, sec, ex). Per-quest cleanup when moving away from the current quest
# (___previous, ___goto). Only quest 12 (s1/e11) has anything to tear down.
$execute if score @s tut_sec matches 1 if score @s tut_ex matches 11 positioned $(px) 100 0 run function tut:s1/e11/clear
