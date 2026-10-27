# Positioned at the island origin, run from s1/e11/tick once the player has visited the cage and is back
# on the island: the signs and buttons vanish and one post with a TP TO NEXT ISLAND button takes their place.
scoreboard players set @s tut_end 1
function tut:internal/finish_post_rel
execute if score @s tut_quests matches ..11 run scoreboard players set @s tut_quests 12
function tut:internal/give_book
scoreboard players enable @s forge_cong
dialog show @s {type:"minecraft:notice",title:{text:"Congratulations!",color:"gold",bold:true},external_title:"Congratulations!",pause:false,can_close_with_escape:false,body:[{type:"minecraft:plain_message",width:300,contents:"You finished the Commands tutorial - all 12 quests!\n\nYou unlocked NPCs, Command Blocks, and your Personal Workshop.\n\nUse your Magic Compass to get back to the hub."}],action:{label:{text:"Continue",color:"green"},action:{type:"minecraft:run_command",command:"trigger forge_cong"}}}
