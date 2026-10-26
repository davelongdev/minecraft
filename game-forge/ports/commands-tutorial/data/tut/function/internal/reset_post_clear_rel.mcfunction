# Positioned at island 1's origin: remove the RESET ALL QUESTS post (sign and button first, then the log, then items).
setblock ~2 ~ ~2 air
setblock ~1 ~1 ~2 air
setblock ~1 ~ ~2 air
execute positioned ~1 ~ ~2 run kill @e[type=item,distance=..3]
