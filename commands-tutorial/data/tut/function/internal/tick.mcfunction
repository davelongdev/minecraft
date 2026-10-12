scoreboard players add @a tut_joined 0
execute as @a[scores={tut_joined=..0}] run function tut:internal/join
execute as @a[scores={tut_joined=1}] at @s run function tut:internal/player_tick
# dev: ___rr tagged someone before reloading; finish their reset with the new code
execute as @a[tag=tut_rr] run function tut:internal/rr_apply
execute as @a[tag=tut_rq] run function tut:internal/rq_apply
