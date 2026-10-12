# One medal: the highest-scoring unranked online player with at least 1 point joins the team for this rank.
scoreboard players set max tut_work 0
execute as @a[tag=!tut_ranked] run scoreboard players operation max tut_work > @s tut_work
tag @a remove tut_pick
execute if score max tut_work matches 1.. as @a[tag=!tut_ranked] if score @s tut_work = max tut_work run tag @s add tut_pick
execute as @a[tag=tut_pick,limit=1] run function tut:internal/rank_assign
