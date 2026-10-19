# Macro (id, name, ...cur): as the sneaking clicker. The edit menu opens only for the character's maker.
$function npc:internal/owns {id:"$(id)"}
$execute unless score ok npc_tmp matches 1 run return run function npc:internal/not_yours {name:"$(name)"}
function npc:internal/edit_menu with storage npc:main cur
