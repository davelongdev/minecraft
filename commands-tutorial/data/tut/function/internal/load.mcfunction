# Runs on every /reload. Everything here is idempotent.
scoreboard objectives add tut_init dummy
scoreboard objectives add tut_joined dummy
scoreboard objectives add tut_id dummy
scoreboard objectives add tut_px dummy
scoreboard objectives add tut_sec dummy
scoreboard objectives add tut_ex dummy
scoreboard objectives add tut_tick dummy
scoreboard objectives add tut_tmp dummy
scoreboard objectives add tut_last dummy
scoreboard objectives add tut_const dummy
scoreboard objectives add tut_lp dummy
scoreboard objectives add tut_parts dummy
scoreboard objectives add tut_flag dummy
scoreboard objectives add tut_quests dummy {"font":"minecraft:uniform","text":"Quests completed","color":"gold","bold":true}
scoreboard objectives modify tut_quests displayname {"font":"minecraft:uniform","text":"Quests completed","color":"gold","bold":true}
scoreboard objectives setdisplay sidebar tut_quests
# sidebar tip lines from an earlier version: clear them from existing worlds
scoreboard players reset tip_a tut_quests
scoreboard players reset tip_b tut_quests
scoreboard objectives add tut_btn trigger

# constants: plot spacing, last exercise index per section, number of sections built
scoreboard players set c128 tut_const 128
scoreboard players set s1 tut_const 9
scoreboard players set maxsec tut_const 1

# hidden sandbox chunk for later sections' checks
forceload add -1024 -1024

scoreboard players enable @a tut_btn

# a tip boss bar existed in an earlier version: remove it from existing worlds
bossbar remove tut:tip

execute unless score global tut_init matches 1 run function tut:internal/init
