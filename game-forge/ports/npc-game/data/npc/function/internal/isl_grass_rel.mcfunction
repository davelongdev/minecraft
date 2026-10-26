# Pass 2: grass floor, the BACK TO MAIN ISLAND button (a marker with no npc_pid = main island), bedrock marker = done.
execute if block ~ ~-2 ~ bedrock run return 0
execute unless block ~ ~ ~ stone run return 0
fill ~-10 ~ ~-10 ~10 ~ ~10 grass_block
setblock ~3 ~1 ~ stone
setblock ~3 ~2 ~ polished_blackstone_button[face=floor]
setblock ~2 ~1 ~ oak_wall_sign[facing=west]{front_text:{messages:[{text:"BACK TO"},{text:"MAIN ISLAND"},{text:""},{text:""}]},is_waxed:1b}
execute positioned ~3 ~2 ~ align xyz positioned ~0.5 ~0.5 ~0.5 unless entity @e[type=marker,tag=npc_isl,distance=..0.2] run summon marker ~ ~ ~ {Tags:["npc_isl"]}
setblock ~ ~-2 ~ bedrock
