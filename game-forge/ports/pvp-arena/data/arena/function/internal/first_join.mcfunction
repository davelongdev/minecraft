tag @s add arena_seen
function arena:internal/to_stands
tellraw @s ""
tellraw @s {"text":"Welcome to the PvP Arena!","color":"gold"}
tellraw @s [{"text":"/trigger fight","color":"aqua"},{"text":" - jump into the arena","color":"white"}]
tellraw @s [{"text":"/trigger leave","color":"aqua"},{"text":" - back to the stands","color":"white"}]
tellraw @s {"text":"Watch out for the magma pistons!","color":"red"}
