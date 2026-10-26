# As a player: 1 if their view or position changed since internal/view_mark, else fail.
execute store result score #r tut_tmp run data get entity @s Rotation[0] 100
execute unless score #r tut_tmp = @s tut_ry run return 1
execute store result score #r tut_tmp run data get entity @s Rotation[1] 100
execute unless score #r tut_tmp = @s tut_rp run return 1
execute store result score #r tut_tmp run data get entity @s Pos[0] 10
execute unless score #r tut_tmp = @s tut_rx run return 1
execute store result score #r tut_tmp run data get entity @s Pos[2] 10
execute unless score #r tut_tmp = @s tut_rz run return 1
return fail
