# Macro (id, n, k, label, text): the fill-in screen was submitted (runs as the player). Save it, then ask about the next button.
$data modify storage npc:main fb set value {id:"$(id)",n:$(n),k:"$(k)",label:"$(label)",text:"$(text)"}
function npc:internal/form_button_set
$function npc:internal/form_button_next {id:"$(id)",n:$(n)}
