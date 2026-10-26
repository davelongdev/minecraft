# Positioned at the quest origin, on an island from before 2026-10-26 (a post at z2): remove the old PREVIOUS QUEST
# post (z2) and the NEXT QUEST post (z4) if it's there; ensure_plot then builds PREVIOUS at z4 (nav_posts_rel).
# Buttons and signs first: a log cleared under them drops them.
fill ~7 ~1 ~2 ~7 ~1 ~4 air
fill ~6 ~ ~2 ~6 ~ ~4 air
fill ~7 ~ ~2 ~7 ~ ~4 air
execute positioned ~7 ~ ~3 run kill @e[type=item,distance=..4]
