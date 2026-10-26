# As the clicker: build the dialog from storage npc:main cur, with as many buttons as are set (1, then 2, then 3).
# npc_choice is enabled only now, so it stays out of /trigger Tab completion (which lists enabled triggers only);
# the press, or the 2-minute npc_open countdown in tick, resets it again.
scoreboard players enable @s npc_choice
scoreboard players set @s npc_open 2400
execute if data storage npc:main cur.b1 if data storage npc:main cur.b2 if data storage npc:main cur.b3 run return run function npc:internal/show3 with storage npc:main cur
execute if data storage npc:main cur.b1 if data storage npc:main cur.b2 run return run function npc:internal/show2 with storage npc:main cur
execute if data storage npc:main cur.b1 run return run function npc:internal/show1 with storage npc:main cur
function npc:internal/show0 with storage npc:main cur
