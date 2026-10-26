# Passes once the [Done!] link from "Try it" was clicked in chat (s1/e0/done; needs the chat box open) and the player
# has closed chat again (their view or position changed since the click).
execute unless score @s tut_flag matches 1 run return fail
execute if function tut:internal/view_moved run return 1
return fail
