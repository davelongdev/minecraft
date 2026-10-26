# Once a second (internal/tick): the top 3 online players by points wear a Gold / Silver / Bronze star
# in front of their name (chat, tab list, name tag) via team prefixes. Everyone else is on no team.
team add tut_gold
team add tut_silver
team add tut_bronze
team modify tut_gold prefix {"text":"★ ","color":"#ffd700","bold":true}
team modify tut_silver prefix {"text":"★ ","color":"#c0c0c0","bold":true}
team modify tut_bronze prefix {"text":"★ ","color":"#cd7f32","bold":true}
team join forge_tut @a[distance=0..]
team modify tut_gold color aqua
team modify tut_silver color aqua
team modify tut_bronze color aqua
scoreboard players add @a[distance=0..] tut_pts 0
scoreboard players operation @a[distance=0..] tut_work = @a[distance=0..] tut_pts
tag @a[distance=0..] remove tut_ranked
scoreboard players set rank tut_const 0
function tut:internal/rank_step
function tut:internal/rank_step
function tut:internal/rank_step
