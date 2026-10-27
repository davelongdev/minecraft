# Macro (n, v, name, kind, owner, c): one button for each of the player's own workshops
$execute if score @s forge_id matches $(owner) run data modify storage forge:main ws_pick.actions append value {label:{text:"Workshop $(c): $(kind)"},action:{type:"minecraft:run_command",command:"trigger workshop set $(v)"}}
