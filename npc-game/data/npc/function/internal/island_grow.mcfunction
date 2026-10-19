# One-time fix for worlds built before 2026-10-16 (flag 1..3): the island used to be 13x13, 15x15, or 21x21 with the
# fence at +-7 or +-10; now 50x50 (-25..24) with the fence on the edge. Adds ground where there is air, moves the
# fence, keeps anything players built.
fill -25 63 -25 24 63 24 grass_block replace air
fill -25 62 -25 24 62 24 dirt replace air
fill -7 64 -7 7 64 -7 air replace oak_fence
fill -7 64 7 7 64 7 air replace oak_fence
fill -7 64 -7 -7 64 7 air replace oak_fence
fill 7 64 -7 7 64 7 air replace oak_fence
fill -10 64 -10 10 64 -10 air replace oak_fence
fill -10 64 10 10 64 10 air replace oak_fence
fill -10 64 -10 -10 64 10 air replace oak_fence
fill 10 64 -10 10 64 10 air replace oak_fence
fill -25 64 -25 24 64 -25 oak_fence replace air
fill -25 64 24 24 64 24 oak_fence replace air
fill -25 64 -25 -25 64 24 oak_fence replace air
fill 24 64 -25 24 64 24 oak_fence replace air
scoreboard players set global npc_init 4
