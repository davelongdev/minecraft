# Macro (id): open the button screens for a character, starting with button 1 of 3.
$execute unless data storage npc:main npcs[{id:"$(id)"}] run return run tellraw @s {"text":"No character called $(id).","color":"red"}
$data modify storage npc:main form set from storage npc:main npcs[{id:"$(id)"}]
data modify storage npc:main form.n set value 1
function npc:internal/form_button_ask
