# As the clicker: build the dialog from storage npc:main cur, with as many buttons as are set (1, then 2, then 3).
execute if data storage npc:main cur.b1 if data storage npc:main cur.b2 if data storage npc:main cur.b3 run return run function npc:internal/show3 with storage npc:main cur
execute if data storage npc:main cur.b1 if data storage npc:main cur.b2 run return run function npc:internal/show2 with storage npc:main cur
execute if data storage npc:main cur.b1 run return run function npc:internal/show1 with storage npc:main cur
function npc:internal/show0 with storage npc:main cur
