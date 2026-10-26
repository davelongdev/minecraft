# As a player: a screen with one button per workshop except their own.
data modify storage forge:main ws_pick set value {actions:[]}
data modify storage forge:main ws_work set from storage forge:main workshops
execute if data storage forge:main ws_work[0] run function forge:workshop/visit_loop
scoreboard players enable @s workshop
execute unless data storage forge:main ws_pick.actions[0] run return run dialog show @s {type:"minecraft:notice",title:{text:"Personal Workshop",color:"gold",bold:true},external_title:"Personal Workshop",pause:false,body:[{type:"minecraft:plain_message",width:300,contents:"Nobody else has a workshop yet. Check back later!"}],action:{label:"OK"}}
function forge:workshop/visit_show with storage forge:main ws_pick
