# a carrot in the inventory (on trust that a command block gave it)
execute if items entity @s container.* carrot run return 1
return fail
