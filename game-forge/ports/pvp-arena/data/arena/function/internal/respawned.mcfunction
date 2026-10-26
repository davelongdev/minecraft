# A fighter died (keep_inventory is on, so nothing dropped) and has respawned.
scoreboard players reset @s arena_deaths
function arena:internal/to_stands
tellraw @s {"text":"You're out! /trigger fight to jump back in.","color":"yellow"}
