# Macro (n, v, name, kind, owner, c): one button, skipped for the player's own workshops
$execute unless score @s forge_id matches $(owner) run data modify storage forge:main ws_pick.actions append value {label:{text:"$(name): $(kind)"},action:{type:"minecraft:run_command",command:"trigger workshop set $(v)"}}
