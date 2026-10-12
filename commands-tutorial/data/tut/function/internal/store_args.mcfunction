# Copy this player's position in the course into storage for macro functions.
execute store result storage tut:main args.sec int 1 run scoreboard players get @s tut_sec
execute store result storage tut:main args.ex int 1 run scoreboard players get @s tut_ex
execute store result storage tut:main args.px int 1 run scoreboard players get @s tut_px
# z of the quest origin: island 1 = 0; section 2 runs on island 2 at (px, 100, 1036) = island 2's origin
# (z 1024) + 12, so the sign/post/spawn offsets (~7 ~ ~6, ~7 ~1 ~8/4/2, ~1.5 ~ ~6.5) are the same as island 1's
data modify storage tut:main args.pz set value 0
execute if score @s tut_sec matches 2.. run data modify storage tut:main args.pz set value 1036
# island 2's TARGET pad x (px + 30) for the sign macro (internal/target_sign)
scoreboard players operation @s tut_tx = @s tut_px
scoreboard players add @s tut_tx 30
execute store result storage tut:main args.tx int 1 run scoreboard players get @s tut_tx
