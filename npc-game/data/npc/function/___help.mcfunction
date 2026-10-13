# Prints the command list: /function npc:___help
tellraw @s {"text":"NPC game - right-click a character to talk. Make your own (all /function npc:...):","color":"aqua"}
tellraw @s [{"text":"  ___new {id:\"zed\",name:\"Zed the Wizard\"}","color":"green"},{"text":" - a character where you stand","color":"gray"}]
tellraw @s [{"text":"  ___greeting {id:\"zed\",text:\"Greetings!\"}","color":"green"},{"text":" - what they say","color":"gray"}]
tellraw @s [{"text":"  ___button {id:\"zed\",n:1,label:\"Zap me\",cmd:\"effect give @s levitation 3 1\"}","color":"green"},{"text":" - a button (n 1-3) and its command","color":"gray"}]
tellraw @s [{"text":"  ___reply {id:\"zed\",n:2,label:\"Who are you?\",text:\"I am Zed.\"}","color":"green"},{"text":" - a button that just says a line","color":"gray"}]
tellraw @s [{"text":"  ___job {id:\"zed\",job:\"cleric\"}","color":"green"},{"text":" - villager look   ","color":"gray"},{"text":"___rename {id,name}","color":"green"},{"text":"   ","color":"gray"},{"text":"___wander {id,on:0}","color":"green"}]
tellraw @s [{"text":"  ___here {id}","color":"green"},{"text":" - bring them to you   ","color":"gray"},{"text":"___clear_button {id,n}","color":"green"},{"text":"   ","color":"gray"},{"text":"___delete {id}","color":"green"}]
tellraw @s [{"text":"  ___list","color":"green"},{"text":" / ","color":"gray"},{"text":"___respawn","color":"green"},{"text":" - who exists / put everyone back","color":"gray"}]
tellraw @s {"text":"  Text cannot contain double quotes. Commands run as the player who presses the button (@s = them).","color":"gray"}
