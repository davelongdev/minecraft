# Runs on every load/reload.
# Plots are 32x32, five per row, 40 apart (8-block roads, wider than creative reach), on the superflat
# surface (grass at y -61). Plot n: col = (n-1) % 5, row = (n-1) / 5, west edge x = 8 + 40*col,
# north edge z = 8 + 40*row.
# plot_id = permanent plot number, plot_x/plot_z = its west/north edge, plot_ok = 1 once its border is built,
# plot_px/plot_pz = scratch (position relative to the plot). plot_tmp fake players: next = last plot handed out,
# c5/c40 = constants, #c/#r/#t = scratch.
scoreboard objectives add plot_tmp dummy
scoreboard objectives add plot_id dummy
scoreboard objectives add plot_x dummy
scoreboard objectives add plot_z dummy
scoreboard objectives add plot_ok dummy
scoreboard objectives add plot_px dummy
scoreboard objectives add plot_pz dummy
scoreboard objectives add home trigger
scoreboard objectives add plots trigger
scoreboard players set c5 plot_tmp 5
scoreboard players set c40 plot_tmp 40
scoreboard players add next plot_tmp 0
