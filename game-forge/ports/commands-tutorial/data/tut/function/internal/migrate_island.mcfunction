# Macro (px = the OLD island x). Islands moved from 128·id to 1024·id (2026-10-12): wipe the old plot
# (its chunks are loaded: the player is standing on it), move tut_px, drop the player above the new spot;
# ensure_plot builds the island there over the next ticks (fall damage is off).
$execute positioned $(px) 100 0 run function tut:internal/clear_footprint_rel
scoreboard players operation @s tut_px = @s tut_tmp
function tut:internal/store_args
function tut:internal/migrate_tp with storage tut:main args
tellraw @s {"font":"minecraft:uniform","text":"Islands were spread out. Yours moved, give it a second to appear.","color":"gray"}
