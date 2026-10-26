# Restore a named save point: run with /function oneblock:___restore_named {name:"castle"}
# Only names recorded by ___save_as are accepted; ___list_saves shows them.
$execute unless data storage oneblock:main saves[{name:"$(name)"}] run tellraw @s {"text":"No save named \"$(name)\" — /function oneblock:___list_saves shows what exists.","color":"yellow"}
$execute if data storage oneblock:main saves[{name:"$(name)"}] run function oneblock:internal/restore_named {name:"$(name)"}
