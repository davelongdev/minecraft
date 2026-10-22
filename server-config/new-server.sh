#!/bin/bash
# Make a new Fabric server folder next to npc-game. Run as root on the box:
#   new-server.sh <name> <port> <rcon-port> <gamemode> <difficulty> "<motd>" <force-gamemode>
# e.g. new-server.sh survival-basic 25566 25576 survival normal "Survival Basic" false
# Copies launcher jar, Fabric API, eula, whitelist, ops from npc-game, writes
# server.properties and a root-only .env with a fresh RCON password, creates
# logs/ (the JVM flags write logs/gc.log and Java exits 1 without it).
# Does NOT start it: copy a world in first if there is one, then
#   systemctl enable --now minecraft@<name>
set -euo pipefail
SRC=/srv/mc/npc-game
name=$1 port=$2 rport=$3 gm=$4 diff=$5 motd=$6 force=$7
d=/srv/mc/$name
pw=$(head -c 64 /dev/urandom | base64 | tr -dc a-z0-9 | cut -c1-12)

install -d -o minecraft -g minecraft -m 755 "$d" "$d/mods" "$d/logs"
cp "$SRC"/fabric-server-launcher.jar "$SRC"/eula.txt "$SRC"/whitelist.json "$SRC"/ops.json "$d"/
cp "$SRC"/mods/*.jar "$d"/mods/

sed -e "s/^server-port=.*/server-port=$port/" \
    -e "s/^query.port=.*/query.port=$port/" \
    -e "s/^rcon.port=.*/rcon.port=$rport/" \
    -e "s/^rcon.password=.*/rcon.password=$pw/" \
    -e "s/^gamemode=.*/gamemode=$gm/" \
    -e "s/^difficulty=.*/difficulty=$diff/" \
    -e "s/^force-gamemode=.*/force-gamemode=$force/" \
    -e "s/^pvp=.*/pvp=false/" \
    -e "s/^motd=.*/motd=$motd/" \
    -e "s/^level-seed=.*/level-seed=/" \
    -e "/^management-server-secret=/d" \
    -e "/^#/d" \
    "$SRC"/server.properties > "$d"/server.properties
grep -q '^pvp=' "$d"/server.properties || echo "pvp=false" >> "$d"/server.properties

chown -R minecraft:minecraft "$d"
printf 'HEAP=3G\nRCON_PORT=%s\nRCON_PASSWORD=%s\n' "$rport" "$pw" > "$d"/.env
chown root:root "$d"/.env
chmod 600 "$d"/.env
echo "made $d (port $port, rcon $rport)"
