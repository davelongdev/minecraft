# Prints the command list: /function npc:___help
tellraw @s {"text":"NPC game - right-click a character to talk.","color":"aqua"}
tellraw @s [{"text":"  /trigger create_npc","color":"green"},{"text":" - make a new character where you stand (a form opens: name, look, greeting, then its buttons)","color":"gray"}]
tellraw @s [{"text":"  sneak + right-click a character","color":"green"},{"text":" - edit it: name/look/greeting, buttons, bring here, delete","color":"gray"}]
tellraw @s [{"text":"  /trigger clear_npcs","color":"green"},{"text":" - delete every character (asks first)","color":"gray"}]
tellraw @s [{"text":"  /trigger starter_npcs","color":"green"},{"text":" - bring Bob the Baker and Mira the Guide back","color":"gray"}]
tellraw @s {"text":"  Buttons either say a line or run a command (no slash; @s = the player who pressed it). No quote marks in any box.","color":"gray"}
tellraw @s {"text":"Teacher commands (all /function npc:...):","color":"aqua"}
tellraw @s [{"text":"  ___make","color":"green"},{"text":" - same as /trigger create_npc   ","color":"gray"},{"text":"___list","color":"green"},{"text":" - who exists (ids)   ","color":"gray"},{"text":"___respawn","color":"green"},{"text":" - put everyone back   ","color":"gray"},{"text":"___delete_all","color":"green"},{"text":" - no questions asked","color":"gray"}]
tellraw @s [{"text":"  ___new {id:\"zed\",name:\"Zed the Wizard\"}","color":"green"},{"text":" - a character where you stand, by hand","color":"gray"}]
tellraw @s [{"text":"  ___greeting {id:\"zed\",text:\"Greetings!\"}","color":"green"},{"text":"   ","color":"gray"},{"text":"___job {id:\"zed\",job:\"cleric\"}","color":"green"},{"text":"   ","color":"gray"},{"text":"___rename {id,name}","color":"green"}]
tellraw @s [{"text":"  ___button {id:\"zed\",n:1,label:\"Zap me\",cmd:\"effect give @s levitation 3 1\"}","color":"green"},{"text":"   ","color":"gray"},{"text":"___reply {id:\"zed\",n:2,label:\"Who are you?\",text:\"I am Zed.\"}","color":"green"}]
tellraw @s [{"text":"  ___wander {id:\"zed\",on:0}","color":"green"},{"text":"   ","color":"gray"},{"text":"___here {id}","color":"green"},{"text":"   ","color":"gray"},{"text":"___clear_button {id,n}","color":"green"},{"text":"   ","color":"gray"},{"text":"___delete {id}","color":"green"}]
