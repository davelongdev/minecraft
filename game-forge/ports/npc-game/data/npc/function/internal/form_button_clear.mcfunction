# Macro (id, n): quietly drop button n
$data remove storage npc:main npcs[{id:"$(id)"}].b$(n)
