# Teacher: mark the current exercise done. Run as the kid: /execute as Name run function tut:___skip
function tut:internal/store_args
execute unless score @s tut_sec > maxsec tut_const run function tut:internal/complete with storage tut:main args
