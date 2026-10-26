$execute unless score @s tut_end matches 2 positioned $(px) 100 0 run tp @s ~1.5 ~ ~6.5 -90 0
$execute if score @s tut_end matches 2 positioned $(px) 100 1024 run tp @s ~1.5 ~ ~18.5 -90 0
tellraw @s {"font":"minecraft:uniform","text":"Whoops, the void! I caught you.","color":"aqua"}
