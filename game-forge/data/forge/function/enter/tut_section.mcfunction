# Macro (sec). Switch the player to the other half of Command Forge, remembering the quest they were on in
# this half (forge_t1/forge_t2). A half they never switched into starts after their furthest quest in it.
# Same steps as tut:___goto (goto_apply) without its teacher message.
execute if score @s tut_sec matches 1 run scoreboard players operation @s forge_t1 = @s tut_ex
execute if score @s tut_sec matches 2 run scoreboard players operation @s forge_t2 = @s tut_ex
execute unless score @s forge_t1 matches -1000.. run scoreboard players operation @s forge_t1 = @s tut_quests
execute unless score @s forge_t2 matches -1000.. run function forge:enter/tut_t2_init
function tut:internal/store_args
function tut:internal/leave_quest with storage tut:main args
$scoreboard players set @s tut_sec $(sec)
$scoreboard players operation @s tut_ex = @s forge_t$(sec)
execute unless score @s tut_ex matches 0.. run scoreboard players set @s tut_ex 0
function tut:internal/store_args
function tut:internal/goto_clamp with storage tut:main args
execute if score @s tut_sec matches 1 if score @s tut_end matches 1.. run function tut:internal/unfinish with storage tut:main args
execute if score @s tut_sec matches 2.. run scoreboard players set @s tut_end 2
function tut:___start
function forge:enter/tut_book
