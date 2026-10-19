# Edited character from the form: an empty box keeps the old value.
execute unless data storage npc:main form{name:""} run function npc:internal/rename with storage npc:main form
function npc:internal/set_job with storage npc:main form
data modify storage npc:main form.text set from storage npc:main form.greeting
execute unless data storage npc:main form{greeting:""} run function npc:internal/set_greeting with storage npc:main form
