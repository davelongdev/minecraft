# Set the display name shown on the ___top_times leaderboard:
# /function oneblock:___set_name {name:Dave}   (quotes for spaces: {name:"Dave L"})
# Stored in command storage keyed by a per-player id, so it survives relogs.
# Run it again any time to change your name.
execute unless score @s ob_id matches 1.. run scoreboard players add global ob_id 1
execute unless score @s ob_id matches 1.. run scoreboard players operation @s ob_id = global ob_id
execute store result storage oneblock:main args.id int 1 run scoreboard players get @s ob_id
$data modify storage oneblock:main args.nm set value "$(name)"
function oneblock:internal/set_name_entry with storage oneblock:main args
