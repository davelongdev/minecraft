# Teacher: reset every online player. Offline players are reset the next time they join only if you run this again.
execute as @a run function tut:___reset_player
fill -1024 0 -1024 -1009 0 -1009 bedrock
function tut:internal/hub_sign
tellraw @a {"font":"minecraft:uniform","text":"The world was reset. Everyone's back at the start!","color":"aqua"}
