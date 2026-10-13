# Tile game ideas

## Island game (Dave, 2026-10-12)

Two phases on the 3x3 board of 3x3 tiles:

1. **Build.** Players build the island first by placing tiles (`___place_here`, `___tiles`). Open question:
   does each player place tiles in turn, or does everyone build together?
2. **Sink.** Once the game starts, tiles go away one by one, one per turn, until the island is gone.
   Players standing on a tile that vanishes fall into the void. Last player still standing wins.

Mechanics to decide:
- Which tile goes each turn: random (`/random`), the tile with the most players, or the players vote.
- Turn length: a countdown (bossbar or chat) so players can hop to another tile.
- Tile types could matter: ice slides you off, wall blocks movement, gold is safe for one extra turn.
- Game mode for the sink phase: adventure (no building), fall detection like `one-block_2`'s lives.
