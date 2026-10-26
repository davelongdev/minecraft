# Macro (px). GO BACK TO FIRST ISLAND button on island 2: return to island 1 (free play; the TP TO NEXT
# ISLAND post is still there and brings you back to island 2). tut_end 1 = "on island 1 after finishing".
$execute positioned $(px) 100 0 run spawnpoint @s ~1 ~ ~6
$execute positioned $(px) 100 0 run tp @s ~1.5 ~ ~6.5 -90 0
scoreboard players set @s tut_end 1
