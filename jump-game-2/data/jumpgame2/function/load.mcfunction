# Runs once when the pack loads (or on /reload)
scoreboard objectives add jumps minecraft.custom:minecraft.jump "Jumps"
scoreboard objectives add jg2_cd dummy
scoreboard objectives add jg2_cds dummy
scoreboard players set #twenty jg2_cds 20
scoreboard objectives setdisplay sidebar jumps
tellraw @a {"text":"Jump game 2 loaded! Jump 5 times for a boost (10s cooldown).","color":"green"}
