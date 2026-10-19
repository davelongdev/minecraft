# As a player: delete every character they made (other players' and the starters stay).
data modify storage npc:main work set from storage npc:main npcs
execute if data storage npc:main work[0] run function npc:internal/delete_mine_loop
# the list may now be empty: don't let load reseed the starters over it
scoreboard players set global npc_seed 1
tellraw @s {"text":"Your NPCs are gone. /trigger create_npc makes a new one.","color":"yellow"}
