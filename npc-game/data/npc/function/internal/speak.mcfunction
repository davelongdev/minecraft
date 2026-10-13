# Macro (name, say): the character says a line in chat to the player who pressed the button.
$tellraw @s [{"text":"$(name): ","color":"gold","bold":true},{"text":"$(say)","color":"white"}]
