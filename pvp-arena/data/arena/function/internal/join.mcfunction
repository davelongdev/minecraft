# /trigger fight: into the arena with a kit, at a random spot within 14 blocks of the centre.
execute if entity @s[tag=arena_fighter] run return run tellraw @s {"text":"You're already in the arena!","color":"red"}
tag @s add arena_fighter
clear @s
effect clear @s
gamemode adventure @s
effect give @s instant_health 1 10 true
effect give @s saturation 1 10 true
function arena:internal/kit
spreadplayers 0 0 4 14 under 70 false @s
execute at @s run tp @s ~ ~ ~ facing 0.5 66 0.5
tellraw @a [{"selector":"@s","color":"gold"},{"text":" jumped into the arena!","color":"yellow"}]
