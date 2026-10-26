# lobby NPCs: clicks open their dialog, the dialog's button takes the player to the game
execute as @e[type=interaction,tag=forge_npc] if data entity @s interaction run function forge:internal/clicked
execute as @a[scores={forge_go=1..}] run function forge:internal/go
function forge:internal/heal
# Magic Compass: everyone always has one (games that clear the inventory lose it for a tick); right-click = hub.
# Dropped ones vanish, so they don't pile up.
execute as @a unless items entity @s container.* *[custom_data~{forge_hub:1b}] run function forge:internal/give_compass
execute as @e[type=item] if items entity @s contents *[custom_data~{forge_hub:1b}] run kill @s
execute as @a[scores={forge_compass=1..}] if items entity @s weapon.* *[custom_data~{forge_hub:1b}] run function forge:internal/lobby
scoreboard players reset @a forge_compass
# /trigger lobby from anywhere
execute as @a[scores={lobby=1..}] run function forge:internal/lobby
scoreboard players reset @a lobby
scoreboard players enable @a lobby
# game teams (sidebar + name colour) follow the dimension; in forge:commands, Command Forge's own
# rank_teams puts players on forge_tut or a medal team once a second
execute in minecraft:overworld run team join forge_lobby @a[distance=0..,team=!forge_lobby]
execute in forge:oneblock run team join forge_ob @a[distance=0..,team=!forge_ob]
execute in forge:jump run team join forge_jump @a[distance=0..,team=!forge_jump]
execute in forge:arena run team join forge_arena @a[distance=0..,team=!forge_arena]
execute in forge:npc run team join forge_npc @a[distance=0..,team=!forge_npc]
# Command Forge: remember who finished section 1 (on island 1 in the finished state)
execute in forge:commands run scoreboard players set @a[distance=0..,scores={tut_sec=1,tut_ex=11,tut_end=1..}] forge_s1 1
# hub lava/fire sweep, once a second
scoreboard players add clock forge_tmp 1
execute if score clock forge_tmp matches 20.. run function forge:internal/sweep
