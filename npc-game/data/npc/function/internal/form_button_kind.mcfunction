# Macro (id, n, k): the player chose dialogue (say) or command (cmd) for button n. Runs as the player.
$data modify storage npc:main form set from storage npc:main npcs[{id:"$(id)"}]
$data modify storage npc:main form.n set value $(n)
$data modify storage npc:main form.k set value "$(k)"
function npc:internal/form_button_prep with storage npc:main form
