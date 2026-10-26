# Macro (pid): open the name form only when the player has no name yet
$execute unless data storage npc:main names[{pid:$(pid)}] run function npc:internal/form_name_open
