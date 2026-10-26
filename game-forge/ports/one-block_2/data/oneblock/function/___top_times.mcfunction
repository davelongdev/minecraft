# Show the 5 fastest speedrun personal bests: run with /function oneblock:___top_times
# Online players only — scores persist for offline players but selectors
# can't reach them. Prints to everyone.
scoreboard players add @a[distance=0..] ob_best 0
execute unless entity @a[distance=0..,scores={ob_best=1..}] run tellraw @s {"text":"No recorded times yet — finish a speedrun first.","color":"yellow"}
execute unless entity @a[distance=0..,scores={ob_best=1..}] run return 0
tellraw @a[distance=0..] {"text":"Top times:","color":"aqua"}
execute as @a[distance=0..] run scoreboard players operation @s ob_work = @s ob_best
scoreboard players set rank ob_work 0
function oneblock:internal/top_slot
function oneblock:internal/top_slot
function oneblock:internal/top_slot
function oneblock:internal/top_slot
function oneblock:internal/top_slot
