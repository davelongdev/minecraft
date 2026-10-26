# Passes once the player has sent a chat message since the quest started (chat_count, from the server's
# chat-counter mod). Without the mod (#mod unset, e.g. a singleplayer copy) chat can't be seen, so it passes
# on trust 10 seconds into the quest (it completes on its own, internal/auto_check).
execute unless score #mod chat_count matches 1 if score @s tut_tick matches 200.. run return 1
execute unless score #mod chat_count matches 1 run return fail
execute if score @s chat_count matches 1.. run return 1
return fail
