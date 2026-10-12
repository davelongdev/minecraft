# Dev: toggle dev mode for this world (persists across reloads). While on,
# space (jump) runs ___rq (reload + restart quest) and shift + space runs ___rr
# (reload + reset yourself). Keep it OFF in class.
scoreboard players add dev tut_const 0
execute if score dev tut_const matches 1 run scoreboard players set dev tut_const 2
execute if score dev tut_const matches 0 run scoreboard players set dev tut_const 1
execute if score dev tut_const matches 2 run scoreboard players set dev tut_const 0
execute if score dev tut_const matches 1 run tellraw @s {"font":"minecraft:uniform","text":"Dev mode ON: space = reload + restart quest, shift + space = reload + reset yourself.","color":"aqua"}
execute if score dev tut_const matches 0 run tellraw @s {"font":"minecraft:uniform","text":"Dev mode OFF.","color":"gray"}
