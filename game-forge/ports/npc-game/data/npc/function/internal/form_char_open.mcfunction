# Macro (id): open the character form for id, or for a new character when id is "new".
# Fills storage npc:main form (current values or blanks, dropdown flags, template placeholders) and shows the dialog.
data modify storage npc:main form set value {}
$data modify storage npc:main form.id set value "$(id)"
$data modify storage npc:main form.name set from storage npc:main npcs[{id:"$(id)"}].name
$data modify storage npc:main form.job set from storage npc:main npcs[{id:"$(id)"}].job
$data modify storage npc:main form.greeting set from storage npc:main npcs[{id:"$(id)"}].greeting
execute unless data storage npc:main form.name run data modify storage npc:main form.name set value ""
execute unless data storage npc:main form.job run data modify storage npc:main form.job set value "none"
execute unless data storage npc:main form.greeting run data modify storage npc:main form.greeting set value ""
execute if data storage npc:main form{id:"new"} run data modify storage npc:main form.title set value "New character"
execute if data storage npc:main form{id:"new"} run data modify storage npc:main form.yes set value "Create"
execute unless data storage npc:main form{id:"new"} run data modify storage npc:main form.title set value "Edit character"
execute unless data storage npc:main form{id:"new"} run data modify storage npc:main form.yes set value "Save"
# $(name) etc. in the dialog's command template must reach the dialog as text, so they come in as macro values (set in load)
data modify storage npc:main form.ph_name set from storage npc:main ph.name
data modify storage npc:main form.ph_job set from storage npc:main ph.job
data modify storage npc:main form.ph_greeting set from storage npc:main ph.greeting
function npc:internal/form_jobflags with storage npc:main form
function npc:internal/form_char with storage npc:main form
