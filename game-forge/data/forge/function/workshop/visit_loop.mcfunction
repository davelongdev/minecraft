function forge:workshop/visit_line with storage forge:main ws_work[0]
data remove storage forge:main ws_work[0]
execute if data storage forge:main ws_work[0] run function forge:workshop/visit_loop
