# stood on the target pad since the quest started (tick sets the flag; the player presses the button far from the pad)
execute if score @s tut_cage matches 1 run return 1
execute positioned ~29 ~ ~5 if entity @s[dx=2,dy=2,dz=2] run return 1
return fail
