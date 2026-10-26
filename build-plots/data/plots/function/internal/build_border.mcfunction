# xa/xb, za/zb = the border ring just outside the plot; xs/zs = the sign, on the road north of the plot.
$execute unless loaded $(xa) -61 $(za) run return 0
$execute unless loaded $(xb) -61 $(zb) run return 0
$execute unless loaded $(xa) -61 $(zb) run return 0
$execute unless loaded $(xb) -61 $(za) run return 0
$fill $(xa) -61 $(za) $(xb) -61 $(za) smooth_stone
$fill $(xa) -61 $(zb) $(xb) -61 $(zb) smooth_stone
$fill $(xa) -61 $(za) $(xa) -61 $(zb) smooth_stone
$fill $(xb) -61 $(za) $(xb) -61 $(zb) smooth_stone
$setblock $(xs) -60 $(zs) oak_sign[rotation=8]{front_text:{messages:[{text:""},{text:"Plot $(n)",bold:true},{text:""},{text:""}]}}
scoreboard players set @s plot_ok 1
