# Chat Counter (server-only Fabric mod)

Counts each player's chat messages in the `chat_count` scoreboard objective, so a data pack can check
"did they say something in chat?" (Command Forge quest 2). Does nothing unless a pack has made the
objective (`scoreboard objectives add chat_count dummy`). Keeps `#mod chat_count` at 1 every tick; packs
reset it on load, so `execute unless score #mod chat_count matches 1` means "no mod here, pass on trust".

Server-only (`environment: server`), registers nothing: vanilla 26.3 clients join as usual.

Build on the dell box (JDK 25; the laptop's default JDK 27 can't run this Gradle):

    ./gradlew build        # -> build/libs/chat-counter-1.0.0.jar

then copy the jar into a server's `mods/` and restart it. The Gradle wrapper files come from
FabricMC/fabric-example-mod (Gradle 9.8.2).
