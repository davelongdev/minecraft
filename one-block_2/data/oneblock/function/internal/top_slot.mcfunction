# One leaderboard slot for ___top_times: find the fastest remaining ob_work,
# print that player's line, remove them from the pool. No-op when the pool is
# empty (fewer than 5 recorded times).
execute unless entity @a[scores={ob_work=1..}] run return 0
scoreboard players set min ob_work 2147483647
execute as @a[scores={ob_work=1..}] run scoreboard players operation min ob_work < @s ob_work
execute as @a[scores={ob_work=1..}] if score @s ob_work = min ob_work run function oneblock:internal/top_line
