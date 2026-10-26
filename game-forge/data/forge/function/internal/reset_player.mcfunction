# Moving between the lobby and a game: empty inventory, no leftover effects or arena state.
# Each game's enter function gives back what that game hands out.
clear @s
effect clear @s
tag @s remove arena_fighter
scoreboard players reset @s fight
scoreboard players reset @s leave
