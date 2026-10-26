# As a player: 1 if they may have a workshop (finished Command Forge section 1, or tagged ws_admin).
execute if entity @s[tag=ws_admin] run return 1
execute if score @s tut_quests matches 12.. run return 1
execute if score @s forge_s1 matches 1 run return 1
return fail
