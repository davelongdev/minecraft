# Macro (px, sec, ex). TP TO NEXT ISLAND button: the first press completes quest 12 (and with it section 1),
# then every press builds island 2 if needed and teleports the player there.
$execute if score @s tut_sec matches 1 if score @s tut_ex matches 11 positioned $(px) 100 0 run function tut:internal/complete with storage tut:main args
$execute positioned $(px) 100 1024 run tp @s ~1.5 ~ ~18.5 -90 0
$execute positioned $(px) 100 1024 run function tut:internal/island2_rel
$execute positioned $(px) 100 1024 run spawnpoint @s ~1 ~ ~18
scoreboard players set @s tut_end 2
