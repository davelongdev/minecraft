# From storage npc:main fb {id, n, label, k ("say"/"cmd"), text}: empty label = no button, else set it.
execute if data storage npc:main fb{label:""} run return run function npc:internal/form_button_clear with storage npc:main fb
execute if data storage npc:main fb{text:""} run data modify storage npc:main fb.text set value "..."
data modify storage npc:main fb.cmd set from storage npc:main fb.text
# a leading / is forgiven (kids type it anyway): drop the first character when it is a slash
data modify storage npc:main fb.first set string storage npc:main fb.text 0 1
execute if data storage npc:main fb{first:"/"} run data modify storage npc:main fb.cmd set string storage npc:main fb.text 1
execute if data storage npc:main fb{k:"cmd"} run return run function npc:internal/set_button with storage npc:main fb
function npc:internal/set_reply with storage npc:main fb
