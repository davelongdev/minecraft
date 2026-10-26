scoreboard players add @a[distance=0..] tut_joined 0
execute as @a[distance=0..,scores={tut_joined=..0}] run function tut:internal/join
execute as @a[distance=0..,scores={tut_joined=1}] at @s run function tut:internal/player_tick
# dev: ___rr tagged someone before reloading; finish their reset with the new code
execute as @a[distance=0..,tag=tut_rr] run function tut:internal/rr_apply
execute as @a[distance=0..,tag=tut_rq] run function tut:internal/rq_apply
# medal stars next to the top 3 names (team prefixes), refreshed once a second
scoreboard players add clock tut_const 1
execute if score clock tut_const matches 20.. run scoreboard players set clock tut_const 0
execute if score clock tut_const matches 0 run function tut:internal/rank_teams
