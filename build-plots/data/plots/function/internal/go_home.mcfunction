# To the middle of your plot, facing south.
scoreboard players operation #t plot_tmp = @s plot_x
scoreboard players add #t plot_tmp 16
execute store result storage plots:tmp args.x int 1 run scoreboard players get #t plot_tmp
scoreboard players operation #t plot_tmp = @s plot_z
scoreboard players add #t plot_tmp 16
execute store result storage plots:tmp args.z int 1 run scoreboard players get #t plot_tmp
function plots:internal/go_home_at with storage plots:tmp args
