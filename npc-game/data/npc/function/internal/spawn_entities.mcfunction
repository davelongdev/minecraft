# Macro (num, id, name, job, x, y, z): the villager body (no trades, so its own trade screen never opens),
# the click box, and the floating name, tagged npc + npc_<id>, all carrying num as their npc_num score.
$kill @e[tag=npc_$(id)]
$summon villager $(x) $(y) $(z) {Tags:["npc","npc_$(id)"],Silent:1b,Invulnerable:1b,PersistenceRequired:1b,Offers:{Recipes:[]},VillagerData:{profession:"minecraft:$(job)",level:1,type:"minecraft:plains"},CustomName:{text:"$(name)"},CustomNameVisible:0b}
$summon interaction $(x) $(y) $(z) {Tags:["npc","npc_$(id)"],width:1.0f,height:2.0f,response:1b}
$summon text_display $(x) $(y) $(z) {Tags:["npc","npc_$(id)"],text:{text:"$(name)",color:"gold",bold:true},billboard:"center",shadow:1b}
$scoreboard players set @e[tag=npc_$(id)] npc_num $(num)
