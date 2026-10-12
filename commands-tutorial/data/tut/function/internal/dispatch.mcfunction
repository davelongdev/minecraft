# Route to the current exercise. Exercise functions run positioned at the island origin.
$execute if score @s tut_tick matches 1 positioned $(px) 100 0 run function tut:s$(sec)/e$(ex)/start
$execute positioned $(px) 100 0 run function tut:s$(sec)/e$(ex)/tick
