# Prints the command list: /trigger help  (or /function tile:___help)
tellraw @s {"text":"Tile board - a 3x3 board of 3x3 tiles. Short commands:","color":"aqua"}
tellraw @s [{"text":"  /trigger tiles","color":"green"},{"text":" - list the tile types, click one to place it where you stand","color":"gray"}]
tellraw @s [{"text":"  /trigger grass","color":"green"},{"text":" - place a grass tile where you stand (same for floor, water, lava, wall, tree, glass, ice, gold)","color":"gray"}]
tellraw @s [{"text":"  /trigger remove","color":"green"},{"text":" - clear the tile you stand on","color":"gray"}]
tellraw @s [{"text":"  /trigger where","color":"green"},{"text":" - which slot you're on (x and z from -1 to 1; (0,0) is the middle)","color":"gray"}]
tellraw @s [{"text":"  /trigger play","color":"green"},{"text":" / ","color":"gray"},{"text":"/trigger build","color":"green"},{"text":" - play mode drops the base plate (holes go to the void); build mode brings it back","color":"gray"}]
tellraw @s [{"text":"  /trigger reset","color":"green"},{"text":" / ","color":"gray"},{"text":"/trigger clear","color":"green"},{"text":" - nine floor tiles again / all tiles gone","color":"gray"}]
tellraw @s [{"text":"  By slot instead of by feet: ","color":"gray"},{"text":"/function tile:___place {name:\"grass\",x:1,z:0}","color":"green"},{"text":" and ","color":"gray"},{"text":"___remove {x:1,z:0}","color":"green"}]
