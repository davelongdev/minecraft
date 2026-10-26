# Macro (pid)
$data modify storage npc:main args.name set value "Player $(pid)"
$data modify storage npc:main args.name set from storage npc:main names[{pid:$(pid)}].name
