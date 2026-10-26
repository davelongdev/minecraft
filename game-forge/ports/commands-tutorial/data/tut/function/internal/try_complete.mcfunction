# Macro (sec, ex, px, pz): complete the current quest if its check passes, else a "not completed yet" notice.
# Reached from quest 1's [Done!] chat link (s1/e0/done) and the old /trigger tut_btn set 6.
$execute unless score @s tut_sec > maxsec tut_const if function tut:s$(sec)/e$(ex)/check run function tut:internal/complete with storage tut:main args
$execute unless score @s tut_sec > maxsec tut_const unless function tut:s$(sec)/e$(ex)/check run dialog show @s {type:"minecraft:notice",title:{text:"Quest not completed yet!",color:"red",bold:true},external_title:"Quest not completed yet!",pause:false,body:[{type:"minecraft:plain_message",width:300,contents:{text:"Press the SHOW QUEST button to see what to do.",color:"white"}}],action:{label:"OK"}}
