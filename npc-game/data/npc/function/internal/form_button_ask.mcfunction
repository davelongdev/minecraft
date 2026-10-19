# From storage npc:main form (entry + n): the "what should button n do?" screen (screen 1 carries the intro text).
execute if data storage npc:main form{n:1} run return run function npc:internal/form_button_ask1 with storage npc:main form
function npc:internal/form_button_askn with storage npc:main form
