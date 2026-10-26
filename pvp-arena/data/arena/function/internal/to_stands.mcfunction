# Back to the stands: no kit, can't be hurt (resistance V).
tag @s remove arena_fighter
clear @s
effect clear @s
effect give @s resistance infinite 4 true
gamemode adventure @s
function arena:internal/stands_tp
