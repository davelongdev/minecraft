# an impulse block on the blue block, an always-active chain block next to it (any side or on top), and cake
execute unless block ~12 ~ ~6 command_block run return fail
execute unless items entity @s container.* cake run return fail
execute if block ~13 ~ ~6 chain_command_block{auto:1b} run return 1
execute if block ~11 ~ ~6 chain_command_block{auto:1b} run return 1
execute if block ~12 ~ ~7 chain_command_block{auto:1b} run return 1
execute if block ~12 ~ ~5 chain_command_block{auto:1b} run return 1
execute if block ~12 ~1 ~6 chain_command_block{auto:1b} run return 1
return fail
