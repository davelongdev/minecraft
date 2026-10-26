function arena:internal/build2
scoreboard players set built arena_tmp 100
kill @e[distance=0..,type=item]
execute as @a[distance=0..] run function arena:internal/to_stands
tellraw @a[distance=0..] {"text":"The PvP Arena is ready!","color":"gold"}
