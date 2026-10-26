# Macro (id, name, owner): one button for the pick list, for the player's own characters only
$execute if score @s npc_pid matches $(owner) run data modify storage npc:main pick.actions append value {label:{text:"$(name)"},action:{type:"minecraft:run_command",command:"function npc:internal/confirm_delete {id:\"$(id)\",name:\"$(name)\"}"}}
