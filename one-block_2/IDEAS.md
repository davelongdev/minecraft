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
- [ ] **Buried keys** — a "key" item hidden somewhere in the maze; the final
  wall only opens (or the win sign only counts) if you're carrying it. Adds
  exploration to the dig. (medium)
- [ ] **Pursuer** — after a grace period, silverfish spawn periodically in
  tunnels you've already dug, so dawdling gets punished. (medium)
- [ ] **Level progression** — the named-save system doubles as a level loader:
  courses saved as `level-1`, `level-2`…, auto-advance on win. (medium)
