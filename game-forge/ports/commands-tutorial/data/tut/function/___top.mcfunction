# Announce the top 5 players by points to everyone, medals for the top 3. Online players only (a name needs a live selector).
scoreboard players add @a[distance=0..] tut_pts 0
scoreboard players operation @a[distance=0..] tut_work = @a[distance=0..] tut_pts
tag @a[distance=0..] remove tut_ranked
scoreboard players set rank tut_const 0
tellraw @a[distance=0..] [{"font":"minecraft:uniform","text":"━━ Leaderboard ━━","color":"gold","bold":true}]
function tut:internal/top_step
function tut:internal/top_step
function tut:internal/top_step
function tut:internal/top_step
function tut:internal/top_step
tellraw @a[distance=0..] [{"font":"minecraft:uniform","text":"━━━━━━━━━━━━━━━━━","color":"gold","bold":true}]
