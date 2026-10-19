# Macro (px): as the presser. Islands sit at (px, 63, 0); the main island is px 0.
$tp @s $(px).5 66 0.5 -90 0
effect give @s slow_falling 5 0 true
# the island itself is built by isl_ensure (tick) for whoever stands on it, as soon as its chunks load
