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
# chat_count: chat messages per player, counted by the studio server's chat-counter mod, which also keeps
# #mod chat_count at 1 every tick. Reset here so a world copied to singleplayer (no mod) knows it's missing.
scoreboard objectives add chat_count dummy
# quest 1: view/position when the [Done!] link was clicked (s1/e0/done)
scoreboard objectives add tut_ry dummy
scoreboard objectives add tut_rp dummy
scoreboard objectives add tut_rx dummy
scoreboard objectives add tut_rz dummy
scoreboard players reset #mod chat_count
scoreboard objectives add tut_walk dummy
scoreboard objectives add tut_wx dummy
scoreboard objectives add tut_pp dummy
scoreboard objectives add tut_pm dummy
scoreboard objectives add tut_jump minecraft.custom:minecraft.jump
scoreboard objectives add tut_book minecraft.used:minecraft.written_book
scoreboard objectives add tut_sneak dummy
scoreboard objectives add tut_cage dummy
scoreboard objectives add tut_end dummy
scoreboard objectives add tut_arm dummy
scoreboard objectives add tut_tx dummy
scoreboard objectives add tut_work dummy
scoreboard objectives add tut_quests dummy
# sidebar = points (tut_pts; 1 per section 1 quest, 2 per section 2 quest, see internal/complete); tut_quests = furthest quest (book level)
scoreboard objectives add tut_pts dummy {"font":"minecraft:uniform","text":"Leaderboard","color":"gold","bold":true}
scoreboard objectives modify tut_pts displayname {"font":"minecraft:uniform","text":"Leaderboard","color":"gold","bold":true}
# [game-forge: set world-wide by the game-forge pack] scoreboard objectives setdisplay sidebar tut_pts
# sidebar tip lines from an earlier version: clear them from existing worlds
scoreboard players reset tip_a tut_quests
scoreboard players reset tip_b tut_quests
scoreboard objectives add tut_btn trigger

# constants: plot spacing, last exercise index per section, number of sections built
scoreboard players set c128 tut_const 1024
scoreboard players set s1 tut_const 11
scoreboard players set n1 tut_const 12
scoreboard players set c2 tut_const 2
scoreboard players set s2 tut_const 7
scoreboard players set maxsec tut_const 2

# hidden sandbox chunk for later sections' checks
forceload add -1024 -1024

scoreboard players enable @a[distance=0..] tut_btn

# a tip boss bar existed in an earlier version: remove it from existing worlds
bossbar remove tut:tip

execute unless score global tut_init matches 1 run function tut:internal/init

# one-time: wipe the retired hub pad (2026-10-12)
execute unless score hub_gone tut_const matches 1 run function tut:internal/hub_clear
# noon on every reload (a dusk experiment on 2026-10-18 was dropped: the darkened menu blur in the resource pack does the job)
time set noon
