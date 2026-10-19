# Macro (n): set the button number and show its ask screen
$data modify storage npc:main form.n set value $(n)
function npc:internal/form_button_ask
