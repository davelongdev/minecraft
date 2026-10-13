# Macro (num, k): copy button k's cmd or say line (and the character's name) to the top level for exec/speak.
data remove storage npc:main cmd
data remove storage npc:main say
$data modify storage npc:main cmd set from storage npc:main npcs[{num:$(num)}].b$(k).cmd
$data modify storage npc:main say set from storage npc:main npcs[{num:$(num)}].b$(k).say
$data modify storage npc:main name set from storage npc:main npcs[{num:$(num)}].name
