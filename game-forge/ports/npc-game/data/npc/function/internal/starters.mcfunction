# Two example characters, made with the same commands a player would use.
scoreboard players set global npc_seed 1
# quiet: the create/set_* helpers skip their green confirmation lines while this runs (a player refreshing would see eight of them)
scoreboard players set quiet npc_tmp 1
execute positioned -2 64 3 run function npc:internal/create {id:"bob",name:"Bob the Baker",job:"farmer"}
function npc:internal/set_greeting {id:"bob",text:"Hello there! Fresh bread, straight from the oven. What can I do for you?"}
function npc:internal/set_button {id:"bob",n:1,label:"Give me some bread",cmd:"give @s bread 3"}
function npc:internal/set_reply {id:"bob",n:2,label:"Tell me a joke",text:"Why did the creeper cross the road? ... It didn't. It exploded."}
execute positioned 1 64 3 run function npc:internal/create {id:"mira",name:"Mira the Guide",job:"librarian"}
function npc:internal/set_greeting {id:"mira",text:"Welcome, traveller. Lost? I know every path on this island."}
function npc:internal/set_button {id:"mira",n:1,label:"Take me home",cmd:"tp @s 0.5 65 0.5 0 0"}
function npc:internal/set_button {id:"mira",n:2,label:"Make it night",cmd:"time set 18000"}
function npc:internal/set_button {id:"mira",n:3,label:"Make it day",cmd:"time set 6000"}
# the starters are shared: owner 0 even when a player ran this (create records the runner's id otherwise)
data modify storage npc:main npcs[{id:"bob"}].owner set value 0
data modify storage npc:main npcs[{id:"mira"}].owner set value 0
scoreboard players set quiet npc_tmp 0
