# Late-joiner setup: adventure-mode players only, once per player.
# Unset scores don't match ..0, so initialize to 0 first.
scoreboard players add @a ob_joined 0
execute as @a[gamemode=adventure,scores={ob_joined=..0}] run function oneblock:internal/join
