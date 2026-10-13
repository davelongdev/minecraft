# Make a character where you stand: /function npc:___new {id:"zed",name:"Zed the Wizard"}   (id: lowercase, no spaces)
$execute at @s run function npc:internal/create {id:"$(id)",name:"$(name)",job:"none"}
