# Short commands for everyone: /trigger grass (place grass where you stand), /trigger remove, /trigger tiles, ...
# Each trigger runs its function for the player who typed it, then is reset and re-enabled.
execute as @a[scores={floor=1..}] run function tile:___place_here {name:"floor"}
execute as @a[scores={grass=1..}] run function tile:___place_here {name:"grass"}
execute as @a[scores={water=1..}] run function tile:___place_here {name:"water"}
execute as @a[scores={lava=1..}] run function tile:___place_here {name:"lava"}
execute as @a[scores={wall=1..}] run function tile:___place_here {name:"wall"}
execute as @a[scores={tree=1..}] run function tile:___place_here {name:"tree"}
execute as @a[scores={glass=1..}] run function tile:___place_here {name:"glass"}
execute as @a[scores={ice=1..}] run function tile:___place_here {name:"ice"}
execute as @a[scores={gold=1..}] run function tile:___place_here {name:"gold"}
execute as @a[scores={tiles=1..}] run function tile:___tiles
execute as @a[scores={remove=1..}] run function tile:___remove_here
execute as @a[scores={where=1..}] run function tile:___where
execute as @a[scores={play=1..}] run function tile:___play
execute as @a[scores={build=1..}] run function tile:___build
execute as @a[scores={reset=1..}] run function tile:___reset_board
execute as @a[scores={clear=1..}] run function tile:___clear_board
execute as @a[scores={help=1..}] run function tile:___help
scoreboard players reset @a[scores={floor=1..}] floor
scoreboard players reset @a[scores={grass=1..}] grass
scoreboard players reset @a[scores={water=1..}] water
scoreboard players reset @a[scores={lava=1..}] lava
scoreboard players reset @a[scores={wall=1..}] wall
scoreboard players reset @a[scores={tree=1..}] tree
scoreboard players reset @a[scores={glass=1..}] glass
scoreboard players reset @a[scores={ice=1..}] ice
scoreboard players reset @a[scores={gold=1..}] gold
scoreboard players reset @a[scores={tiles=1..}] tiles
scoreboard players reset @a[scores={remove=1..}] remove
scoreboard players reset @a[scores={where=1..}] where
scoreboard players reset @a[scores={play=1..}] play
scoreboard players reset @a[scores={build=1..}] build
scoreboard players reset @a[scores={reset=1..}] reset
scoreboard players reset @a[scores={clear=1..}] clear
scoreboard players reset @a[scores={help=1..}] help
scoreboard players enable @a floor
scoreboard players enable @a grass
scoreboard players enable @a water
scoreboard players enable @a lava
scoreboard players enable @a wall
scoreboard players enable @a tree
scoreboard players enable @a glass
scoreboard players enable @a ice
scoreboard players enable @a gold
scoreboard players enable @a tiles
scoreboard players enable @a remove
scoreboard players enable @a where
scoreboard players enable @a play
scoreboard players enable @a build
scoreboard players enable @a reset
scoreboard players enable @a clear
scoreboard players enable @a help
