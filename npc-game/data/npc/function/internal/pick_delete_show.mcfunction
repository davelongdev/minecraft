# Macro (actions): the list is pasted in as SNBT
$dialog show @s {type:"minecraft:multi_action",title:{text:"Clear one NPC",color:"red",bold:true},external_title:"Clear one NPC",pause:false,after_action:"close",body:[{type:"minecraft:plain_message",width:300,contents:{text:"Which NPC should go?",color:"white"}}],columns:1,actions:$(actions),exit_action:{label:"Cancel"}}
