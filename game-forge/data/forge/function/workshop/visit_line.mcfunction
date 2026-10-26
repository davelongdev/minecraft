# Macro (n, v, name, kind): one button, skipped for the player's own workshop
$execute unless score @s forge_ws matches $(n) run data modify storage forge:main ws_pick.actions append value {label:{text:"$(name)'s workshop"},tooltip:{text:"$(kind)"},action:{type:"minecraft:run_command",command:"trigger workshop set $(v)"}}
