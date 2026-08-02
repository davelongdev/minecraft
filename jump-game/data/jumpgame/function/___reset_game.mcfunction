# Reset everyone's jump count: run with /function jumpgame:___reset_game
scoreboard players set @a jumps 0
tellraw @a {"text":"Jump counts reset.","color":"green"}
