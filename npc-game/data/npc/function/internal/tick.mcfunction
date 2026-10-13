# clicks on a click box open that character's dialog for the clicker
execute as @e[type=interaction,tag=npc] if data entity @s interaction run function npc:internal/clicked
# dialog buttons: /trigger npc_choice set (100*num + button)
execute as @a[scores={npc_choice=100..}] at @s run function npc:internal/button
scoreboard players reset @a npc_choice
scoreboard players enable @a npc_choice
# click box and name follow the body (wandering characters); fallen bodies go home
execute as @e[type=villager,tag=npc] at @s run function npc:internal/follow
execute as @e[type=villager,tag=npc,y=-200,dy=259] run function npc:internal/go_home
# players who fell off: back to spawn
execute as @a[y=-200,dy=190] run tp @s 0.5 65 0.5 0 0
