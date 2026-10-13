# List the tile types; click one to place it where you stand.
tellraw @s {"text":"Tile types - click one to place it here:","color":"aqua"}
tellraw @s [{"text":"  floor","color":"green","click_event":{"action":"run_command","command":"trigger floor"}},{"text":" - plain stone","color":"gray"}]
tellraw @s [{"text":"  grass","color":"green","click_event":{"action":"run_command","command":"trigger grass"}},{"text":" - grass with a flower","color":"gray"}]
tellraw @s [{"text":"  water","color":"green","click_event":{"action":"run_command","command":"trigger water"}},{"text":" - a little pool","color":"gray"}]
tellraw @s [{"text":"  lava","color":"green","click_event":{"action":"run_command","command":"trigger lava"}},{"text":" - careful!","color":"gray"}]
tellraw @s [{"text":"  wall","color":"green","click_event":{"action":"run_command","command":"trigger wall"}},{"text":" - solid block, 3 high","color":"gray"}]
tellraw @s [{"text":"  tree","color":"green","click_event":{"action":"run_command","command":"trigger tree"}},{"text":" - a little oak","color":"gray"}]
tellraw @s [{"text":"  glass","color":"green","click_event":{"action":"run_command","command":"trigger glass"}},{"text":" - see-through floor","color":"gray"}]
tellraw @s [{"text":"  ice","color":"green","click_event":{"action":"run_command","command":"trigger ice"}},{"text":" - slippery","color":"gray"}]
tellraw @s [{"text":"  gold","color":"green","click_event":{"action":"run_command","command":"trigger gold"}},{"text":" - a goal tile","color":"gray"}]
