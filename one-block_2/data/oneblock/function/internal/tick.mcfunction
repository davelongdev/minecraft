# Late-joiner setup: adventure-mode players only, once per player.
# Unset scores don't match ..0, so initialize to 0 first.
scoreboard players add @a ob_joined 0
execute as @a[gamemode=adventure,scores={ob_joined=..0}] run function oneblock:internal/join

# Lives: the deathCount criterion ticks up on any death (usually the void).
# Wait until the player has respawned (Health > 0) — gamemode/give on a body
# still on the death screen get wiped by the respawn.
execute as @a[scores={ob_deaths=1..}] unless data entity @s {Health:0.0f} run function oneblock:internal/lose_life

# Key door: a player beside the door holding the Golden Key opens it
execute if block 17 59 0 minecraft:iron_door as @a[x=15,y=59,z=-1,dx=1,dy=1,dz=2] if items entity @s weapon.* *[minecraft:custom_data~{oneblock_key:"gold"}] run function oneblock:internal/open_door

# Speedrun: advance running timers, show them, detect the finish (anywhere in
# the course region past the dirt wall at x 17..19).
scoreboard players add @a[scores={ob_run=1}] ob_timer 1
execute as @a[scores={ob_run=1}] run function oneblock:internal/speedrun_hud
execute as @a[scores={ob_run=1},x=20,y=55,z=-6,dx=6,dy=15,dz=12] run function oneblock:internal/speedrun_finish
