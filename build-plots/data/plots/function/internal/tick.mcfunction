execute as @a unless score @s plot_id matches 1.. run function plots:internal/assign
execute as @a[scores={plot_ok=0}] run function plots:internal/try_build
# creative inside your own plot, adventure everywhere else (plot_admin: creative everywhere)
execute as @a[tag=!plot_admin,gamemode=!spectator] run function plots:internal/check
execute as @a[scores={home=1..}] run function plots:internal/go_home
execute as @a[scores={plots=1..}] run function plots:internal/list
scoreboard players reset @a home
scoreboard players reset @a plots
scoreboard players enable @a home
scoreboard players enable @a plots
