# Lists all save points in chat: run with /function oneblock:___list_saves
# Numbered saves are game-1..game-<ob_saves> with no gaps; named saves (from
# ___save_as) are recorded in storage oneblock:main saves. Every line is
# clickable to restore that save.
scoreboard players add global ob_saves 0
execute unless score global ob_saves matches 1.. unless data storage oneblock:main saves[0] run tellraw @s {"text":"No save points yet — create one with /function oneblock:___save_game or ___save_as","color":"yellow"}
execute if score global ob_saves matches 1.. run tellraw @s {"text":"Save points (newest last) — click one to restore it:","color":"aqua"}
scoreboard players set iter ob_saves 1
execute if score global ob_saves matches 1.. run function oneblock:internal/list_saves_loop
execute if data storage oneblock:main saves[0] run tellraw @s {"text":"Named saves — click one to restore it:","color":"aqua"}
execute if data storage oneblock:main saves[0] run data modify storage oneblock:main work set from storage oneblock:main saves
execute if data storage oneblock:main saves[0] run function oneblock:internal/list_named_loop
