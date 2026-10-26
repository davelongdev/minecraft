# Wipe leftover plots at the old island spots (x = 128·k, k 0..7) from before the 1024 spacing.
# Only chunks currently loaded are affected, so run it standing near the old islands. A spot that is
# some player's current island (x 0 for id 0) is skipped; islands self-repair anyway.
execute unless entity @a[distance=0..,scores={tut_px=0}] positioned 0 100 0 run function tut:internal/clear_footprint_rel
execute unless entity @a[distance=0..,scores={tut_px=128}] positioned 128 100 0 run function tut:internal/clear_footprint_rel
execute unless entity @a[distance=0..,scores={tut_px=256}] positioned 256 100 0 run function tut:internal/clear_footprint_rel
execute unless entity @a[distance=0..,scores={tut_px=384}] positioned 384 100 0 run function tut:internal/clear_footprint_rel
execute unless entity @a[distance=0..,scores={tut_px=512}] positioned 512 100 0 run function tut:internal/clear_footprint_rel
execute unless entity @a[distance=0..,scores={tut_px=640}] positioned 640 100 0 run function tut:internal/clear_footprint_rel
execute unless entity @a[distance=0..,scores={tut_px=768}] positioned 768 100 0 run function tut:internal/clear_footprint_rel
execute unless entity @a[distance=0..,scores={tut_px=896}] positioned 896 100 0 run function tut:internal/clear_footprint_rel
tellraw @s {"font":"minecraft:uniform","text":"Old island spots cleared (loaded chunks only).","color":"gray"}
