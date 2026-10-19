# Macro (px). State 3: pitch black in the room, pinned in place, waiting for the space bar (a jump).
effect give @s minecraft:blindness 5 0 true
effect give @s minecraft:darkness 5 0 true
effect give @s minecraft:slowness 5 6 true
$execute unless score @s tut_jump matches 1.. positioned $(px) 100 0 unless block ~-27 ~ ~6 black_concrete run function tut:internal/dark_room_rel
# space: the room goes, the walkway's end comes back, and they walk
$execute if score @s tut_jump matches 1.. positioned $(px) 100 0 run function tut:internal/dark_room_clear_rel
execute if score @s tut_jump matches 1.. run function tut:internal/intro_go
