# A button (n = 1, 2 or 3) and the command it runs for the player who presses it, without the slash:
# /function npc:___button {id:"zed",n:1,label:"Zap me",cmd:"effect give @s levitation 3 1"}
$function npc:internal/set_button {id:"$(id)",n:$(n),label:"$(label)",cmd:"$(cmd)"}
