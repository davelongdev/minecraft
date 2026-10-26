# Macro (name): one snapshot line.
$tellraw @s {text:"  $(name)",color:"yellow",click_event:{action:"run_command",command:'function forge:internal/restore_hub_auto {name:"$(name)"}'},hover_event:{action:"show_text",value:"Restore the hub to $(name)"}}
