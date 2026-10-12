# Glass cage with a gold floor block and a 2-high pocket inside; sign shows the pocket's coordinates.
fill ~8 ~0 ~8 ~10 ~3 ~10 glass
setblock ~9 ~0 ~9 gold_block
fill ~9 ~1 ~9 ~9 ~2 ~9 air
scoreboard players operation gx tut_const = @s tut_px
scoreboard players add gx tut_const 9
execute store result storage tut:main args.gx int 1 run scoreboard players get gx tut_const
function tut:s1/e9/sign with storage tut:main args
