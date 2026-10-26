# Where is @s relative to their own plot? Plots are all at positive x/z, so truncating Pos is fine.
execute store result score @s plot_px run data get entity @s Pos[0]
execute store result score @s plot_pz run data get entity @s Pos[2]
scoreboard players operation @s plot_px -= @s plot_x
scoreboard players operation @s plot_pz -= @s plot_z
scoreboard players set #in plot_tmp 0
execute if score @s plot_px matches 0..31 if score @s plot_pz matches 0..31 run scoreboard players set #in plot_tmp 1
execute if score #in plot_tmp matches 1 if entity @s[gamemode=!creative] run function plots:internal/to_creative
execute if score #in plot_tmp matches 0 if entity @s[gamemode=!adventure] run function plots:internal/to_adventure
