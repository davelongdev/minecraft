# Teacher: tear down and rebuild the stadium and pads (anything added or broken is wiped). Kills are kept;
# everyone goes back to the stands when the rebuild finishes (internal/build_finish).
function arena:internal/pads_stop
kill @e[distance=0..,type=arrow]
kill @e[distance=0..,type=item]
scoreboard players set built arena_tmp 0
tellraw @a[distance=0..] {"text":"Rebuilding the arena...","color":"gold"}
