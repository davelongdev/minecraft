# Remove all nine tiles: /function tile:___clear_board
fill -4 64 -4 4 66 4 air
kill @e[type=item,distance=..20]
tellraw @s {"text":"Board cleared.","color":"yellow"}
