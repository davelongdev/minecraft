# Minecraft Realms (Java) and the vanilla "Online" peer-to-peer feature as hosting for a kids' program (state as of 2026-10-18)

Scope note: Java Edition only. Versions are date-based (26.1, 26.2 "Chaos Cubed" released 2026-06-16, 26.3 "Wilderness Bound" released 2026-09-15; 26.4 snapshots in progress). help.minecraft.net and minecraft.net/realms serve a JavaScript shell to non-browser fetchers, so the official help-center articles below are cited as *located* (URL verified via search snippets) but could not be read in full; wherever a fact comes from a search-engine snippet of an official page rather than the page itself, it is flagged "(snippet)". Secondary/host-blog sources are flagged as such.

## Q1. Pricing, player limits, world slots, and whether more than one world can be active at once

### Takeaway
Java Realms costs US$7.99 per month (recurring, or prepaid 30/90/180-day packs at the same monthly rate), includes one 30-day free trial per account, admits the owner plus 10 simultaneous players, and gives 3 world slots plus a temporary minigame slot, of which exactly one is live at any time. A single Realm therefore cannot run several games concurrently; a program that wants N simultaneous games needs N Realms (N subscriptions) or a different host.

### Cited Findings
- Java Realms price: "Both Java subscriptions cost US$7.99 per month. One is a recurring monthly plan that renews every 30 days. The other is a one-time purchase in 30-, 90-, or 180-day packages that must be renewed manually." No annual Java plan is listed. — [minecraft.wiki: Realms](https://minecraft.wiki/w/Realms)
- Free trial: "One free 30-day trial per account, if the account has not already used one." — [minecraft.wiki: Realms](https://minecraft.wiki/w/Realms)
- Official (snippet): "if you play Minecraft: Java Edition and you want to host a server and play online with your friends, then you'll need to subscribe to Realms for Java Edition"; the Java subscription offers "3 world slots for you and your 10 friends" and "100+ pieces of community created content, such as adventure maps and minigames". Article flagged by the search engine as roughly 1,231 days old (circa mid-2023), so possibly stale. — [help.minecraft.net: What are Minecraft Realms](https://help.minecraft.net/en-us/article/what-are-minecraft-realms)
- Player limit: "A Realm allows up to 10 other players, plus a slot reserved for the owner" (11 concurrent total). Invite list cap is effectively unlimited since 1.9.4 (raised from 200 to "an arbitrarily large, but maybe reachable number"). — [minecraft.wiki: Realms](https://minecraft.wiki/w/Realms)
- World slots: "A Realm has three world slots and the owner can switch between them at any time"; "Only one world is active at a time" (stated explicitly for Bedrock; the Java description implies the same); "A temporary slot is reserved for Minigames. Minigames don't save progress and reset when all players log out." — [minecraft.wiki: Realms](https://minecraft.wiki/w/Realms)
- Idle kick: "Players are kicked after 15 minutes of inactivity." Render distance historically fixed at 12 chunks (wiki marks "verify"); 26.3 added owner-configurable render and simulation distance sliders. — [minecraft.wiki: Realms](https://minecraft.wiki/w/Realms)
- Invite links (new in 26.3): "A Realm can store a maximum of 5" invite links; "Links expire after 7 days by default. The owner can disable them or set an expiry between 30 minutes and 7 days." Players join via a new "Join Realm" screen. — [minecraft.wiki: Realms](https://minecraft.wiki/w/Realms); [minecraft.net: Java Edition 26.3 release notes](https://www.minecraft.net/en-us/article/minecraft-java-edition-26-3)
- Secondary confirmation of price and limits ($7.99/month Java, owner + 10, 30-day trial); one secondary source additionally claims three-month ($19.99) and annual ($79.99) discounts that no other source, including the wiki, corroborates — treat as unverified. — [Windows Central Realms FAQ](https://www.windowscentral.com/gaming/minecraft-realms-faq-how-to-setup-price-and-other-questions-answered); [WiseHosting (host blog)](https://wisehosting.com/blog/is-minecraft-realms-worth-it)
- Bedrock pricing differs (two tiers, $3.99 "you + 2" and $7.99 Realms Plus "you + 10"); this is not the Java product. — [Windows Central Realms FAQ](https://www.windowscentral.com/gaming/minecraft-realms-faq-how-to-setup-price-and-other-questions-answered)

### Inferences
- For 10–20 children playing at once, one Java Realm is too small (10 non-owner seats). Two Realms (~$16/month) cover 20 kids but split them into two isolated worlds with no shared state; the owner account can only be "present" in one of them at a time, and each Realm shows only one world slot live.
- "Several games running at once" maps to "several Realms", not "several slots": switching slots swaps the whole server's world and disconnects players.
- Pre-paid 30/90/180-day packs let a program buy exactly a semester without a renewing card on file.

### Gaps
- Could not read the live minecraft.net/realms/java-edition page or the help-center article (JS-rendered; WebFetch timed out three times), so the exact 2026 wording and any regional price changes are unverified; the wiki figure ($7.99) matches all secondary sources.
- Whether the same Microsoft account can own more than one Java Realm simultaneously was not confirmed by any source found (community lore says yes via separate subscriptions; no official page located).

## Q2. Mods and plugins on Java Realms (official position, 2026 roadmap)

### Takeaway
Java Realms runs Mojang's vanilla server only: no Fabric/Forge/NeoForge mods and no Paper/Spigot plugins can be installed, and nothing in the 26.2/26.3 release notes or the Realms changelog indicates that is changing. Any custom server-side logic must be expressed as data packs (functions, command blocks, predicates, dialogs) inside an uploaded world.

### Cited Findings
- "Mods and plugins cannot be installed." Also: Java Realms worlds "cannot use experimental settings. This covers uploaded worlds and Content Creator maps." — [minecraft.wiki: Realms](https://minecraft.wiki/w/Realms)
- Hosting-company comparison tables list Realms "mods and plugins: Not supported" versus full support on a dedicated server; client-side-only mods (e.g. performance/visual) still work because they don't touch the server. (Secondary, marketing sources.) — [xgamingserver: What are Minecraft Realms vs a dedicated server](https://xgamingserver.com/blog/what-are-minecraft-realms/); [WiseHosting](https://wisehosting.com/blog/is-minecraft-realms-worth-it)
- The 26.3 Realms changes are limited to invite links/codes (max five per Realm), a Join Realm screen, render/simulation distance sliders, a Realms intro screen, and additional server regions (Canada, Mexico, South Africa, Arizona USA "if they become available") — no mod/plugin support appears. — [minecraft.net: Java Edition 26.3](https://www.minecraft.net/en-us/article/minecraft-java-edition-26-3); [minecraft.wiki: Realms](https://minecraft.wiki/w/Realms)
- 26.2 release notes list no Realms feature changes beyond a UI bug fix (MC-301761, Players tab focus). — [minecraft.wiki: Java Edition 26.2](https://minecraft.wiki/w/Java_Edition_26.2)

### Inferences
- The Realms product line for Java is being developed (invite links, sliders, regions in 2026) but strictly within the vanilla server; there is no public roadmap item for plugin/mod hosting.
- The repo's existing approach (pure data packs, `tut`, `oneblock`, `tile`, `npc` namespaces) is the only kind of custom logic a Realm could host; the "tiny Fabric key mod as instructor plumbing" idea from the modding report would be impossible on a Realm (it is client-side anyway, so it would still work for the clients, but nothing server-side).

### Gaps
- No official Mojang help article with the literal sentence "Realms does not support mods" could be read (help.minecraft.net JS shell). The wiki statement and the unanimous secondary sources are the best available evidence.

## Q3. Data packs on Java Realms: workflow, limits, /reload, command blocks, functions, known problems

### Takeaway
Data packs reach a Java Realm only by uploading a whole singleplayer world that already contains them in `<world>/datapacks/`; there is no pack-manager UI, so every pack update means download-backup → edit locally → re-upload, with the Realm offline during the upload. Once in, functions, command blocks and `/reload` are vanilla behaviour (owner/operators can run commands); uploaded worlds have had command blocks enabled by default since snapshot 25w02a. Resource packs can only ride along as the world's embedded `resources.zip`/server pack setting, and experimental features are blocked.

### Cited Findings
- Realms-specific data pack history: 1.13.3 "fixed a bug where Realms deleted zipped datapacks and functions"; "In 25w02a, uploading a world began enabling command blocks by default." — [minecraft.wiki: Realms](https://minecraft.wiki/w/Realms)
- Backups: Java Realms "automatically back up every few hours when players are online"; the owner can restore a backup into the slot or "download a backup as a singleplayer world" (Configure → World Backups → Download Latest). — [minecraft.wiki: Realms](https://minecraft.wiki/w/Realms); [WiseHosting KB (host guide, for export direction)](https://kb.wisehosting.com/how-to-upload-your-minecraft-java-realms-world-to-your-server/)
- The re-upload pain is a long-standing official-forum complaint: "the only way I can update a 4MB pack on a realm is to download a 500MB world"; another commenter describes "download the world, insert the data pack, then upload the world to realms again" with the realm closed during the process. (Feedback forum, user comments; the thread predates 2026 and may be stale, but no newer pack-management feature appears in 26.x notes.) — [feedback.minecraft.net community post 360023754951](https://feedback.minecraft.net/hc/en-us/community/posts/360023754951/comments/360013179971)
- Upload failures: r/realms reports 504 gateway errors on Java Realm uploads; a reply attributes some to "broken/outdated data packs cause the server to try to fix it automatically, resulting in a timeout" — suggested fix is to test without packs, then bisect. (2022; possibly stale.) — [r/realms: Java realms upload problem](https://redlib.hbubli.cc/r/realms/comments/w3ypfi/java_realms_upload_problem)
- A 2026 host blog claims very large, long-running worlds still error out during Realm upload and that Mojang acknowledged it without a fix (anecdotal, secondary). — [space-node (host blog)](https://space-node.net/blog/minecraft-realms-world-upload-fix-2026)
- Hosting guides agree on the vanilla mechanics that also apply on a Realm: pack goes in `<world>/datapacks/`, `pack.mcmeta` at the zip's top level, activate with `/reload` or a restart. — [Purpify docs](https://docs.purpify.host/java/datapacks); [Empower Servers KB](https://help.empowerservers.com/en/article/how-do-i-install-datapacks-8kgkz4/)
- Old bug MC-187259 (closed as duplicate): after a server restart "most data pack features will not work again until /reload is issued" — may not reflect current behaviour but is a known class of Realms data pack complaint. — [bugs.mojang.com MC-187259](https://bugs.mojang.com/browse/MC-187259)
- "Worlds cannot use experimental settings" (uploaded worlds and content-creator maps alike). — [minecraft.wiki: Realms](https://minecraft.wiki/w/Realms)
- The repo's own CLAUDE.md already records (2026-10-08) that "Datapacks reach a Realm only by uploading the whole world from the singleplayer menu, not by copying zips" and that only the owning Microsoft account sees the Configure button. — local project note, `/home/dave/minecraft/CLAUDE.md`

### Inferences
- Iteration speed is the practical killer for this program's workflow (edit `gen_lessons.py` → rebuild zip → `/reload`): on a Realm each change costs a full world download/upload cycle with the Realm closed; with small void worlds like `learn_commands` (tiny region files) the upload itself would be fast, so the pain is the manual Configure → Backups → Download → re-upload dance, not bandwidth.
- Because a world upload replaces the slot, the per-player progress (scoreboards, storage `tut:…`) in the live Realm world is lost unless the latest backup is downloaded first and the packs are swapped inside it.
- Nothing found suggests `/function`, macros, `dialog`, `random`, `return run`, or `allow_op_features` signs behave differently on a Realm than on a vanilla dedicated server of the same version.

### Gaps
- No official Mojang page stating a Java Realm world upload size limit was found; the wiki gives storage limits only for Bedrock (10 GB Plus / 5 GB Core).
- No official page about whether the owner/operators can run `/reload` on a Realm was found (vanilla op permission applies; operators are set from the Realm's Players tab per community guides, but that page could not be read).
- Whether a world-embedded `resources.zip` is honoured by Realms in 26.3 is unknown; locally it did not apply even in singleplayer 26.3 (CLAUDE.md), so assume no.

## Q4. Version support: 26.3 on Realms, update cadence, version pinning

### Takeaway
Java Realms runs the current stable release (26.3 as of 2026-10-18) and is updated by Mojang alongside each release; the owner cannot pin an older version, and Realms worlds cannot use experimental features.

### Cited Findings
- The wiki's Realms page lists 26.3 as the current Java Realms version and says Realms "must always run on" the latest stable version (Maps section); the Limitations section phrases it as "must use the latest stable or development version, unless the latest server is backward-compatible with the client" — the two statements are not fully consistent. — [minecraft.wiki: Realms](https://minecraft.wiki/w/Realms)
- All curated Realms maps "are ensured to be compatible with the latest stable version." — [minecraft.wiki: Realms](https://minecraft.wiki/w/Realms)
- 26.3 "Wilderness Bound" released 2026-09-15, data pack format 121.0 (resource pack 97.1). — [minecraft.wiki: Java Edition 26.3](https://minecraft.wiki/w/Java_Edition_26.3); [GamingOnLinux](https://www.gamingonlinux.com/2026/09/minecraft-java-edition-26-3-wilderness-bound-update-released/)
- 26.2 "Chaos Cubed" released 2026-06-16, data pack format 107.1. — [minecraft.wiki: Java Edition 26.2](https://minecraft.wiki/w/Java_Edition_26.2)
- Current dev line: 26.4 snapshot 4 ("Dev 26.4-snap-4") listed in the wiki navigation on 2026-10-18. — [minecraft.wiki: Realms (nav)](https://minecraft.wiki/w/Realms)
- Realms 26.3 feature work landed in the 26.3 snapshots 7–10 (regions, invite links/Join Realm, render/simulation sliders, intro screen), showing the Realms client ships in lockstep with the game. — [minecraft.wiki: Realms](https://minecraft.wiki/w/Realms)
- Host-migration guides note "Realms always runs the latest release of Minecraft" (secondary). — [Falix: Minecraft Realms migration](https://client.falixnodes.net/guides/game-servers/minecraft-realms-migration)

### Inferences
- A `max_format: 121` pack works on a Realm today; when 26.4 releases (roughly quarterly cadence: 26.2 June, 26.3 September), the Realm will move to 26.4 within days and every child's client must update too. A pack with a `max_format` below the new format would trigger the "made for an older version" warning and may break (the 26.3 format jump already broke things once per the repo's notes).
- No version pinning means the program cannot freeze on 26.3 for a term the way a self-hosted server (or Prism instance) can.

### Gaps
- Exact lag between a Java release and Realms availability on release day was not documented by any source found; wiki wording implies same-day.
- Whether Java Realms offers an opt-in snapshot/pre-release Realm in 2026 (it has historically for some snapshots) was not confirmed.

## Q5. Accounts and children: what each child needs, Family Safety / child-account blocks, chat reporting, adult-managed Realms

### Takeaway
Each child needs their own Microsoft account with a Java Edition license; if that account is a child account (under 16 in the US/EU) multiplayer and Realms are blocked by default and only the family organiser can allow them via the Xbox privacy/online-safety settings ("You can join multiplayer games", "You can create and join clubs", "You can play with people outside of Xbox Live", plus communication settings). An adult can own the Realm and invite the children, but each child still needs those permissions on their own account, and the official "error when trying to play Realms with a child account" article exists specifically because this blocks kids so often.

### Cited Findings
- Who counts as a child: "child accounts are all accounts for those under the age of 16 for the US & EU, and 19 for South Korea." "Only the parent account can edit them, and if there isn't an adult account associated with the child account, the adult must make a Microsoft account and associate the already-created child account with it." (snippet) — [help.minecraft.net: Parental Controls in Minecraft](https://help.minecraft.net/en-us/article/parental-controls)
- Settings to flip (snippet): under the Xbox account's Online Safety tab, "select Allow for 'You can create and join clubs', and/or 'You can join multiplayer games'"; under Privacy, "Others can communicate with voice, text, or invites" (Everyone / Friends / Block); a separate Online Safety setting controls adding/removing friends. — [help.minecraft.net: Parental Controls in Minecraft](https://help.minecraft.net/en-us/article/parental-controls)
- A dedicated official article exists: "I'm Getting an Error When Trying to Play Realms with a Child Account" (located; content not readable from this environment). — [help.minecraft.net article 360042221252](https://help.minecraft.net/hc/en-us/articles/360042221252-I-m-Getting-an-Error-When-Trying-to-Play-Realms-with-a-Child-Account)
- Xbox's official page for this exact problem is "Manage a member's safety settings to access Minecraft features" (located; page body is JS-rendered and returned empty). — [support.xbox.com](https://support.xbox.com/en-GB/help/family-online-safety/online-safety/manage-a-members-safety-settings-to-access-minecraft-features)
- Family-group mechanics (official): "your family group's organiser can update your privacy settings for you"; at age of majority (18 in the US) a member can leave the family group or be promoted to organiser. — [support.xbox.com: Why can't I change my privacy settings?](https://support.xbox.com/en-AU/help/family-online-safety/online-safety/manage-app-privacy-settings-xbox-one)
- Java-specific symptom: Microsoft Q&A thread "Minecraft Java Edition - Multiplayer Option disabled" runs to 30+ pages of parents whose children see the Multiplayer/Realms buttons greyed out with "You need to change your Microsoft account settings"; a moderator notes settings must be explicitly submitted/saved, and users report needing a launcher sign-out/sign-in afterwards. — [learn.microsoft.com Q&A 4220013](https://learn.microsoft.com/en-us/answers/questions/4220013/minecraft-java-edition-multiplayer-option-disabled?page=5); [learn.microsoft.com Q&A 5664928 (family realm)](https://learn.microsoft.com/en-us/answers/questions/5664928/need-help-allowing-my-child-to-join-the-family-rea)
- Community fix guides: Java multiplayer needs "You can play with people outside of Xbox Live" and "You can join multiplayer games" allowed, then log out of the launcher and restart; Realms additionally needs the clubs permission; some parents resort to leaving the family group / changing the age to 18+. (Secondary, unofficial.) — [minecraft.how: multiplayer disabled Microsoft settings](https://minecraft.how/blog/post/minecraft-multiplayer-disabled-microsoft-settings); [Gardion parental-controls guide](https://gardion.io/blog/parental-controls-minecraft/)
- Realm ownership: the owner-only Configure button (confirmed locally 2026-10-08) means the adult account that pays is the only one that can upload worlds, switch slots, manage players, and download backups. — local project note, `/home/dave/minecraft/CLAUDE.md`
- Friends/online features in 26.2+ link out to Microsoft account safety settings and honour Xbox profile chat settings ("Friends Only" chat means other players see your messages only if you're friends), i.e. the same child-account gates apply to the new Friends List. — [minecraft.wiki: Java Edition 26.2 Snapshot 7](https://minecraft.wiki/w/Java_Edition_26.2_Snapshot_7)

### Inferences
- Administrative load scales with the number of children: every family must (a) have a Microsoft family group, (b) flip 2–4 Xbox privacy toggles on the child's account, (c) save/submit, and (d) re-login the launcher. A program-owned set of adult accounts (as in the repo's "instructor owns accounts" kids' track) sidesteps this but each still needs a paid Java license and raises its own account-policy questions (Microsoft accounts for under-13s are supposed to be child accounts).
- Chat reporting: Java has had player chat reporting since 1.19.1 and Realms chat is signed/reportable like any online server; I could not pull a 2026 source for this in the budget, so treat as background knowledge (see Gaps).

### Gaps
- The two official articles that matter most (help.minecraft.net 360042221252 and the Xbox "Minecraft features" safety page) could not be read; the exact current toggle names and any 2026 age-threshold changes are therefore from snippets of the (older) Parental Controls article and community reports.
- No official source found on whether a child account can *own* a Java Realm (purchase requires a payment method, which a child account normally lacks; "ask a parent" purchase approval exists in Family Safety, but Realms ownership specifically is undocumented here).
- Chat-reporting specifics on Realms in 26.3 not sourced.
- Whether Microsoft Family Safety's screen-time/app limits affect the Java launcher on Linux/macOS was not researched.

## Q6. The 26.2 vanilla "Online" (peer-to-peer) world sharing: what it is, limits, status, classroom relevance

### Takeaway
The "Online" option (host a singleplayer world and invite Friends-List friends over a peer-to-peer connection) shipped only in 26.2 Snapshots 7–8; Mojang pulled it in 26.2 Pre-Release 1 (2026-05-26) because it "did not meet the quality bar", the final 26.2 and 26.3 releases contain only the Friends List and the renamed Open to LAN screen (Off/Local), and as of 2026-10-18 it has not returned (26.4 snapshots only restyle the Friends List). It is therefore not usable today, and even when it returns its design (host must be in the world, friends-only, no server process) makes it a one-world, one-host feature rather than a classroom host.

### Cited Findings
- Introduced: "26.2 Snapshot 7: P2P was added, letting players open worlds to online play and invite friends." Snapshot 7 was released 2026-05-12. The Multiplayer Options screen (replacing Open to LAN) had three scopes: "Off (default): Nobody can join the world. Local: Only players on the local network can join, as Open to LAN worked previously. Online: Friends can be invited to join from anywhere." Hosts send "Invite to world"; friends in "All" presence can "Request to join world". — [minecraft.wiki: Java Edition 26.2 Snapshot 7](https://minecraft.wiki/w/Java_Edition_26.2_Snapshot_7); [minecraft.net: 26.2 Snapshot 7](https://www.minecraft.net/en-us/article/minecraft-26-2-snapshot-7); [feedback.minecraft.net: 26.2 Snapshot 7](https://feedback.minecraft.net/hc/en-us/articles/45790287863437-Minecraft-Java-Edition-26-2-Snapshot-7)
- Connection model: opt-in telemetry event `p2p_connection` records failure stages `SIGNALING`, `ICE_CONNECT`, `TIMEOUT` and path types `LOCAL`, `DIRECT`, `RELAY`, `UNKNOWN` — i.e. WebRTC-style NAT traversal with a relay fallback, no dedicated server. — [minecraft.wiki: Java Edition 26.2 Snapshot 7](https://minecraft.wiki/w/Java_Edition_26.2_Snapshot_7)
- Removed: "26.2-pre1: Players could no longer open worlds for P2P play. 26.2 (full release): The feature was removed… 'no longer functions in versions which did have it' and 'is planned to be reintroduced at a later date.'" — [minecraft.wiki: Online (P2P)](https://minecraft.wiki/w/Online)
- Pre-Release 1 (2026-05-26) removed "the ability to open singleplayer worlds to online multiplayer… along with displaying invites for or requesting to join online worlds"; Mojang's stated reason: the feature "did not meet the quality bar for all players"; the Friends List stayed. Pre-Release 4 renamed "Multiplayer Options" back to "Open to LAN". — [minecraft.wiki: Java Edition 26.2 Pre-Release 1](https://minecraft.wiki/w/Java_Edition_26.2_Pre-Release_1); [minecraft.wiki: Multiplayer (history)](https://minecraft.wiki/w/Multiplayer); [Beebom](https://beebom.com/minecraft-removes-peer-to-peer-multiplayer-support-in-26-2-pre-release-1-build/); [allthings.how](https://allthings.how/minecraft-26-2-pre-release-1-pulls-peer-to-peer-multiplayer-before-chaos-cubed-launch/)
- Final 26.2 (2026-06-16) documents only Off and Local scopes ("Replaced the Open to LAN screen with the new Multiplayer Options screen"), the Friends List, an "Allow Requests" toggle, and the `p2p_connection` telemetry event; no "Online" scope. — [minecraft.wiki: Java Edition 26.2](https://minecraft.wiki/w/Java_Edition_26.2)
- 26.3 (2026-09-15) release page: no mention of online/P2P world sharing in the readable portion. — [minecraft.wiki: Java Edition 26.3](https://minecraft.wiki/w/Java_Edition_26.3)
- 26.4 development: the Friends List page says the content "has appeared in development versions for 26.4" and "26.4 snap3… updated the design of the friends list"; no source found showing P2P hosting back in any 26.4 snapshot. — [minecraft.wiki: Friends List](https://minecraft.wiki/w/Friends_List)
- Snapshot-era limitations noted by observers: "if the host logs out, everyone get kicked"; "only works with Java Edition friends. No cross-play with Bedrock." (Secondary, describing the snapshot build.) — [WiseHosting: play with friends Java 2026](https://wisehosting.com/blog/how-to-play-minecraft-with-friends-java-edition); [GamingOnLinux, May 2026](https://www.gamingonlinux.com/2026/05/minecraft-java-finally-gets-a-friends-list-and-peer-to-peer-multiplayer/)
- Friends List mechanics that survive in release: Friends button on title/pause screen (O key), requests by profile name, presence states "Offline / Online / In a world / In a joinable world", first-use opt-in dialog, Online Options → Friends List with "Allow Requests", "In-game Notification", and Presence "All / Limited / None". — [minecraft.wiki: Java Edition 26.2 Snapshot 7](https://minecraft.wiki/w/Java_Edition_26.2_Snapshot_7)

### Inferences
- For a classroom: even in its snapshot form the feature was friends-only (each child would have to friend the host account, subject to child-account friend/communication permissions), hosted on one kid's or the teacher's client (world dies when that client closes, performance bound to that laptop), single world per host, and with no player cap documented. It solves "play together without an IP" for a family, not "run four game worlds for twenty kids".
- Within a single room, the existing "Local" (Open to LAN) scope already does everything the Online scope would, with no accounts gate beyond the normal login — relevant if the program meets in person.

### Gaps
- No official statement of a player limit for P2P worlds (the snapshot notes give none).
- No official date or 26.4 target for reintroduction; only the wiki's "planned to be reintroduced at a later date".
- Whether P2P worlds would allow data packs was never documented; since the host is a singleplayer world, the world's own `datapacks/` folder would presumably load as usual, but no source states it.

## Q7. Realms Plus / Bedrock Realms confusion points

### Takeaway
"Realms Plus", the $3.99 two-friend tier, Marketplace packs, the Realm Hub, Administrator role, Timeline, Saves UI and the 2026 Bedrock invite screen are all Bedrock-only; a teacher reading Realms news in 2026 should assume any feature not explicitly labelled Java Edition does not apply to the Java product the program would use.

### Cited Findings
- Bedrock tiers: $3.99/month (you + 2) and $7.99/month Realms Plus (you + 10, Marketplace content); Java has a single $7.99 plan. — [Windows Central Realms FAQ](https://www.windowscentral.com/gaming/minecraft-realms-faq-how-to-setup-price-and-other-questions-answered); [minecraft.wiki: Realms](https://minecraft.wiki/w/Realms)
- Bedrock-only 2025–2026 Realms changes listed on the wiki: Timeline opt-in requirement (2025-05-16), Administrator role (2026-03-06), Realm Hub interface (2026-03-13), Saves UI/settings changes (2026-07-31 / 2026-08-01), new invite screen (2026-09-11); manual saves and storage limits (10 GB Plus / 5 GB Core) are Bedrock-only. — [minecraft.wiki: Realms](https://minecraft.wiki/w/Realms)
- Bedrock Realms accept Marketplace add-ons/packs; Java Realms accept none of that content and vice-versa (no cross-play between editions' Realms). — [exitlag (secondary)](https://www.exitlag.com/blog/minecraft-bedrock-edition-features-platforms-play/); [minecraft.wiki: Realms](https://minecraft.wiki/w/Realms)

### Inferences
- Any "add-ons on Realms" guide a parent or co-teacher finds is almost certainly Bedrock; the Java data-pack path (Q3) is the only equivalent.

### Gaps
- None material for the Java decision.

## Bottom line for the report writer (synthesis of Q1–Q6)

- Viable for: one adult-owned Realm, one world at a time, up to 10 kids online, pure data-pack games on the current stable version, with the adult doing a download/edit/upload cycle for every pack change and every family having fixed their child's Xbox privacy settings.
- Not viable for: several games live simultaneously (one active slot per Realm), 11–20 concurrent kids on one world (hard cap 10 + owner), any Fabric/Paper logic, version pinning, fast iteration on packs, or avoiding per-child Microsoft family-settings work.
- The 26.2 "Online" P2P feature is currently absent from the shipped game (pulled 2026-05-26, not back as of 2026-10-18) and, by design, is a one-host-one-world friends feature, so it does not change the picture.
