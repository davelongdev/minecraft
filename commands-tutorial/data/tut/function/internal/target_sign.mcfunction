# Macro (tx = px + 30). Positioned at island 2's origin: the TARGET sign two blocks east of the blue block (14,18), where
# a kid at the blue block can read it while typing, showing the gold pad's absolute coordinates
# (pad centre x = px + 30, y 100, z 1024 + 18 = 1042). The sign used to stand by the pad at 32,18.
execute if block ~32 ~ ~18 dark_oak_sign run setblock ~32 ~ ~18 air
$setblock ~14 ~ ~18 dark_oak_sign[rotation=4]{allow_op_features:1b,front_text:{messages:[{"font":"minecraft:uniform","text":"TARGET","color":"gold","bold":true},{"font":"minecraft:uniform","text":""},{"font":"minecraft:uniform","text":"$(tx) 100 1042","color":"white","bold":true},{"font":"minecraft:uniform","text":"x y z","color":"gray"}],color:"white",has_glowing_text:1b},is_waxed:1b}
