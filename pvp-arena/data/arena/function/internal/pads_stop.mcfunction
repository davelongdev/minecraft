# Nobody fighting: all pads down. timer 100 means the next fight starts with the warning over group A.
function arena:internal/pads_down_a
function arena:internal/pads_down_b
scoreboard players set pads_on arena_tmp 0
scoreboard players set timer arena_tmp 100
