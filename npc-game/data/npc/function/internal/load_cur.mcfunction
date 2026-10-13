# Macro (num): copy that character's entry to storage npc:main cur, flattened for the dialog macros
# (name, greeting, x/y/z, l1..l3 = button labels, n1..n3 = trigger values 100*num+k).
$data modify storage npc:main cur set from storage npc:main npcs[{num:$(num)}]
data modify storage npc:main cur.x set from storage npc:main cur.pos[0]
data modify storage npc:main cur.y set from storage npc:main cur.pos[1]
data modify storage npc:main cur.z set from storage npc:main cur.pos[2]
data modify storage npc:main cur.l1 set from storage npc:main cur.b1.label
data modify storage npc:main cur.l2 set from storage npc:main cur.b2.label
data modify storage npc:main cur.l3 set from storage npc:main cur.b3.label
execute store result score v npc_tmp run data get storage npc:main cur.num
scoreboard players operation v npc_tmp *= c100 npc_tmp
scoreboard players add v npc_tmp 1
execute store result storage npc:main cur.n1 int 1 run scoreboard players get v npc_tmp
scoreboard players add v npc_tmp 1
execute store result storage npc:main cur.n2 int 1 run scoreboard players get v npc_tmp
scoreboard players add v npc_tmp 1
execute store result storage npc:main cur.n3 int 1 run scoreboard players get v npc_tmp
