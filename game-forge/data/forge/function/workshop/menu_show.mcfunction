# Macro (actions): the list is pasted in as SNBT
$dialog show @s {type:"minecraft:multi_action",title:{text:"Personal Workshop",color:"gold",bold:true},external_title:"Personal Workshop",pause:false,after_action:"close",body:[{type:"minecraft:plain_message",width:300,contents:"Welcome back! Which workshop do you want to go to?"}],columns:1,actions:$(actions),exit_action:{label:"Not now"}}
