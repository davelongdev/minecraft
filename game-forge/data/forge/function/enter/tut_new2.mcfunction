# New to Command Forge, via the Command Blocks NPC: join without the arrival intro, then section 2.
tp @s 0.5 101 0.5 -90 0
execute at @s run function tut:internal/join
scoreboard players set @s tut_walk 0
effect clear @s blindness
effect clear @s darkness
effect clear @s slowness
function forge:enter/tut_section {sec:2}
