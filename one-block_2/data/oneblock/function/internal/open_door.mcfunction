# Called as a player next to the key door holding the Golden Key: the door
# stays gone until the next ___play re-places it.
setblock 17 60 0 minecraft:air
setblock 17 59 0 minecraft:air
playsound minecraft:block.iron_door.open block @a 17 59 0
tellraw @a [{"selector":"@s","color":"yellow"},{"text":" unlocked the iron door!","color":"green"}]
