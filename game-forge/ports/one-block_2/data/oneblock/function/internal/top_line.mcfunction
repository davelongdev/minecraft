# Print one ranked leaderboard line (as the ranked player), then consume the
# entry. Lowering min first means tied players don't double-print in the same
# slot — the next slot picks them up.
scoreboard players set min ob_work -2147483648
scoreboard players add rank ob_work 1
scoreboard players operation @s ob_ds = @s ob_work
scoreboard players operation @s ob_ds /= c20 ob_timer
scoreboard players operation @s ob_dt = @s ob_work
scoreboard players operation @s ob_dt %= c20 ob_timer
scoreboard players operation @s ob_dt /= c2 ob_timer
# ob_id unset -> the failed get stores 0, which matches no name entry
execute store result storage oneblock:main args.id int 1 run scoreboard players get @s ob_id
function oneblock:internal/top_line_print with storage oneblock:main args
scoreboard players reset @s ob_work
