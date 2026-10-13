# Which tile am I on? /function tile:___where
function tile:internal/here
execute if score ok tile_tmp matches 1 run tellraw @s [{"text":"You're on tile (","color":"aqua"},{"score":{"name":"px","objective":"tile_tmp"},"color":"aqua"},{"text":", ","color":"aqua"},{"score":{"name":"pz","objective":"tile_tmp"},"color":"aqua"},{"text":").","color":"aqua"}]
