# Recursive loop for ___list_saves: prints game-<iter>, then recurses while
# iter <= ob_saves. iter is set to 1 by the caller.
execute store result storage oneblock:main n int 1 run scoreboard players get iter ob_saves
function oneblock:internal/list_saves_line with storage oneblock:main
scoreboard players add iter ob_saves 1
execute unless score iter ob_saves > global ob_saves run function oneblock:internal/list_saves_loop
