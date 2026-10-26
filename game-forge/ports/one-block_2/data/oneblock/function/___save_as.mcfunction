# Save the course under a name: run with /function oneblock:___save_as {name:"castle"}
# Names become structure ids (oneblock:save-<name>): lowercase letters, digits,
# _ - or . only. Re-using a name overwrites that save. Named saves show up in
# ___list_saves and are restored with /function oneblock:___restore_named {name:"castle"}
#
# do_save_named refuses to load at all for an invalid name (macro compile
# failure), so the ok flag it sets is how we detect success here.
scoreboard players set ok ob_saves 0
$function oneblock:internal/do_save_named {name:"$(name)"}
$execute unless score ok ob_saves matches 1 run tellraw @s {"text":"Save failed — \"$(name)\" isn't a valid name.","color":"red"}
execute unless score ok ob_saves matches 1 run tellraw @s {"text":"Names may only use lowercase letters, digits, _ - and . (no spaces or capitals), e.g. /function oneblock:___save_as {name:\"castle-2\"}","color":"yellow"}
