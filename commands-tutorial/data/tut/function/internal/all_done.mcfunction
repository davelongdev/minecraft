execute if score @s tut_tick matches 40 run function tut:common/all_done
execute if score @s tut_tick matches 100000.. run scoreboard players set @s tut_tick 1000
# island upkeep (quest-11 area on island 1, island 2) lives in ensure_plot so it also runs during section 2
