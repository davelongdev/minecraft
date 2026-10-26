function arena:internal/build2
scoreboard players set built arena_tmp 100
kill @e[type=item]
execute as @a run function arena:internal/to_stands
tellraw @a {"text":"The PvP Arena is ready!","color":"gold"}
