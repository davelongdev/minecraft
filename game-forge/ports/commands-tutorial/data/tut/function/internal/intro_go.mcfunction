# Space bar pressed: release the player; walk_in keeps the darkness up for the
# first half of the path and lets it fade after that.
effect clear @s minecraft:blindness
effect clear @s minecraft:slowness
scoreboard players set @s tut_walk 1
