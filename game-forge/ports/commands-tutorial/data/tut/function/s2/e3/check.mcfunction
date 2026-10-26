# a repeating, always-active command block on the blue block
execute if block ~12 ~ ~6 repeating_command_block{auto:1b} run return 1
return fail
