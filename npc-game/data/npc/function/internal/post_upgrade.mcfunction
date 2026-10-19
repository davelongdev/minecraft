# As an island-button marker standing on an old floor button: rebuild as a post (execution position = the old button block = the new post)
execute store result storage npc:main args.pid int 1 run scoreboard players get @s npc_pid
function npc:internal/my_name_get with storage npc:main args
setblock ~ ~ ~ stone
setblock ~ ~1 ~ polished_blackstone_button[face=floor]
function npc:internal/post_sign with storage npc:main args
tp @s ~ ~1 ~
