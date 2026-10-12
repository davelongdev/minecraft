# creative mode and a command block somewhere in the inventory
execute if entity @s[gamemode=creative] if items entity @s container.* command_block run return 1
return fail
