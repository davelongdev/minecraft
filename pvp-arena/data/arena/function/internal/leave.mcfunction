execute unless entity @s[tag=arena_fighter] run return run tellraw @s {"text":"You're already in the stands. /trigger fight to jump in!","color":"yellow"}
function arena:internal/to_stands
tellraw @a [{"selector":"@s","color":"gold"},{"text":" went back to the stands.","color":"yellow"}]
