# A button (n = 1, 2 or 3) that makes the character say something:
# /function npc:___reply {id:"zed",n:2,label:"Who are you?",text:"I am Zed, keeper of the island."}
$function npc:internal/set_reply {id:"$(id)",n:$(n),label:"$(label)",text:"$(text)"}
