# Drop the oldest names from storage forge:main tmp.list until 20 are left.
execute unless data storage forge:main tmp.list[20] run return 0
data remove storage forge:main tmp.list[0]
function forge:internal/hub_list_trim
