# Macro (id, name): are you sure?
$dialog show @s {type:"minecraft:confirmation",title:{text:"Delete $(name)?",color:"red",bold:true},external_title:"Delete $(name)?",pause:false,body:[],yes:{label:{text:"Delete",color:"red"},action:{type:"minecraft:run_command",command:"function npc:internal/delete {id:\"$(id)\"}"}},no:{label:"Keep"}}
