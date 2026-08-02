# Runs as each player whose cooldown is active; jumps don't count until it hits 0
scoreboard players remove @s jg2_cd 1
scoreboard players set @s jumps 0
# Buff lasts 5s of the 10s cooldown; drop the jump-height bonus when it ends
execute if score @s jg2_cd matches 100 run attribute @s minecraft:jump_strength modifier remove jumpgame2:jump_higher
# Seconds remaining, rounded up: (ticks + 19) / 20
scoreboard players operation @s jg2_cds = @s jg2_cd
scoreboard players add @s jg2_cds 19
scoreboard players operation @s jg2_cds /= #twenty jg2_cds
execute if score @s jg2_cd matches 1.. run title @s actionbar ["",{"text":"Boost ready in ","color":"gray"},{"score":{"name":"@s","objective":"jg2_cds"},"color":"yellow"},{"text":"s","color":"gray"}]
execute if score @s jg2_cd matches ..0 run title @s actionbar {"text":"Boost ready — jumps count again!","color":"green"}
execute if score @s jg2_cd matches ..0 run playsound minecraft:block.note_block.pling master @s
execute if score @s jg2_cd matches ..0 run tellraw @s {"text":"Jump 5 times for a boost (10s cooldown).","color":"green"}
