# 6-second cycle: group A up 0..39, flames over B 41..59, B up 60..99, flames over A 101..119.
scoreboard players set pads_on arena_tmp 1
scoreboard players add timer arena_tmp 1
execute if score timer arena_tmp matches 120.. run scoreboard players set timer arena_tmp 0
execute if score timer arena_tmp matches 0 run function arena:internal/pads_up_a
execute if score timer arena_tmp matches 40 run function arena:internal/pads_down_a
execute if score timer arena_tmp matches 60 run function arena:internal/pads_up_b
execute if score timer arena_tmp matches 100 run function arena:internal/pads_down_b
execute if score timer arena_tmp matches 41..59 run function arena:internal/pads_warn_b
execute if score timer arena_tmp matches 101..119 run function arena:internal/pads_warn_a
execute if score timer arena_tmp matches 41 as @a[tag=arena_fighter] at @s run playsound minecraft:block.note_block.pling master @s ~ ~ ~ 1 0.7
execute if score timer arena_tmp matches 101 as @a[tag=arena_fighter] at @s run playsound minecraft:block.note_block.pling master @s ~ ~ ~ 1 0.7
