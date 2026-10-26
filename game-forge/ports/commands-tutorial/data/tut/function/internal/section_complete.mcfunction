$function tut:s$(sec)/done
execute at @s run playsound minecraft:ui.toast.challenge_complete master @s ~ ~ ~ 1 1
scoreboard players add @s tut_sec 1
scoreboard players set @s tut_ex 0
scoreboard players set @s tut_tick 0
