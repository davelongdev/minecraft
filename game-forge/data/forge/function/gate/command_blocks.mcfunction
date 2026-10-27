# As a player: 1 if they finished Command Blocks (all 8 section 2 quests: tut_quests counts 12 + 8) or are tagged ws_admin.
execute if entity @s[tag=ws_admin] run return 1
execute if score @s tut_quests matches 20.. run return 1
return fail
