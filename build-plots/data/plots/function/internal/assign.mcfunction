# First join: the next free plot number, its edges, then home.
scoreboard players add next plot_tmp 1
scoreboard players operation @s plot_id = next plot_tmp
scoreboard players operation #c plot_tmp = @s plot_id
scoreboard players remove #c plot_tmp 1
scoreboard players operation #r plot_tmp = #c plot_tmp
scoreboard players operation #c plot_tmp %= c5 plot_tmp
scoreboard players operation #r plot_tmp /= c5 plot_tmp
scoreboard players operation #c plot_tmp *= c40 plot_tmp
scoreboard players operation #r plot_tmp *= c40 plot_tmp
scoreboard players operation @s plot_x = #c plot_tmp
scoreboard players add @s plot_x 8
scoreboard players operation @s plot_z = #r plot_tmp
scoreboard players add @s plot_z 8
scoreboard players set @s plot_ok 0
function plots:internal/go_home
tellraw @s ""
tellraw @s [{"text":"Welcome! This is your plot: ","color":"gold"},{"text":"Plot ","color":"yellow"},{"score":{"name":"@s","objective":"plot_id"},"color":"yellow"}]
tellraw @s {"text":"You can build inside your plot. Everywhere else you can look around but not build.","color":"white"}
tellraw @s [{"text":"/trigger home","color":"aqua"},{"text":" - back to your plot","color":"white"}]
tellraw @s [{"text":"/trigger plots","color":"aqua"},{"text":" - who has which plot","color":"white"}]
