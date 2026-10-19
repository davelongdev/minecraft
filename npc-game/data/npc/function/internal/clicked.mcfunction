# As a click box that was right-clicked: open its character's dialog for the clicker, once.
# Sneaking while clicking opens the edit menu instead.
execute store result storage npc:main args.num int 1 run scoreboard players get @s npc_num
function npc:internal/load_cur with storage npc:main args
execute on target if entity @s[predicate=npc:sneaking] run function npc:internal/edit_gate with storage npc:main cur
execute on target unless entity @s[predicate=npc:sneaking] run function npc:internal/show
data remove entity @s interaction
