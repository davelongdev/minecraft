# storage npc:main cmd starts with a slash (a button saved with one): drop it, a function can't run /commands
data modify storage npc:main first set string storage npc:main cmd 0 1
execute if data storage npc:main {first:"/"} run data modify storage npc:main cmd set string storage npc:main cmd 1
