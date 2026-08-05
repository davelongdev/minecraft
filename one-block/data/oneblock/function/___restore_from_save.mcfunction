# Restore the newest save point (see ___set_game): run with /function oneblock:___restore_from_save
# Rebuilds the course from the latest game-<n> snapshot, then resets items,
# time, and spawn and switches everyone to play mode — like ___reset_game but
# using your saved course instead of the built-in one.
execute unless score global ob_saves matches 1.. run tellraw @s {"text":"No save points yet — run /function oneblock:___set_game first.","color":"yellow"}
execute if score global ob_saves matches 1.. run function oneblock:internal/restore_latest
