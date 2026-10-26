# Quest 1's "Try it" button (trigger tut_btn 7): a [Done!] link in chat, spaced out with blank lines (Dave 2026-10-26).
# Clicking a chat line needs the chat box open, so the click (trigger tut_btn 8 -> s1/e0/done) proves the player
# opened chat with t. The Esc line comes after the click (s1/e0/done).
tellraw @s ""
tellraw @s [{"text":"","font":"minecraft:uniform","color":"white"},{"text":"Press ","font":"minecraft:uniform"},{"text":"t","font":"minecraft:uniform","color":"aqua","bold":true},{"text":", then click ","font":"minecraft:uniform"},{"text":"[Done!]","font":"minecraft:uniform","color":"green","bold":true,"underlined":true,"click_event":{"action":"run_command","command":"trigger tut_btn set 8"},"hover_event":{"action":"show_text","value":{"text":"Click me","font":"minecraft:uniform"}}}]
tellraw @s ""
