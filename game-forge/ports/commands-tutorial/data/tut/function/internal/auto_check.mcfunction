# Macro (sec, ex, px, pz), every tick from player_tick: complete the current quest as soon as its check passes
# (Dave 2026-10-26: no NEXT QUEST button). Checks run at the quest origin, as the button did. Waits a second into
# each quest (tut_tick counts from the quest's start), so "Great job!" never fires twice in a row. Quest 12
# (the last of section 1) still finishes with its TP TO NEXT ISLAND button (internal/next_island).
execute unless score @s tut_tick matches 20.. run return fail
execute if score @s tut_sec > maxsec tut_const run return fail
execute if score @s tut_sec matches 1 if score @s tut_ex = s1 tut_const run return fail
$execute positioned $(px) 100 $(pz) if function tut:s$(sec)/e$(ex)/check run function tut:internal/complete with storage tut:main args
