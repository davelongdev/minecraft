# Macro: one chat line for save game-$(n), clickable to restore it.
$tellraw @s [{"text":"  game-$(n)","color":"green","click_event":{"action":"run_command","command":"function oneblock:___restore_as {n:$(n)}"}}]
