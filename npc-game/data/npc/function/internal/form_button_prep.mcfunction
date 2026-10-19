# Macro (n): from storage npc:main form (entry + n + k), fill l (label), t (current dialogue or command), tlabel
# (the text box label for this kind), yes (button text), ph_* placeholders; then show the fill-in screen.
data modify storage npc:main form.l set value ""
data modify storage npc:main form.t set value ""
$execute if data storage npc:main form.b$(n).label run data modify storage npc:main form.l set from storage npc:main form.b$(n).label
$execute if data storage npc:main form.b$(n).say run data modify storage npc:main form.t set from storage npc:main form.b$(n).say
$execute if data storage npc:main form.b$(n).cmd run data modify storage npc:main form.t set from storage npc:main form.b$(n).cmd
data modify storage npc:main form.tlabel set value "What does the NPC say?"
execute if data storage npc:main form{k:"cmd"} run data modify storage npc:main form.tlabel set value "Command to run (no slash; @s = the player who pressed the button)"
data modify storage npc:main form.yes set value "Next"
execute if data storage npc:main form{n:3} run data modify storage npc:main form.yes set value "Save"
data modify storage npc:main form.ph_l set from storage npc:main ph.l
data modify storage npc:main form.ph_t set from storage npc:main ph.t
function npc:internal/form_button_screen with storage npc:main form
