# Macro (id, name, job, greeting): the character form was submitted. Runs as (and at) the player who pressed Create/Save.
$data modify storage npc:main form set value {id:"$(id)",name:"$(name)",job:"$(job)",greeting:"$(greeting)"}
execute if data storage npc:main form{id:"new"} run return run function npc:internal/form_create
function npc:internal/form_edit
