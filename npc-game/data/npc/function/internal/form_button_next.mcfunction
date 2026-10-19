# Macro (id, n): after button n, open the ask screen for button n+1 (nothing after 3).
$data modify storage npc:main form set from storage npc:main npcs[{id:"$(id)"}]
$data modify storage npc:main form.n set value $(n)
execute if data storage npc:main form{n:3} run return 1
execute if data storage npc:main form{n:1} run return run function npc:internal/form_button_goto {n:2}
function npc:internal/form_button_goto {n:3}
