# /trigger choose_name (and the Island Builder reward when no name is set yet): the name form, prefilled with the current name
execute store result storage npc:main args.pid int 1 run scoreboard players get @s npc_pid
data modify storage npc:main args.cur set value ""
function npc:internal/form_name_cur with storage npc:main args
data modify storage npc:main args.ph_name set from storage npc:main ph.name
function npc:internal/form_name with storage npc:main args
