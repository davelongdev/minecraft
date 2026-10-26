# Quest 1's [Done!] chat link (trigger tut_btn 8, only while on quest 1). The chat box is still open now, so
# "Great job!" waits until they close it (internal/view_mark, s1/e0/check).
tellraw @s [{"text":"","font":"minecraft:uniform","color":"white"},{"text":"Good job! Now press ","font":"minecraft:uniform"},{"text":"Esc","font":"minecraft:uniform","color":"aqua","bold":true},{"text":" to close the window.","font":"minecraft:uniform"}]
tellraw @s ""
function tut:internal/view_mark
