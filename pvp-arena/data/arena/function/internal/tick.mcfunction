# Build the stadium once its chunks are loaded (fill into unloaded chunks fails silently), then pass 2 a second later.
execute unless score built arena_tmp matches 1.. if loaded -48 64 -48 if loaded 47 64 47 if loaded -48 64 47 if loaded 47 64 -48 run function arena:internal/build_start
execute if score built arena_tmp matches 1..19 run scoreboard players add built arena_tmp 1
execute if score built arena_tmp matches 20 run function arena:internal/build_finish

# players
execute as @a[tag=!arena_seen] run function arena:internal/first_join
execute as @a[scores={fight=1..}] run function arena:internal/join
execute as @a[scores={leave=1..}] run function arena:internal/leave
scoreboard players reset @a fight
scoreboard players reset @a leave
scoreboard players enable @a fight
scoreboard players enable @a leave
# @e only selects living entities, so this waits until a dead fighter has pressed Respawn
execute as @e[type=player,scores={arena_deaths=1..}] run function arena:internal/respawned
execute as @a[y=-200,dy=240] run function arena:internal/to_stands

# magma piston pads run while anyone is fighting
execute if entity @a[tag=arena_fighter] run function arena:internal/pads_tick
execute unless entity @a[tag=arena_fighter] if score pads_on arena_tmp matches 1 run function arena:internal/pads_stop

# arrows stuck in the floor or seats, every 5 seconds
scoreboard players add clock arena_tmp 1
execute if score clock arena_tmp matches 100.. run kill @e[type=arrow,nbt={inGround:1b}]
execute if score clock arena_tmp matches 100.. run scoreboard players set clock arena_tmp 0
