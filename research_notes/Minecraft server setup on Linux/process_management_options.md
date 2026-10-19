# Running several Minecraft Java 26.3 Fabric servers on one Linux box: process-management options (October 2026)

Scope: one Arch Linux machine (i5-13400, 62 GB RAM, LUKS root), one adult admin, 3–6 small servers for 10–20 kids, vanilla clients, server-side-only Fabric mods + datapacks. Everything below was checked 2026-10-18/19 unless marked otherwise. Items marked **(1.21.x-era)** come from material written before the 26.x date-based versions.

## Baseline facts that every option inherits (versions, Java, Fabric artifacts)

### Takeaway
Minecraft 26.3 is the current release, declares Java 25 in Mojang's own manifest, and the whitelist is now on by default. Fabric for 26.3 = Loader 0.19.5 (stable; 0.20.0 exists but is flagged unstable), Installer 1.1.2, Fabric API 0.163.0+26.3; the one-file "fabric-server-launcher" jar is served from a predictable meta URL, which is what makes scripted upgrades to 26.4 easy under every option.

### Cited Findings
- Mojang's version manifest lists `latest.release = 26.3`, `latest.snapshot = 26.4-snapshot-4`; the 26.3 version JSON declares `javaVersion.majorVersion: 25` (component `java-runtime-epsilon`) and the server jar at `https://piston-data.mojang.com/v1/objects/33680f5f2ac32864d6d7cf5e56a705fdb3e05f4c/server.jar` — [piston-meta version_manifest_v2.json](https://piston-meta.mojang.com/mc/game/version_manifest_v2.json) (queried 2026-10-19).
- The Arch wiki's Java-requirement table now reads `>= 26.1 → 25`, `1.20.5–1.21.11 → 21` — [Arch wiki: Minecraft](https://wiki.archlinux.org/title/Minecraft).
- A 26.x jar started on Java 21 fails immediately with an unsupported-class-file-version error ("class file version 69" = Java 25) — [space-node 26.3 server update guide](https://space-node.net/blog/minecraft-26-3-server-update-guide-2026) (third-party hosting blog).
- Fabric meta (queried 2026-10-19): game `26.3` stable (26.4-snapshot-1..4 unstable); loader `0.19.5` stable, `0.20.0` present but `stable: false`; installer `1.1.2` stable — [meta.fabricmc.net /v2/versions/game](https://meta.fabricmc.net/v2/versions/game), [/loader](https://meta.fabricmc.net/v2/versions/loader), [/installer](https://meta.fabricmc.net/v2/versions/installer).
- The combined server launcher jar is a single download: `https://meta.fabricmc.net/v2/versions/loader/26.3/0.19.5/1.1.2/server/jar` returns HTTP 200 `application/java-archive` (verified with `curl -I` 2026-10-19) — [meta.fabricmc.net](https://meta.fabricmc.net/v2/versions/loader/26.3/0.19.5/1.1.2/server/jar).
- Fabric API for 26.3 on Modrinth: `0.163.0+26.3` (2026-10-14), `0.162.0+26.3` (2026-10-06), `0.161.0+26.3` (2026-09-18) — [Modrinth API, project fabric-api](https://api.modrinth.com/v2/project/fabric-api/version?game_versions=%5B%2226.3%22%5D&loaders=%5B%22fabric%22%5D).
- `server.properties` in 26.3: `white-list` default changed to `true` in 26.3 Snapshot 2; `pause-when-empty-seconds` default `60` (added 1.21.2, pauses the server tick loop when nobody is on); `max-tick-time` default `60000` ms, `-1` disables the watchdog; `enable-rcon` default `false`, `rcon.port` 25575, RCON is unencrypted so the wiki recommends localhost-only; `enforce-whitelist` default `false` — [Minecraft Wiki: Server.properties](https://minecraft.wiki/w/Server.properties).
- Status snapshot in a third-party guide (Sept/Oct 2026): Paper and NeoForge 26.3 still beta, Fabric stable, Geyser only supports 26.2, worlds upgraded to 26.3 can't be downgraded — [space-node 26.3 guide](https://space-node.net/blog/minecraft-26-3-server-update-guide-2026) (unverified against PaperMC's own pages).

### Inferences
- Because the launcher jar URL encodes `<mc>/<loader>/<installer>`, a 26.3 → 26.4 upgrade under the native option is literally "download the new URL, point ExecStart at it, restart"; under itzg it is "change `VERSION`"; under panels it is "change the egg/instance variable and reinstall". The world and `mods/` stay in place in all cases; only mod jars with a `26.3`-only dependency need new builds.
- `pause-when-empty-seconds` (vanilla, default 60 s) makes 3–6 mostly idle servers cheap on CPU without any wrapper magic; it is the reason itzg's own docs now discourage their container-level autopause (see below).

### Gaps
- I did not find an official Mojang/Fabric statement on whether 26.4 will keep Java 25; the 26.4 snapshots are in Fabric meta but I did not fetch their `javaVersion`.

## Option 1 — Plain native: distro JDK 25, one Fabric launcher per game, one systemd unit per server

### Takeaway
On Arch this is a `pacman -S jre25-openjdk-headless` plus either the AUR `fabric-server` package (tmux-wrapped `fabricd` script, one server only) or hand-written `minecraft@.service` templates (one per game, dedicated `minecraft` user, RCON or a tmux/FIFO for stdin). It has the smallest footprint and is the only option where the Arch wiki and AUR give first-class support; the cost is that console access, backups, per-instance limits, and file management are all things you wire yourself with systemd features.

### Cited Findings
**Packages on Arch**
- `extra/jre25-openjdk-headless 25.0.4.1.u1-1` and `extra/jdk25-openjdk 25.0.4.1.u1-1` are in the official repos (local `pacman -Si`, 2026-10-19). This machine currently has `jdk-openjdk 27.u35-1` (default) and `jdk21-openjdk`, plus `docker 1:29.9.1-1`, `docker-buildx`, `tmux 3.8`, `screen 5.0.2` installed (local `pacman -Q`; `archlinux-java status` shows java-27 default). Switch defaults with `archlinux-java` — [Arch wiki: Minecraft](https://wiki.archlinux.org/title/Minecraft).
- AUR `minecraft-server 26.3-1` (last modified 2026-09-15, maintainer Gordian Edenhofer): depends `java-runtime-headless>=16 tmux sudo bash awk sed`, optdepends `tar` (backups) and `netcat` (idle suspend); installs Mojang's `server.jar` as `/srv/minecraft/minecraft_server.jar`, logs symlinked to `/var/log/minecraft`, `SERVER_START_CMD="java -Xms512M -Xmx1024M -jar ./minecraft_server.jar nogui"` — [AUR RPC](https://aur.archlinux.org/rpc/v5/info?arg[]=minecraft-server), [PKGBUILD (GitHub mirror)](https://raw.githubusercontent.com/archlinux/aur/minecraft-server/PKGBUILD).
- AUR `fabric-server 26.3_0.19.5_1.1.2-1` (last modified 2026-09-18, maintainer jSQrD): depends `java-runtime-headless>=21 tmux sudo bash awk sed`; `prepare()` runs `fabric-installer-1.1.2.jar server -mcversion 26.3 -downloadMinecraft -loader 0.19.5`; installs `/srv/fabric/fabric-server-launch.jar` + `server.jar` + `libraries/`, user `fabric`, control script `fabricd`, config `/etc/conf.d/fabric`, logs `/var/log/fabric`; start cmd `java -Dlog4j2.formatMsgNoLookups=true -Xms512M -Xmx1024M -jar ./fabric-server-launch.jar nogui` — [AUR RPC](https://aur.archlinux.org/rpc/v5/info?arg[]=fabric-server), [PKGBUILD (GitHub mirror)](https://raw.githubusercontent.com/archlinux/aur/fabric-server/PKGBUILD). Note the package's Java dependency floor (`>=21`) is below what 26.3 actually needs (25).
- AUR `mcrcon 0.7.2-1` (last modified 2021-10-31, depends only on glibc) — [AUR RPC](https://aur.archlinux.org/rpc/v5/info?arg[]=mcrcon). No `fabric-server-launcher` package exists in the AUR (RPC returned no such name; the Fabric package is `fabric-server`).
- Also in the AUR: `papermc 26.2+b112-1`, `pterodactyl-panel 1.15.1-1` (deps php, php-gd, php-sodium; optdeps redis, mariadb, pterodactyl-wings), `ampinstmgr 2.8.0.4-1` (deps tmux socat dnsutils jq qrencode mono; optdeps jre8/jre-openjdk-headless, steamcmd, docker) — [AUR RPC](https://aur.archlinux.org/rpc/v5/info?arg[]=papermc&arg[]=pterodactyl-panel&arg[]=ampinstmgr). No AUR packages named `crafty-controller`, `mcsmanager`, `pufferpanel`, or `pelican-panel` were returned.

**How the AUR packages run the server (the Edenhofer management script)**
- The script "depends on tmux to fork the server into the background and communicate with it"; querying players and issuing console commands is done through tmux; while offline it can `netcat`-listen on the port and start on first connection (`IDLE_SERVER`) — [Edenhofer/minecraft-server README](https://github.com/Edenhofer/minecraft-server).
- Shipped unit: `Type=forking`, `ExecStart=/usr/bin/<name>d start`, `ExecStop=/usr/bin/<name>d stop`, `User=/Group=<game user>`, `After=local-fs.target network.target multi-user.target`, no hardening directives, no `Restart=` — [minecraftd.service.in](https://raw.githubusercontent.com/Edenhofer/minecraft-server/master/minecraftd.service.in). `server_stop()` sends `save-all` then `stop` into the tmux session (with a warning/wait when players are online) — [minecraftd.sh.in](https://raw.githubusercontent.com/Edenhofer/minecraft-server/master/minecraftd.sh.in). Also installs a daily `minecraftd-backup.timer` (`OnCalendar=daily`, `Persistent=true`) keeping `KEEP_BACKUPS` (default 10) tarballs — [minecraftd-backup.timer.in](https://raw.githubusercontent.com/Edenhofer/minecraft-server/master/minecraftd-backup.timer.in), [Arch wiki: Minecraft/Java Edition server](https://wiki.archlinux.org/title/Minecraft/Java_Edition_server).
- Arch wiki usage: `minecraftd {start|stop|restart|status|backup|restore|command <cmd>|console}`; `minecraftd console` attaches tmux (detach `ctrl+b d`); tune RAM in `/etc/conf.d/minecraft`; accept EULA at `/srv/minecraft/eula.txt`; recommends adding yourself to the `minecraft` group to edit files — [Arch wiki: Minecraft/Java Edition server](https://wiki.archlinux.org/title/Minecraft/Java_Edition_server).
- The `fabric-server` package provides the same interface as `fabricd` ("replace minecraftd with fabricd") — [Arch wiki: Minecraft/Java Edition server](https://wiki.archlinux.org/title/Minecraft/Java_Edition_server).
- The `sysusers` file creates the game user with home = server root and `/bin/bash` — [minecraftd.sysusers.in](https://raw.githubusercontent.com/Edenhofer/minecraft-server/master/minecraftd.sysusers.in).

**Hand-written hardened units (community patterns)**
- A published set of per-flavour units uses: `Type=simple`, `User=minecraft`, `Group=minecraft`, `Nice=5`, `KillMode=none`, `ProtectHome=true`, `ProtectSystem=full`, `ProtectControlGroups=true`, `ProtectKernelModules=true`, `ProtectKernelTunables=true`, `PrivateDevices=true`, `NoNewPrivileges=true`, `PrivateTmp=true`, `ReadWriteDirectories=/srv/minecraft/<flavour>/server` (= `WorkingDirectory`), `ExecStart=/usr/bin/java -Xmx2G -Xms2G -jar <jar> --noconsole`, `ExecStop=<helper> directstop`, `Restart=on-failure`, `RestartSec=5s`, `WantedBy=multi-user.target` — [adamsdesk/minecraft-systemd-services commit](https://git.nixnet.services/adamsdesk/minecraft-systemd-services/commit/97d58d1e6303724b3df12fd2c65fc4e85ed109e0).
- Common guide pattern: `ExecStop` calls `mcrcon -H 127.0.0.1 -P <port> -p <password> stop` (RCON must be enabled in server.properties), `KillMode=none` so systemd lets the RCON stop finish; password-in-unit is a known wart (chmod the unit or use a credentials file); `ProtectSystem=full` makes `/usr /boot /etc` read-only inside the unit, so stricter levels need the server dir in `ReadWritePaths` — [WebSearch summary of linuxize/howtoforge/GitHub unit examples](https://linuxize.com/post/how-to-make-minecraft-server-on-ubuntu-20-04/) **(1.21.x-era and older)**.
- Arch wiki on hardening: only system service units can be sandboxed; `systemd-analyze security <unit>` scores a unit; use `CapabilityBoundingSet`/`AmbientCapabilities` together; misconfiguration errors are vague, bump `systemctl log-level debug` — [Arch wiki: systemd/Sandboxing](https://wiki.archlinux.org/title/Systemd/Sandboxing).

**Debian/Ubuntu differences**
- Ubuntu ships `openjdk-25-jre-headless` 25.0.3+9 in 26.04 (main/security), 25.10 (universe), 24.04 (noble-updates, universe), even 22.04 (security, universe) — [packages.ubuntu.com](https://packages.ubuntu.com/resolute/java/openjdk-25-jre-headless).
- Debian: trixie (13, stable) has `openjdk-25-jre-headless 25.0.4.1+1-1~deb13u1` via security, but it is built as **"Hotspot Zero (headless)"** (the interpreter-only Zero VM), while forky/testing has 25.0.5~7ea with the Hotspot JIT — [packages.debian.org search](https://packages.debian.org/search?keywords=openjdk-25-jre-headless&searchon=names&exact=1&suite=all&section=all). (Pelican's docs also say Debian 11 lacks SQLite support for the panel — see Option 3.)

### Inferences
- The AUR `fabric-server` package hardcodes one server root (`/srv/fabric`), one user (`fabric`), one unit (`fabricd.service`), so for 3–6 servers you either (a) build 3–6 copies of the Edenhofer script with different `GAME=/INAME=/SERVER_ROOT=` via its `make` variables, or (b) skip the package and write a `minecraft@.service` template with `WorkingDirectory=/srv/minecraft/%i`, `EnvironmentFile=/srv/minecraft/%i/env`, and a `/srv/minecraft/%i/fabric-server-launcher.jar` downloaded from the meta URL above. (b) is what the community units do.
- Sample unit synthesized from the sources above (not copied from any one source):
  ```
  [Unit]
  Description=Minecraft Fabric server %i
  After=network-online.target
  Wants=network-online.target
  [Service]
  Type=simple
  User=minecraft
  Group=minecraft
  WorkingDirectory=/srv/minecraft/%i
  EnvironmentFile=/srv/minecraft/%i/env          # JAVA_OPTS, RCON_PORT, RCON_PASS
  ExecStart=/usr/lib/jvm/java-25-openjdk/bin/java $JAVA_OPTS -jar fabric-server-launcher.jar nogui
  ExecStop=/usr/bin/mcrcon -H 127.0.0.1 -P ${RCON_PORT} -p ${RCON_PASS} "say Server stopping" "save-all" "stop"
  TimeoutStopSec=90
  Restart=on-failure
  RestartSec=10
  SuccessExitStatus=0 143
  MemoryMax=6G
  CPUWeight=100
  NoNewPrivileges=true
  PrivateTmp=true
  PrivateDevices=true
  ProtectSystem=strict
  ProtectHome=true
  ReadWritePaths=/srv/minecraft/%i
  ProtectKernelTunables=true
  ProtectKernelModules=true
  ProtectControlGroups=true
  [Install]
  WantedBy=multi-user.target
  ```
  `Type=simple` with `ExecStop` over RCON avoids tmux entirely; `KillMode=none` is deprecated in current systemd, so rely on `TimeoutStopSec` + the RCON `stop` instead. The Java path on Arch is `/usr/lib/jvm/java-25-openjdk/bin/java` (standard Arch layout), which sidesteps `archlinux-java` defaults (this box defaults to Java 27).
- Console access without tmux: `mcrcon` for commands, `journalctl -u minecraft@<name> -f` or `/srv/minecraft/<name>/logs/latest.log` for output. If you want a real interactive stdin, the AUR packages' tmux approach or a `Sockets=`/FIFO is needed; the itzg wrapper's named-pipe trick is the Docker equivalent.
- Resource caps per instance come for free from systemd cgroups (`MemoryMax=`, `CPUQuota=`, `CPUWeight=`); set `-Xmx` below `MemoryMax` with headroom (itzg's docs suggest ~25 % non-heap headroom, see Option 2).
- Mods/datapacks: copy jars into `/srv/minecraft/<name>/mods/` and zips into `/srv/minecraft/<name>/world/datapacks/` as the `minecraft` user, then `/reload` (datapacks) or restart (mods). Nothing automates this natively; a small script or `rsync` from `~/minecraft/zips/` is the realistic answer.
- Upgrade 26.3 → 26.4: fetch `https://meta.fabricmc.net/v2/versions/loader/26.4/<loader>/<installer>/server/jar`, drop it in place, restart; keep the old jar to roll back (worlds can't be downgraded once upgraded per the hosting-blog note).

### Gaps
- The Arch wiki's Minecraft pages were reachable only via `action=raw` (the HTML pages are behind Anubis bot protection); the wiki has no hardened-unit sample of its own, so the unit above is my synthesis.
- I could not retrieve a current, authoritative statement on whether `KillMode=none` still works (it is deprecated upstream); verify with `systemd --version` on this box.
- No Arch-specific source states a recommended `-Xmx` for a 10–20-player Fabric server; community rule of thumb (2–4 GB) is not cited here.

## Option 2 — Docker with itzg/minecraft-server (+ docker compose, + itzg/mc-backup)

### Takeaway
The itzg image is the most actively maintained path (release 2026.10.0 on 2026-10-10; `latest` = Java 25 on Ubuntu), does the Fabric install, mod/datapack fetching (Modrinth), RCON console, graceful SIGTERM→`stop`, health checks, and backups declaratively per compose service; multiple servers = multiple services with different host ports. Caveats: don't use its container-level autopause on 26.x (vanilla pauses itself; a Sept 2026 bug let the watchdog kill resumed servers), and a 2026-10-16 `java25` rebuild crashed on CPUs without AVX (not an i5-13400 concern).

### Cited Findings
**Image tags / Java**
- `latest`, `stable`, `java25` = Java 25, Ubuntu, Hotspot (amd64/arm64/riscv64); `java25-alpine`, `java25-jdk`, `java25-graalvm` also exist; `java21*`, `java17*`, `java8/11/16` for older MC; `latest` "shifts to … the latest Java version that Mojang requires for the latest Minecraft version" — [itzg docs: Java versions](https://docker-minecraft-server.readthedocs.io/en/latest/versions/java/).
- Releases 2026: 2026.10.0 (10 Oct: Modrinth "most stable version" option, Temurin 8 base bump), 2026.9.2 (25 Sep: `REMOVE_OLD_CONFIGS`, `PRE_START_SCRIPT`, reads Java release from `$JAVA_HOME/release`), 2026.9.0 (5 Sep: hardening — pins gosu, rejects zip-slip, fails closed on download errors), 2026.8.0 (4 Aug: Metalcape knockd build for Java 25, compact object headers on Java 24+, GraalVM variants restored), 2026.7.x — [GitHub releases](https://github.com/itzg/docker-minecraft-server/releases). GitHub shows 14,449 stars, pushed 2026-10-19 (gh api).
- 26.x-related issues: #4280 "Quilt fails to install on 26.3" (closed 2026-09-19); #4342 and #4343 (closed 2026-10-17): the `java25` image rebuilt 2026-10-16 (Temurin 25.0.4.1) SIGILL-crashes on CPUs without AVX (Pentium Gold G6400, Celeron J4125) — pin `2026.9.2-java25` as a workaround; #4301 (closed 2026-09-30): autopause's `MAX_TICK_TIME=-1` never reached server.properties so the watchdog killed resumed servers; #4157 (July 2026) java21-alpine wrong class version — [gh search issues](https://github.com/itzg/docker-minecraft-server/issues?q=26.3).

**Fabric**
- `TYPE=FABRIC` installs the latest launcher + latest loader for `VERSION` (defaults to latest vanilla release); pin with `FABRIC_LOADER_VERSION` and `FABRIC_LAUNCHER_VERSION` (= installer version); `FABRIC_LAUNCHER` / `FABRIC_LAUNCHER_URL` for custom jars; `FABRIC_FORCE_REINSTALL=true` to redo a corrupt launcher; Fabric API via `MODRINTH_PROJECTS=fabric-api` — [itzg docs: Fabric](https://docker-minecraft-server.readthedocs.io/en/latest/types-and-platforms/server-types/fabric/).

**Mods and datapacks**
- `MODRINTH_PROJECTS` entries: `project`, `project:version`, `project:release|beta|alpha` (append `+` to prefer most-stable), prefixes `datapack:`/`fabric:`/`forge:`/`paper:`, `project?` = optional, `@/path/listing.txt`; examples `fabric-api:0.119.2+1.21.4`, `datapack:terralith:2.5.5`; `MODRINTH_DOWNLOAD_DEPENDENCIES=none|required|optional`; `MODRINTH_PROJECTS_DEFAULT_VERSION_TYPE`; removing an entry deletes its jar, old versions auto-cleaned at startup — [itzg docs: Modrinth](https://docker-minecraft-server.readthedocs.io/en/latest/mods-and-plugins/modrinth/).
- `MODS` / `MODS_FILE`: comma/newline list of URLs, container paths to jars or dirs; removed entries are deleted; a `/mods` mount is synced into `/data/mods` (`COPY_MODS_SRC/DEST`); `REMOVE_OLD_MODS=TRUE` + include/exclude globs — [itzg docs: mods and plugins](https://docker-minecraft-server.readthedocs.io/en/latest/mods-and-plugins/).
- `DATAPACKS` / `DATAPACKS_FILE` install from URLs or container paths into `/data/$LEVEL/datapacks`; `REMOVE_OLD_DATAPACKS=true` removes `*.zip` there (depth default 16, include/exclude); VanillaTweaks packs go into `$LEVEL` with old versions cleaned; `WORLD=` imports a zip/tar/dir containing `level.dat` into `$LEVEL` (only if absent; `FORCE_WORLD_COPY=TRUE` overwrites every start) — [itzg docs: world data](https://docker-minecraft-server.readthedocs.io/en/latest/misc/world-data/).

**Memory, JVM, properties**
- `MEMORY` default `1G` sets Xms and Xmx; `INIT_MEMORY`/`MAX_MEMORY` separately; percentages allowed (`MaxRAMPercentage`); `MEMORY=""` lets the JVM size from the container limit (25 %); leave ~25 % headroom for non-heap; `USE_AIKAR_FLAGS=true` (flags adjusted at ≥ 12G), `USE_MEOWICE_FLAGS=true` (Java 17+ tuning), `JVM_OPTS`, `JVM_XX_OPTS`, `JVM_DD_OPTS` — [itzg docs: JVM options](https://docker-minecraft-server.readthedocs.io/en/latest/configuration/jvm-options/), [variables](https://docker-minecraft-server.readthedocs.io/en/latest/variables/).
- Other variables: `UID`/`GID` default 1000, `TZ`, `EULA` required, `LEVEL` default `world`, `DIFFICULTY`, `MODE`, `ENABLE_WHITELIST`/`WHITELIST`/`WHITELIST_FILE`/`OVERRIDE_WHITELIST`, `SETUP_ONLY`, rolling logs on by default, `LOG_TIMESTAMP` — [itzg docs: variables](https://docker-minecraft-server.readthedocs.io/en/latest/variables/).

**Console, RCON, stop**
- `ENABLE_RCON` default `true`; `RCON_PASSWORD` randomly generated unless set (or `RCON_PASSWORD_FILE`); `RCON_PORT` 25575 — [variables](https://docker-minecraft-server.readthedocs.io/en/latest/variables/).
- Console: `docker exec -i mc rcon-cli` (interactive) or `docker exec mc rcon-cli stop` (one-shot); `docker attach mc` / `docker compose attach mc` needs `stdin_open: true` + `tty: true`, detach with Ctrl-p Ctrl-q; with RCON disabled set `CREATE_CONSOLE_IN_PIPE=true` and use `mc-send-to-console` — [itzg docs: sending commands](https://docker-minecraft-server.readthedocs.io/en/latest/sending-commands/commands/).
- The Java process runs under `mc-server-runner`, "a process wrapper … to ensure the Minecraft server is stopped gracefully when the container is sent the TERM signal"; flags `-stop-command` (default `stop`), `-stop-duration`, `-stop-server-announce-delay` (skip with SIGUSR1), `-named-pipe` — [itzg/mc-server-runner README](https://github.com/itzg/mc-server-runner). The image passes `--stop-duration ${STOP_DURATION:-60}s` and, if set, `--stop-server-announce-delay` — [scripts/start-finalExec](https://raw.githubusercontent.com/itzg/docker-minecraft-server/master/scripts/start-finalExec).
- `STOP_SERVER_ANNOUNCE_DELAY` (seconds after the shutdown announcement), `STOP_SERVER_DELAY_COMMAND`, `STOP_DURATION` default 60 s; Docker's stop grace period must exceed these (`stop_grace_period:` in compose or `docker compose down -t`); exit code 137 means the grace period was too short; `docker stop --signal SIGUSR1 mc` skips the delay; `PRE_START_SCRIPT` runs a mounted executable before launch — [itzg docs: misc options](https://docker-minecraft-server.readthedocs.io/en/latest/configuration/misc-options/).

**Health, autopause/autostop**
- Built-in `HEALTHCHECK` runs `mc-monitor status` (wrapper `mc-health`); shows in `docker ps`; `DISABLE_HEALTHCHECK=true` or compose `test: ["NONE"]`; `start_period: 1m` example — [itzg docs: healthcheck](https://docker-minecraft-server.readthedocs.io/en/latest/misc/healthcheck/).
- Autopause: the docs now warn "As of 1.21.2 … not recommend to use this feature" because vanilla pauses natively (`PAUSE_WHEN_EMPTY_SECONDS` → `pause-when-empty-seconds`); mechanics: knockd watches the interface, Java process is paused/resumed; needs `max-tick-time` greatly increased or `-1` (`MAX_TICK_TIME`), Paper needs `JVM_DD_OPTS=disable.watchdog:true`; host networking/Portainer/NAS need `AUTOPAUSE_KNOCK_INTERFACE` (default `eth0`, `lo` won't work); rootless needs `CAP_NET_RAW`, maybe `SKIP_SUDO=true` and the slirp4netns port handler; timeouts `AUTOPAUSE_TIMEOUT_EST` 3600 s, `_INIT` 600 s, `_KN` 120 s, `AUTOPAUSE_PERIOD` 10 s; `.paused` / `.skip-pause` marker files; Kubernetes probes must use `mc-health` — [itzg docs: autopause](https://docker-minecraft-server.readthedocs.io/en/latest/misc/autopause-autostop/autopause/).
- Autostop: `ENABLE_AUTOSTOP=TRUE`, `AUTOSTOP_TIMEOUT_EST` 3600 s, `_INIT` 1800 s; requires restart policy `no` (so you restart by hand); incompatible with autopause; "niche" (e.g. Fargate billing); with PROXY protocol set `USES_PROXY_PROTOCOL=true` — [itzg docs: autostop](https://docker-minecraft-server.readthedocs.io/en/latest/misc/autopause-autostop/autostop/).

**Volumes / layout / multiple servers**
- Everything lives under `/data`; bind-mount `./data:/data` (host dir must exist; add `:Z` on Podman/SELinux/AppArmor); anonymous volume otherwise; the container path must always be `/data` — [itzg docs: data directory](https://docker-minecraft-server.readthedocs.io/en/latest/data-directory/).
- Quick start: `docker run -d -it -p 25565:25565 -e EULA=TRUE itzg/minecraft-server`; compose example uses `image: itzg/minecraft-server:latest`, `pull_policy: daily`, `tty: true`, `stdin_open: true`, `./data:/data`; "a management layer such as Docker Compose … is recommended" for long-running servers; setupmc.com generates compose files — [itzg docs: home](https://docker-minecraft-server.readthedocs.io/en/latest/).
- Multiple servers: one compose service per server, each with its own host port (`25565:25565`, `25566:25565`, …) and own volume; `docker compose exec <service> rcon-cli` targets one server — [mintlify mirror of itzg docker-compose docs](https://mintlify.com/itzg/docker-minecraft-server/docker-compose); a 2021 write-up runs two servers on 25566/25567 with `_minecraft._tcp` SRV records per subdomain and wraps compose in a systemd unit **(1.21.x-era, 2021-08-02)** — [kylrth.com](https://kylrth.com/post/minecraft/).
- Deployment docs cover Helm/Kubernetes, Shulker, Ansible (MASH playbook), CloudFormation; **no systemd-for-compose recipe** in the official docs — [itzg docs: deployment](https://docker-minecraft-server.readthedocs.io/en/latest/misc/deployment/).

**Backups: itzg/mc-backup sidecar**
- Sidecar mounts the server's `/data` read-only and writes `/backups`; uses RCON to `save-off`/`save-all`/`save-on` around the copy; methods `tar` (default, gzip, `LINK_LATEST`), `rsync`, `restic`, `rclone`; `BACKUP_INTERVAL` 24h (`0` = one-shot), `INITIAL_DELAY` 2m, `PRUNE_BACKUPS_DAYS` 7, `PAUSE_IF_NO_PLAYERS` false, `PLAYERS_ONLINE_CHECK_INTERVAL` 5m, `RCON_HOST` localhost, `RCON_PASSWORD` default `minecraft`, `EXCLUDES` `*.jar,cache,logs,*.tmp`; on-demand `docker compose exec backups backup now`; compose example has `mc`, a `restore-backup` init container, and `backups` with `depends_on: mc: condition: service_healthy` — [itzg/docker-mc-backup](https://github.com/itzg/docker-mc-backup).

### Inferences
- A per-server compose service for this project would be roughly: `image: itzg/minecraft-server:java25` (or pin `2026.10.0-java25`), `TYPE: FABRIC`, `VERSION: "26.3"`, `FABRIC_LOADER_VERSION: 0.19.5`, `MODRINTH_PROJECTS: fabric-api`, `DATAPACKS: /packs/one-block.zip` with `./zips:/packs:ro`, `MEMORY: 3G`, `USE_AIKAR_FLAGS: "true"`, `ENABLE_WHITELIST`/`WHITELIST`, `RCON_PASSWORD_FILE`, `ports: "2556N:25565"`, `volumes: ./srv-N:/data`, `stop_grace_period: 2m`, `restart: unless-stopped`, plus `deploy.resources.limits.memory` ≈ MEMORY × 1.25. `restart: unless-stopped` + Docker's systemd unit gives on-boot and on-crash restart; the healthcheck does not auto-restart by itself (compose has no auto-heal), so crash recovery relies on the Java process exiting.
- Upgrade to 26.4 = edit `VERSION`, `docker compose up -d`; the image re-downloads the Fabric launcher for the new version at start (its docs describe it as auto-upgrading and recommend `--pull=always`/`pull_policy: daily`). Since `MODRINTH_PROJECTS` re-resolves "latest for VERSION" at every start, Fabric API will follow automatically; hand-copied `mods/` jars won't.
- Logs: `docker logs -f <svc>` (stdout) and the host bind mount `./srv-N/logs/latest.log` (rolling logs on by default).
- Why autopause breaks: it was designed before vanilla's own `pause-when-empty-seconds`; the knockd/SIGSTOP approach fights the tick watchdog (issue #4301), needs the right interface name, extra caps under rootless Docker, and confuses health checks. For 26.3 just leave the vanilla default (60 s) and don't set `ENABLE_AUTOPAUSE`.
- Arch specifics: `pacman -S docker docker-compose` (compose v2 plugin is the `docker-compose` package on Arch; `docker-buildx` is already installed here), `systemctl enable --now docker`, add the admin to the `docker` group (or run rootless, with the `:Z`/UID caveats above). The `UID/GID=1000` default matches the first Arch user. Debian/Ubuntu: `docker.io`/`docker-compose-v2` from the distro or `docker-ce` from Docker's repo; Pelican's docs use `get.docker.com`.

### Gaps
- The itzg docs' "Deployments" page offers no systemd unit for a compose project; the usual `docker-compose@.service` template is community lore, not cited here.
- I found no itzg issue specifically about Fabric on 26.3 (only Quilt #4280 and the AVX crash), so "works" is inferred from the lack of reports plus the Supercraft wiki's October 2026 Paper 26.2→26.3 upgrade test ([supercraft wiki](https://supercraft.host/wiki/minecraft/docker_server_setup/), third-party).

## Option 3 — Pelican (Pterodactyl fork) and Pterodactyl

### Takeaway
Both are full hosting-company stacks (PHP panel + Go daemon "Wings" + Docker, each game server in its own container with its own UID and CPU/RAM/IO limits, SFTP, schedules, backups, sub-users, file manager). Pelican hit v1.0.0-rc.1 on 2026-10-10 (both panel and Wings), needs PHP 8.4/8.5, defaults to SQLite (no MySQL/Redis required), and ships a `java_25` yolk image that the Fabric egg already lists; Pterodactyl is at panel v1.15.1 / Wings v1.13.4 and just opened a v2.0.0 beta (2026-10-14), still needs MySQL/MariaDB + Redis. Neither lists Arch as supported (Debian/Ubuntu/RHEL only; "other OSes might still work"); the only Arch-native artifact is an AUR `pterodactyl-panel 1.15.1` package. Community comparisons put the idle footprint at ~1.5–2 GB and call it hard to justify for one small server.

### Cited Findings
**Pelican**
- Releases: v1.0.0-rc.1 (10 Oct 2026: API wire format frozen, PHP floor 8.4, webhook plugin system, schedule time zones, WebSocket server charts), beta38 (16 Aug), beta37 (13 Aug), beta36 (5 Aug: passkeys, backup hosts, PostgreSQL), beta35 (22 Jun), beta34 (8 May: Laravel 13, Filament v5, drops PHP 8.2), beta30 (Dec 2025: plugin system) — [pelican-dev/panel releases](https://github.com/pelican-dev/panel/releases). Wings v1.0.0-rc.1 also 2026-10-10 (beta29 2026-08-16); repo pushed 2026-10-18 (gh api) — [pelican-dev/wings releases](https://github.com/pelican-dev/wings/releases).
- Panel requirements: OS list Ubuntu 22.04/24.04/26.04, Debian 12/13 (11 partial: no SQLite), AlmaLinux/Rocky 10 (8/9 partial), CentOS 10; "other OSes might still work", docs assume apt; PHP 8.5 (recommended) or 8.4 with gd, mysql, mbstring, bcmath, xml, curl, zip, intl, sqlite3, fpm; web server Apache/NGINX/Caddy; DB = SQLite (libsqlite3 ≥ 3.35) or MySQL 8.4+/MariaDB 10.11+/PostgreSQL 17+; Redis not required on that page; manual install to `/var/www/pelican` via `panel.tar.gz` + Composer; no install script — [pelican.dev: panel getting started](https://pelican.dev/docs/panel/getting-started).
- Redis is an optional driver you switch to (`php artisan p:redis:setup`); queue worker is a systemd unit `pelican-queue` — [pelican.dev: Redis](https://pelican.dev/docs/panel/advanced/redis), [optional config](https://pelican.dev/docs/panel/optional-config).
- Docker alternative for the panel: single service `ghcr.io/pelican/panel:latest`, ports 80/443, volumes `pelican-data:/pelican-data`, `pelican-logs`, env `APP_URL`, `ADMIN_EMAIL`; SQLite by default; no Redis/MySQL containers; web installer at `APP_URL/installer` — [pelican.dev: panel in Docker](https://pelican.dev/docs/panel/advanced/docker).
- Wings: Linux only (no Windows), OS list Ubuntu 22.04/24.04/26.04, Debian 11/12/13, Alma/Rocky 8/9/10, CentOS 10 ("not exhaustive"); needs Docker CE (`curl -sSL https://get.docker.com/ | CHANNEL=stable sudo sh`), no OpenVZ/LXC; binary to `/usr/local/bin/wings`, config `/etc/pelican/config.yml` pasted from the panel's node page (or Auto Deploy command); systemd unit runs as root, `After=docker.service`, `Restart=on-failure`, `LimitNOFILE=4096`; if the panel uses SSL, Wings must too; keep server files on a separate partition — [pelican.dev: Wings install](https://pelican.dev/docs/wings/install).
- Images: `ghcr.io/pelican-eggs/yolks:java_25` (and `java_26`) exist alongside 8/11/16/17/19/21/22 — [pelican-eggs/yolks README](https://github.com/pelican-eggs/yolks). The Fabric egg lists `Java 25 → ghcr.io/pelican-eggs/yolks:java_25`, startup `java -Xms128M -Xmx{{SERVER_MEMORY}}M -jar {{SERVER_JARFILE}}`, stop command `stop`, variables `MC_VERSION`, `FABRIC_VERSION` (installer), `LOADER_VERSION` (defaults `latest`) — [pelican-eggs/minecraft java/fabric/egg-pterodactyl-fabric.json](https://github.com/pelican-eggs/minecraft/blob/main/java/fabric/egg-pterodactyl-fabric.json).
- Same-machine: a RamNode guide says Wings "can be the same VPS or a separate one" and suggests 4 GB+ RAM when co-located; the node config YAML comes from the panel's node page — [RamNode Pelican guide](https://ramnode.com/guides/pelican-panel).

**Pterodactyl**
- Releases: v2.0.0-beta.1/beta.2 (14 Oct 2026: extensions, themes, unified admin, egg catalog, React 19/Laravel 13, PHP 8.3/8.4), v1.15.1 (14 Aug, latest stable), v1.15.0 (3 Aug), v1.12.3 (23 May: "Adds Java 25 to the default Minecraft eggs") — [pterodactyl/panel releases](https://github.com/pterodactyl/panel/releases). Wings v1.13.4 2026-10-14 (gh api).
- Requirements: Ubuntu 22.04/24.04, RHEL/Rocky/Alma 8/9, Debian 11/12/13; PHP 8.2/8.3 + extensions; MySQL ≥ 5.7.22 (8 recommended) or MariaDB ≥ 10.2; **Redis required**; web server; Composer v2; "If you expect to be able to install this with no understanding of basic linux system administration you should stop and turn around now" — [pterodactyl docs getting_started.md](https://github.com/pterodactyl/documentation/blob/master/panel/1.0/getting_started.md).
- `ghcr.io/pterodactyl/yolks:java_25` exists (also java_21–24) — [pterodactyl/yolks README](https://github.com/pterodactyl/yolks).
- AUR `pterodactyl-panel 1.15.1-1` (deps php, php-gd, php-sodium; optdeps redis, mariadb, pterodactyl-wings), last modified 2026-08-14 — [AUR RPC](https://aur.archlinux.org/rpc/v5/info?arg[]=pterodactyl-panel).

**Assessments**
- MineGuard (2026-04-26, DDoS vendor blog): Pterodactyl Panel + Wings idle 1.5–2 GB plus ~30–50 MB per game container; install "10–15 steps, with PHP, MySQL, Redis, Nginx, and Docker"; recommends it (or Pelican "for a fresh deployment without egg lock-in") for commercial/multi-tenant with 5+ users, not for a family server — [mineguard.pro comparison](https://mineguard.pro/en/blog/pterodactyl-vs-crafty-vs-mcsmanager-2026).
- Supercraft wiki (2026): "Pelican if you are starting fresh and accept that it is still in beta"; Pelican/Pterodactyl for multi-game or handing out access; each server in its own container with own uid and limits — [supercraft game server panels compared](https://supercraft.host/wiki/hosting/game_server_panels_compared/) (summary from search snippets; full page timed out twice).

### Inferences
- On Arch, nothing in Pelican's manual-install path is impossible (PHP 8.5, nginx/caddy, sqlite, Docker are all in the repos), but every doc step is apt-shaped and the egg install scripts run inside Docker anyway, so the host distro mostly matters for the panel. The least-friction Arch route is the panel's own Docker compose (SQLite, one container) + Wings binary + Docker, all on one host; expect to debug the node FQDN/SSL pairing yourself since the docs have no "both on localhost" guide.
- Footprint and moving parts (panel container or PHP-FPM, queue worker, cron, Wings daemon as root, Docker, per-server containers, SFTP on 2022) are the price for sub-users, a web file manager, and per-server SFTP — features aimed at renting servers to strangers, not one adult managing six worlds. The rc.1 status means API/plugin churn is still possible.
- Datapacks/mods under Pelican: upload through the web file manager or SFTP into `mods/` and `world/datapacks/` of each server's container volume (`/var/lib/pelican/volumes/<uuid>/`), then restart; version upgrades = change `MC_VERSION`/`LOADER_VERSION` and "Reinstall server".

### Gaps
- No official Pelican page about running panel + Wings on the same host (the sitemap has `guides/docker` and `wings/optional-config`, not fetched); the 127.0.0.1-node specifics remain unverified.
- Pelican's RAM footprint has no first-party number; the 1.5–2 GB figure is MineGuard's for Pterodactyl.
- I did not fetch Pelican's `guides/docker` page, which may describe an all-in-one compose (panel + wings).

## Option 4 — Crafty Controller 4.11.x

### Takeaway
Crafty 4.11.0 (2026-09-16) is the Minecraft-only, single-node Python panel: it forks each `java` process directly on the host (or inside its own container) and drives it over stdin/stdout, gives a web console, scheduler, backups, RBAC and file manager, and its official Docker image now bundles OpenJDK 8/11/17/21/25 so 26.3 works out of the box — but all servers share one UID, there is no per-server SFTP/isolation, Java paths are chosen by hand per server, and the native installer only targets Ubuntu/Debian/CentOS (no AUR package).

### Cited Findings
- Current release v4.11.0 (2026-09-16): OpenGraph previews, custom branding, Hytale log globbing, historical/rotated log viewing, auto-refresh terminal; earlier 4.10.8 (2026-07-29: "Run Now" for schedules), 4.10.7 (2026-06-16: Python 3.10–3.12 compatibility fix, Java server update fix, modded installs on non-Windows) — [GitLab releases API](https://gitlab.com/api/v4/projects/crafty-controller%2Fcrafty-4/releases). README header "Crafty Controller 4.11.0" — [crafty-4 README](https://gitlab.com/crafty-controller/crafty-4/-/raw/master/README.md).
- Official Dockerfile: `FROM ubuntu:24.04`, installs `default-jre openjdk-8-jre-headless openjdk-11-jre-headless openjdk-17-jre-headless openjdk-21-jre-headless openjdk-25-jre-headless` — [Dockerfile](https://gitlab.com/crafty-controller/crafty-4/-/raw/master/Dockerfile). Docker docs' Java table (stale, stops at 1.17+ → Java 17) says you "will need to select the correct one for the server version" by path `/usr/lib/jvm/java-<N>-openjdk-amd64/bin/java`; no auto-detection — [Crafty docs: Docker install](https://docs.craftycontrol.com/pages/getting-started/installation/docker/).
- Docker compose: image `registry.gitlab.com/crafty-controller/crafty-4:latest` or `arcadiatechnology/crafty-4`, `restart: always`, volumes `./docker/{backups,logs,servers,config,import}` → `/crafty/{backups,logs,servers,app/config,import}`, ports 8443 (HTTPS panel), 8000, 8123 (Dynmap), 19132/udp, `25500-25600` MC range, `5520-5550/udp` (Hytale); container runs non-root `crafty:root`, no UID matching needed; README warns Docker-on-WSL/Windows can shred chunks on stop — [README](https://gitlab.com/crafty-controller/crafty-4/-/raw/master/README.md), [Docker docs](https://docs.craftycontrol.com/pages/getting-started/installation/docker/).
- Native Linux: Python 3.9+, automated `crafty-installer-4.0` → `sudo ./install_crafty.sh` (optionally creates a `crafty` systemd service), installs to `/var/opt/minecraft/crafty`, servers in `/var/opt/minecraft/server`; manual steps are apt/dnf only; host-dependency step installs OpenJDK 8 (!), you must install Java yourself; Arch not mentioned — [Crafty docs: Linux install](https://docs.craftycontrol.com/pages/getting-started/installation/linux/).
- Third-party `binhex/arch-crafty-4` image takes `JAVA_VERSION=<8|11|17|21|latest>`; Crafty says it cannot support third-party images — [Docker Hub binhex/arch-crafty-4](https://hub.docker.com/r/binhex/arch-crafty-4).
- Assessments: MineGuard (2026-04): Crafty idle 200–400 MB; servers are native processes; limitations "single-node only. All instances run under one uid, so a compromised plugin can read other servers' files. No per-server SFTP and no native S3"; its pick for "small private or family server on one machine", lock down the UI with TLS/2FA/IP restrictions — [mineguard.pro](https://mineguard.pro/en/blog/pterodactyl-vs-crafty-vs-mcsmanager-2026). Supercraft: "Only Minecraft (or Hytale) on one machine, including a Windows PC: Crafty Controller … Crafty doesn't put game servers in Docker" — [supercraft](https://supercraft.host/wiki/hosting/game_server_panels_compared/).

### Inferences
- On Arch the realistic install is the official Docker image (bundled Java 25, one compose file, port range 25500–25600 published), not the native installer. Each Crafty "server" is a directory under `./docker/servers/<uuid>/` on the host, so mods/datapacks can be dropped in from the host side or via the web file manager; the server-creation wizard downloads Fabric for a chosen MC version, and upgrades go through its update button (the 4.10.7 notes mention fixing "Java server updates").
- Stop semantics: Crafty writes `stop` to the process stdin and has a configurable shutdown timeout; crash restart and boot start are Crafty settings ("crash detection"/"auto start") rather than systemd — with the container `restart: always` for Crafty itself. (Behaviour inferred from its stdin/stdout design; see gap.)
- Since all six servers would run as one `crafty` UID inside one container, the per-instance resource caps are only Java `-Xmx` (set per server in Crafty), not cgroup limits.

### Gaps
- Crafty's docs pages for crash detection/auto-start/shutdown timeout and the Fabric-creation wizard were not fetched; the stop/restart description above is inferred.
- No source confirms whether the Crafty UI exposes Java 25 by default for 26.x servers or still needs the manual path (the docs table is stale at Java 17).

## Option 5 — AMP (CubeCoders, paid)

### Takeaway
AMP is closed-source, licence-keyed (Standard £7.50/$10 for 5 instances and 3 panel users; Professional £15/$30 for 15 instances, unlimited users; per a 2022 forum sheet), installs via a `getamp.sh` script that only knows apt/yum (exit code 10 = "unsupported distribution (neither apt nor yum are present)"), so Arch is unsupported upstream — although an AUR `ampinstmgr 2.8.0.4` package exists. Six servers fit the Standard tier's 5-instance limit only if one is counted as the controller, so Professional is the realistic tier.

### Cited Findings
- Editions sheet (forum post, 2022-10-20): Standard £7.50/$10, 5 instances, 3 panel users, community support, no multi-server; Professional £15/$30, 15 instances, unlimited users, multi-server + webhooks; Advanced £30/$40, 50 instances, branding/OIDC/templates/analytics/geo-filter/"Friends & Family Hosting"; Enterprise variable subscription, commercial use — [CubeCoders Discourse: Editions Comparison Sheet](https://discourse.cubecoders.com/t/editions-comparison-sheet/2247). The sheet does not state whether the fixed prices are one-time; prices may be out of date.
- Installer exit code 10 = "Unsupported distribution (neither apt nor yum are present)" — [CubeCoders Discourse: AMP Exit Code Details](https://discourse.cubecoders.com/t/amp-exit-code-details/2248). A Debian 13 user hit an instance-manager failure with the installer blaming "an unsupported distribution, or the repository being in the middle of a sync" — [Discourse thread](https://discourse.cubecoders.com/t/installing-amp-not-working/35787).
- AUR `ampinstmgr 2.8.0.4-1` (last modified 2026-09-09): deps `tmux socat dnsutils jq qrencode mono`; optdeps `jre8-openjdk-headless`, `jre-openjdk-headless`, `steamcmd`, `docker` — [AUR RPC](https://aur.archlinux.org/rpc/v5/info?arg[]=ampinstmgr).
- A developer licence "can be added to up to 5 simultaneous AMP instances" — [CubeCoders/AMP wiki](https://github.com/cubecoders/amp/wiki/Getting-started-with-AMP-developer-licences).

### Inferences
- AMP's Minecraft module manages Java per instance itself (its optdeps list both `jre8` and current `jre-openjdk-headless`), but whether it can be pointed at Arch's `/usr/lib/jvm/java-25-openjdk` was not verifiable; the Mono dependency and tmux/socat approach show it is a host-process manager like Crafty (with optional Docker mode per the `docker` optdep).
- For a one-adult, Minecraft-only, Arch host, AMP's advantages (polished UI, multi-game, Friends & Family hosting) are mostly moot and the unsupported-distro status plus licence cost put it behind the free options.

### Gaps
- cubecoders.com pages (`/AMP`, `/AMPInstall`) are JS-rendered and returned only "Loading..."; current 2026 prices, the supported-distro list, and Java-25 handling could not be confirmed from first-party pages.

## Option 6 — Others: MCSManager, PufferPanel, MineOS

### Takeaway
MCSManager (v10.21.2, 2026-10-15) is the only panel whose one-line installer explicitly lists Arch Linux; it is a light Node.js web + daemon pair with optional per-instance Docker. PufferPanel is at v3.0.9 (2026-07-14), apt/yum/Docker only, and its own docs say the non-Docker "standard" environment is insecure. MineOS is effectively dormant (last release 2023, last push 2024-10).

### Cited Findings
- MCSManager: releases v10.21.2 (2026-10-15), v10.21.0 (2026-10-14), v10.19.0 (2026-10-04); repo pushed 2026-10-18, 4,989 stars (gh api) — [MCSManager releases](https://github.com/MCSManager/MCSManager/releases). README: Node.js ≥ 16.20.2 (latest LTS recommended), no database; Linux one-liner `sudo su -c "wget -qO- https://script.mcsmanager.com/setup.sh | bash"`, "Script only applies to Ubuntu/Centos/Debian/Archlinux", installs to `/opt/mcsmanager/`, services `mcsm-web` and `mcsm-daemon`; instances run "inside Docker containers or directly as processes", web terminal per instance, multi-user with per-instance assignment — [MCSManager README](https://github.com/MCSManager/MCSManager/blob/master/README.md). MineGuard: 100–200 MB idle, "Docker is optional, toggled per instance. Default is native processes", thin English docs, non-Docker instances share the daemon's uid — [mineguard.pro](https://mineguard.pro/en/blog/pterodactyl-vs-crafty-vs-mcsmanager-2026).
- PufferPanel: v3.0.9 (2026-07-14), v3.0.8 (2026-05-27); repo pushed 2026-10-10, 1,754 stars (gh api) — [pufferpanel releases](https://github.com/pufferpanel/pufferpanel/releases). Docs: supported Ubuntu 22.04/24.04, Debian 10/11, Raspbian (ARM64); apt/yum PackageCloud repos or Docker image `pufferpanel/pufferpanel`; `sudo pufferpanel user add`; `systemctl enable --now pufferpanel`; ports 8080 (web) and 5657 (SFTP); "strongly recommends Docker for running game servers … The 'standard' environment is not secure, lets servers access host files, and should only be used for testing"; Arch not mentioned — [PufferPanel docs: installing](https://docs.pufferpanel.com/en/latest/installing.html).
- MineOS (hexparrot/mineos-node): latest release v1.2.2 "New ISO" 2023-01-28; last push 2024-10-28; 364 stars (gh api) — [mineos-node releases](https://github.com/hexparrot/mineos-node/releases).

### Inferences
- MCSManager is the lightest "real panel" that officially installs on Arch, but its Java handling is "whatever `java` the daemon finds" unless you enable per-instance Docker; with Docker enabled it effectively becomes a lighter Pelican. PufferPanel's own security note means it is Docker-or-nothing for live kids' servers, at which point itzg + compose is simpler.
- MineOS should be treated as unmaintained for 26.x.

### Gaps
- MCSManager's English docs site failed TLS from here, so the Java-version selection UI and the daemon's systemd units were not inspected.

## Cross-cutting: community consensus in 2026 for a small private network

### Takeaway
What I could reach (two 2026 comparison blogs, the Arch wiki, the itzg docs, one r/admincraft user post via a mirror) converges on: a panel is only worth it when you hand access to other people or run other games; for one admin running only Minecraft on one box, either Crafty (if you want a browser UI) or plain itzg containers / systemd units (if you are comfortable in a terminal). No reachable r/admincraft thread states a 2026 consensus directly.

### Cited Findings
- MineGuard 2026-04-26: Crafty for "small private or family server on one machine"; Pterodactyl/Pelican for commercial, multi-tenant, 5+ users; MCSManager for multi-node minimal footprint — [mineguard.pro](https://mineguard.pro/en/blog/pterodactyl-vs-crafty-vs-mcsmanager-2026) (vendor blog).
- Supercraft 2026: "Only Minecraft (or Hytale) on one machine … Crafty"; Pelican/Pterodactyl for several games or giving others access; "Plain Docker suits people who want no panel at all" — [supercraft](https://supercraft.host/wiki/hosting/game_server_panels_compared/).
- An r/admincraft user built their own panel because they wanted each server as its own `itzg/docker-minecraft-server` container with `docker-mc-backup` alongside, contrasting with Crafty's host processes — [redlib mirror of r/admincraft user](https://redlib.hbubli.cc/user/Lazy-Ad-2936).
- Arch wiki: "the management script provided by the AUR packages should suffice most needs"; recommends a dedicated unprivileged user, backups via the script or rsync — [Arch wiki: Minecraft/Java Edition server](https://wiki.archlinux.org/title/Minecraft/Java_Edition_server).
- An older Sponge forum answer recommends a separate Unix account per server as the baseline for a multi-server host **(pre-1.21 era)** — [SpongePowered forums](https://forums.spongepowered.org/t/what-is-a-correct-minecraft-server-setup-on-linux/34576).
- itzg's docs recommend compose/Kubernetes as the management layer for long-running servers — [itzg docs home](https://docker-minecraft-server.readthedocs.io/en/latest/).

### Inferences
- For this specific box (Arch, LUKS root, one admin, 3–6 Fabric servers, datapacks developed locally in `~/minecraft`), the two defensible choices are: (a) itzg + compose, one directory per server with `DATAPACKS`/`MODRINTH_PROJECTS` declared in YAML, `mc-backup` sidecar, and Docker's own restart/boot handling; or (b) native `minecraft@.service` templates with `mcrcon`, if avoiding Docker matters. Crafty is the step up if a browser console/file manager is wanted; Pelican only if the kids or another adult need their own logins.
- Debian/Ubuntu would change nothing about the ranking; they only make Pelican/Pterodactyl/Crafty/PufferPanel/AMP installers work as documented and trade Arch's current Java 25 for Debian trixie's Zero-VM build (avoid: use Adoptium/Temurin or Ubuntu's JIT build there).

### Gaps
- Reddit itself was unreachable (SSL/403 on mirrors); the r/admincraft wiki could not be fetched, so the "consensus" above rests on blogs and one user post.
- The `sumguy.com` Pterodactyl-vs-Pelican-vs-Crafty article returned 403 and the Supercraft comparison timed out on full fetch; only their search snippets were used.
