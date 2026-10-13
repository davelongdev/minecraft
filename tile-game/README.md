# Tile board (namespace `tile`)

A 3x3 board of 3x3-block tiles floating in a void world. First piece of the island game in `IDEAS.md`.

- Tile (x, z), x and z from -1 to 1, is the 3x3x3 box at world x 3x-1..3x+1, y 64..66, z 3z-1..3z+1.
  (0,0) is the middle tile around the world origin. Frame ring around the board; base plate at y 63 in build mode only, a two-tone checkerboard with one square per tile slot.
- Players are in adventure mode: tiles change only as a whole through the commands, never by hand, and the plate
  and ring can't be edited. `___play` removes the plate (a removed tile is a hole into the void; fallers go to
  spectator and everyone is told), `___build` restores it (fallers return to the frame corner).
- Short commands for everyone (no op needed): `/trigger tiles`, `/trigger grass` (one per tile type), `/trigger remove`, `/trigger where`,
  `/trigger play`, `/trigger build`, `/trigger reset`, `/trigger clear`, `/trigger help` (`internal/triggers`, run from the tick function).
- Long forms (type `/function tile:___help` in game): `___tiles` (clickable list of types), `___place_here {name:"grass"}`,
  `___place {name:"grass",x:1,z:0}`, `___remove_here`, `___remove {x:1,z:0}`, `___where`, `___clear_board`, `___reset_board`, `___play`, `___build`.
- Tile types are functions in `data/tile/function/tiles/` run at the tile's corner (`~ ~ ~` .. `~2 ~2 ~2`); each ends by
  setting `ok tile_tmp 1`, which is how an unknown name is detected. Add a type = add a file + a line in `___tiles`.
- World: `tile-game` in the `26.3_mini_games` Prism instance (void world made with `tools/make_void_world.py`).
  Pack format 107-121 (26.2 and 26.3).

Build and install:

    cd tile-game
    zip -qr ../zips/tile-game.new.zip pack.mcmeta data && mv ../zips/tile-game.new.zip ../zips/tile-game.zip
    cp ../zips/tile-game.zip ~/.var/app/org.prismlauncher.PrismLauncher/data/PrismLauncher/instances/26.3_mini_games/minecraft/saves/tile-game/datapacks/
