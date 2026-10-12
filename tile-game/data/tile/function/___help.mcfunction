# Prints the command list: run with /function tile:___help
tellraw @s {"text":"Tile editor — tiles are 9x9x9 boxes on a grid, y 64..72","color":"aqua"}
tellraw @s [{"text":"  ___where","color":"green"},{"text":" — which tile you're standing in","color":"gray"}]
tellraw @s [{"text":"  ___goto {x:1,z:0}","color":"green"},{"text":" — teleport to the middle of a tile","color":"gray"}]
tellraw @s [{"text":"  ___save_tile {name:\"room\"}","color":"green"},{"text":" — save the tile you're standing in","color":"gray"}]
tellraw @s [{"text":"  ___place_here {name:\"room\"}","color":"green"},{"text":" — stamp a saved tile where you stand","color":"gray"}]
tellraw @s [{"text":"  ___place {name:\"room\",x:1,z:0}","color":"green"},{"text":" — stamp a saved tile at grid coords","color":"gray"}]
tellraw @s [{"text":"  ___remove_here","color":"green"},{"text":" / ","color":"gray"},{"text":"___remove {x:1,z:0}","color":"green"},{"text":" — clear a tile to air","color":"gray"}]
tellraw @s [{"text":"  ___list_tiles","color":"green"},{"text":" — saved tiles, click one to place it here","color":"gray"}]
tellraw @s [{"text":"  ___forget_tile {name:\"room\"}","color":"green"},{"text":" — drop a tile from the list","color":"gray"}]
tellraw @s [{"text":"  ___grid {r:3}","color":"green"},{"text":" / ","color":"gray"},{"text":"___clear_grid {r:3}","color":"green"},{"text":" — grid floor at y 63 for tiles -r..r","color":"gray"}]
tellraw @s [{"text":"  ___make_starters","color":"green"},{"text":" — (re)build the starter tiles: floor, grass, room, pillar","color":"gray"}]
