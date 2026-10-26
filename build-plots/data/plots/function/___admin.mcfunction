# Teacher toggle: creative everywhere (no plot check) / back to normal.
execute if entity @s[tag=plot_admin] run return run function plots:internal/admin_off
tag @s add plot_admin
gamemode creative @s
tellraw @s {"text":"Admin on: creative everywhere. Run again to turn it off.","color":"gold"}
