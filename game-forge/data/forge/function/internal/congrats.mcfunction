# As a player who pressed Continue on the Commands-tutorial finish screen: the big title, after the screen is gone.
title @s times 5 60 10
title @s subtitle {"text":"You finished the Commands tutorial!","color":"yellow"}
title @s title {"text":"Congratulations!","color":"green","bold":true}
execute at @s run playsound minecraft:ui.toast.challenge_complete master @s ~ ~ ~ 1 1
