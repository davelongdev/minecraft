# State 3: pitch black, pinned in place, waiting for the space bar (a jump).
effect give @s minecraft:blindness 5 0 true
effect give @s minecraft:darkness 5 0 true
effect give @s minecraft:slowness 5 6 true
execute if score @s tut_jump matches 1.. run function tut:internal/intro_go
