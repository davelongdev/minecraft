# Macro (c = 100*num + k): a dialog button was pressed. The dialog's run_command runs this as (and at) the presser.
$scoreboard players set v npc_tmp $(c)
function npc:internal/button
