# Game mechanic ideas for one-block_2

Brainstorm of mechanics to add to the dig-through-dirt maze game, roughly
ordered by effort. Effort notes assume the existing scoreboard/tick/structure
plumbing.

- [x] **Speedrun timer** — `___start_speedrun` / `___stop_speedrun`: actionbar
  shows elapsed time, finish detected past the wall, personal best kept per
  player. (small)
- [ ] **Dig budget** — only N digs allowed (count dirt broken on a scoreboard);
  run out before the wall and you must reset. Forces route planning instead of
  brute-force tunneling. (small)
- [ ] **Checkpoints** — pressure plates or reaching certain x-coordinates update
  your spawnpoint, so falling into the void isn't a full restart. (small)
- [ ] **Mixed soils** — coarse dirt is undiggable (walls within walls), rooted
  dirt gives mining fatigue, podzol grants a speed burst. Cheap since
  `can_break` already targets the dirt tag. (small)
- [ ] **Race mode** — `internal/flip_course` already mirrors the course across
  x=0: two players race mirrored halves, first to the sign wins. Mostly needs
  win detection. (medium)
- [x] **Keys, locked chest, key door** — first slice of "buried keys": trial-key
  items given at game start, a chest in the corridor that only opens while
  holding the Rusty Key (vanilla `lock` component), and an iron door in the
  dirt wall opened by standing next to it with the Golden Key. (medium)
- [ ] **Buried keys** — hide the keys in the maze instead of handing them out;
  the final wall only opens (or the win sign only counts) if you're carrying
  one. Adds exploration to the dig. (medium)
- [ ] **One-way doors** — doors or drops you can pass through in only one
  direction, so route choices commit you (no backtracking to try the other
  branch). (medium)
- [ ] **Pursuer** — after a grace period, silverfish spawn periodically in
  tunnels you've already dug, so dawdling gets punished. (medium)
- [ ] **Level progression** — the named-save system doubles as a level loader:
  courses saved as `level-1`, `level-2`…, auto-advance on win. (medium)
