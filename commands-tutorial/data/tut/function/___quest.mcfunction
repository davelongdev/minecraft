# Print the current quest part again (same as the QUEST button).
function tut:internal/store_args
execute if score @s tut_lp matches ..0 run scoreboard players set @s tut_lp 1
execute store result storage tut:main args.part int 1 run scoreboard players get @s tut_lp
function tut:internal/show_part with storage tut:main args
