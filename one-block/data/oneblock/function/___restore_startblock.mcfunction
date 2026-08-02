# Put the starting block back if it's gone (e.g. broken by accident in creative)
# Migration: upgrade an old cobblestone start block to the sea lantern
execute if block 0 64 0 minecraft:cobblestone run setblock 0 64 0 minecraft:sea_lantern
execute unless block 0 64 0 minecraft:air run tellraw @s {"text":"There's already a block at 0 64 0 — nothing to restore.","color":"yellow"}
execute if block 0 64 0 minecraft:air run tellraw @s {"text":"Block restored.","color":"aqua"}
execute if block 0 64 0 minecraft:air run setblock 0 64 0 minecraft:sea_lantern
