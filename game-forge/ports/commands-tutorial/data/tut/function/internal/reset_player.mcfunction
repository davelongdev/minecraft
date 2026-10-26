# Teacher reset (___reset_player): fresh start including the arrival intro.
function tut:internal/reset_core
tellraw @s {"font":"minecraft:uniform","text":"Fresh start! Your island was reset.","color":"aqua"}
function tut:internal/start_intro
