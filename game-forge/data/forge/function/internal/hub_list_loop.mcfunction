# One clickable line per name in storage forge:main tmp.list (emptied as it goes).
execute unless data storage forge:main tmp.list[0] run return 0
data modify storage forge:main tmp.name set from storage forge:main tmp.list[0]
function forge:internal/hub_list_line with storage forge:main tmp
data remove storage forge:main tmp.list[0]
function forge:internal/hub_list_loop
