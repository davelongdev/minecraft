# Macro (n, name, job, greeting)
$execute at @s run function npc:internal/create {id:"c$(n)",name:"$(name)",job:"$(job)"}
$function npc:internal/set_greeting {id:"c$(n)",text:"$(greeting)"}
$function npc:internal/form_buttons_open {id:"c$(n)"}
