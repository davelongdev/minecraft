# Macro (id, owner)
$execute if score @s npc_pid matches $(owner) run function npc:internal/delete {id:"$(id)"}
