# Late-joiner setup: adventure-mode players only, once per player.
# Unset scores don't match ..0, so initialize to 0 first.
scoreboard players add @a ob_joined 0
execute as @a[gamemode=adventure,scores={ob_joined=..0}] run function oneblock:internal/join

# Speedrun: advance running timers, show them, detect the finish (anywhere in
# the course region past the dirt wall at x 17..19).
scoreboard players add @a[scores={ob_run=1}] ob_timer 1
execute as @a[scores={ob_run=1}] run function oneblock:internal/speedrun_hud
execute as @a[scores={ob_run=1},x=20,y=55,z=-6,dx=6,dy=15,dz=12] run function oneblock:internal/speedrun_finish
