# Macro (id, n): "No button n" - drop it and move on.
$data remove storage npc:main npcs[{id:"$(id)"}].b$(n)
$function npc:internal/form_button_next {id:"$(id)",n:$(n)}
