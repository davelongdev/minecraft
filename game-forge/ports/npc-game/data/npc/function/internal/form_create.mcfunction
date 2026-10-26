# New character from the form: id c<num> is picked automatically, then the buttons form opens.
execute if data storage npc:main form{name:""} run data modify storage npc:main form.name set value "Somebody"
execute if data storage npc:main form{greeting:""} run data modify storage npc:main form.greeting set value "Hello!"
scoreboard players operation nn npc_tmp = next npc_tmp
scoreboard players add nn npc_tmp 1
execute store result storage npc:main form.n int 1 run scoreboard players get nn npc_tmp
function npc:internal/form_create2 with storage npc:main form
