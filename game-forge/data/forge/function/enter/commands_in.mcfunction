# In forge:commands, as the player (still standing in the lobby).
# New: Command Forge's tick runs its join next tick (island + the arrival intro); wait above the void.
execute unless score @s tut_joined matches 1 run return run function forge:enter/tut_new
# In section 2 after finishing section 1 (the old way in, or forge_s1): island 1 in the finished state,
# like the GO BACK TO FIRST ISLAND button. forge_t1 unset = came to section 2 the old way.
execute if score @s tut_sec matches 2.. if score @s forge_s1 matches 1 run return run function forge:enter/tut_island1
execute if score @s tut_sec matches 2.. unless score @s forge_t1 matches -1000.. run return run function forge:enter/tut_island1
execute if score @s tut_sec matches 2.. run return run function forge:enter/tut_section {sec:1}
function tut:internal/store_args
function tut:internal/go_home with storage tut:main args
function forge:enter/tut_book
