# Border + sign for @s's plot, once its chunks are loaded (fill into unloaded chunks fails silently).
scoreboard players operation #t plot_tmp = @s plot_x
scoreboard players remove #t plot_tmp 1
execute store result storage plots:tmp args.xa int 1 run scoreboard players get #t plot_tmp
scoreboard players add #t plot_tmp 33
execute store result storage plots:tmp args.xb int 1 run scoreboard players get #t plot_tmp
scoreboard players remove #t plot_tmp 17
execute store result storage plots:tmp args.xs int 1 run scoreboard players get #t plot_tmp
scoreboard players operation #t plot_tmp = @s plot_z
scoreboard players remove #t plot_tmp 1
execute store result storage plots:tmp args.za int 1 run scoreboard players get #t plot_tmp
scoreboard players add #t plot_tmp 33
execute store result storage plots:tmp args.zb int 1 run scoreboard players get #t plot_tmp
scoreboard players remove #t plot_tmp 34
execute store result storage plots:tmp args.zs int 1 run scoreboard players get #t plot_tmp
execute store result storage plots:tmp args.n int 1 run scoreboard players get @s plot_id
function plots:internal/build_border with storage plots:tmp args
