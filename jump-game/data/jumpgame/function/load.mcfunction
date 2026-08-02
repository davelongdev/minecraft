# Runs once when the pack loads (or on /reload)
scoreboard objectives add jumps minecraft.custom:minecraft.jump "Jumps"
scoreboard objectives setdisplay sidebar jumps
tellraw @a {"text":"Jump game loaded! Jump 10 times for a surprise.","color":"green"}
