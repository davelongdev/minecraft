# Macro: upsert the caller's leaderboard name entry {id, name} in storage.
# Called from ___set_name with storage oneblock:main args = {id, nm}.
$data remove storage oneblock:main players[{id:$(id)}]
$data modify storage oneblock:main players append value {id:$(id),name:"$(nm)"}
$tellraw @s {"text":"Leaderboard name set: $(nm)","color":"aqua"}
