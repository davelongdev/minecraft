# NPC game (namespace `npc`)

Bedrock-style NPCs in Java, made and edited **in game**: right-click a character and a dialog screen opens with up to
three buttons that run commands or say lines. World `npc-game` in the `26.3_mini_games` Prism instance (a fenced grass
island in the void with two starter characters, Bob the Baker and Mira the Guide). Pack format 107-121.

Making a character (all `/function npc:...`, see `___help` in game):

    ___new {id:"zed",name:"Zed the Wizard"}                  a character where you stand (id: lowercase, no spaces)
    ___greeting {id:"zed",text:"Greetings, mortal."}         what they say when clicked
    ___button {id:"zed",n:1,label:"Zap me",cmd:"effect give @s levitation 3 1"}   button n (1-3) runs a command as the player
    ___reply {id:"zed",n:2,label:"Who are you?",text:"I am Zed."}                 button n just says a line
    ___job {id:"zed",job:"cleric"}   ___rename {id,name}   ___wander {id,on:0}   ___here {id}   ___clear_button {id,n}
    ___delete {id}   ___list   ___respawn

Text can't contain double quotes (it's pasted into SNBT); commands have no leading slash and run as the presser (@s).
Buttons must be filled in order (1, then 2, then 3).

How it works: characters are entries in storage `npc:main npcs` (`{num, id, name, job, greeting, pos, b1..b3}`). Each
one is three entities tagged `npc` + `npc_<id>` with the entry's `num` as an entity score (`npc_num`): a villager body
(no trades, so its own trade screen never opens; AI on unless `___wander 0`), an `interaction` click box, and a
`text_display` name; the tick teleports box and name onto the body. A right-click sets the box's `interaction` NBT;
`internal/clicked` loads the entry into `storage npc:main cur` (`load_cur` flattens labels and trigger numbers),
`execute on target` makes the clicker @s, and `show<n>` runs `dialog show @s {...inline multi_action...}` built by macro,
so no dialog JSON exists on disk. Buttons run `/trigger npc_choice set 100*num+k`; the tick decodes that, fetches
`b<k>.cmd` / `b<k>.say` and runs it (`exec` = `$$(cmd)`) or prints it (`speak`). Fallen bodies are sent home by the tick.

Build and install:

    cd npc-game
    zip -qr ../zips/npc-game.new.zip pack.mcmeta data && mv ../zips/npc-game.new.zip ../zips/npc-game.zip
    cp ../zips/npc-game.zip ~/.var/app/org.prismlauncher.PrismLauncher/data/PrismLauncher/instances/26.3_mini_games/minecraft/saves/npc-game/datapacks/
