# A quest part is still printing (tut_pp >= 0): advance it one step (a tick for timed
# parts, a block for space-paced parts) and run the part function again.
scoreboard players add @s tut_pp 1
execute store result storage tut:main args.part int 1 run scoreboard players get @s tut_lp
function tut:internal/print_part with storage tut:main args
