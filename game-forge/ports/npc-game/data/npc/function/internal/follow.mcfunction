# As a villager body: move its click box and name onto it.
execute store result storage npc:main f.num int 1 run scoreboard players get @s npc_num
function npc:internal/follow_num with storage npc:main f
