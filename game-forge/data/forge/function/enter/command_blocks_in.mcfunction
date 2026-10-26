# In forge:commands, as the player (still standing in the lobby).
# New: join now (island 1 is built for later), skip the arrival intro, start section 2.
execute unless score @s tut_joined matches 1 run return run function forge:enter/tut_new2
execute if score @s tut_sec matches 1 run return run function forge:enter/tut_section {sec:2}
# already in section 2 (maybe visiting island 1): island 2, current quest
scoreboard players set @s tut_end 2
function tut:internal/store_args
function tut:internal/go_home with storage tut:main args
function forge:enter/tut_book
