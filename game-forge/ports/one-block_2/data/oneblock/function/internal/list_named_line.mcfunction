# Macro: one chat line for named save $(name), clickable to restore it.
$tellraw @s [{"text":"  $(name)","color":"green","click_event":{"action":"run_command","command":"function oneblock:___restore_named {name:\"$(name)\"}"}}]
