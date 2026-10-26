# Positioned at the island origin, run from s1/e11/tick once the player has visited the cage and is back
# on the island: the signs and buttons vanish and one post with a TP TO NEXT ISLAND button takes their place.
scoreboard players set @s tut_end 1
function tut:internal/finish_post_rel
playsound minecraft:block.note_block.bell master @s ~7 ~ ~6 1 1.2
