# Other managed Minecraft hosts as comparison baselines (Apex, Shockbyte, BisectHosting, Nodecraft, exaroton, Aternos, Kinetic, Sparked)

Scope: Minecraft Java 26.3 Fabric servers for a US kids' program that needs several servers at once; state as of 2026-10-18. Prices are USD list prices from each host's own order page where that page could be read (Apex, Shockbyte, Kinetic, Nodecraft build-your-own, exaroton), otherwise from iTechGuides' directory (prices "checked Oct 2026", pages "last updated 7–13 Oct 2026") or a dated competitor comparison. Several primary pages (Apex pricing, Shockbyte, exaroton/Aternos help centres, Trustpilot) block automated fetching; where I got through, the fetch date is 2026-10-18.

## Summary table (4 GB / 8 GB monthly, USD, recurring)

| Host | 4 GB | 8 GB | Pricing basis | Panel | US regions | Fabric / custom jar + datapack upload | 2nd concurrent server | Backups | DDoS | Uptime claim | Refund | Source |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| Apex Hosting | $14.99 ($11.24 first month) | $27.99 ($20.99 first month) | per RAM tier; custom from $1.88; quarterly −10% | Multicraft-based | New York, Dallas, San José, Miami, Portland, Vint Hill VA | "All Mod & Plugin Support", FTP + MySQL | separate order per server; no shared-plan option found | automatic (one auto backup kept, per iTechGuides) | yes (300 Gbps per iTechGuides) | 99.99% SLA (iTechGuides) | 7 days | [Apex pricing](https://apexminecrafthosting.com/pricing/), [Apex specs](https://apexminecrafthosting.com/server-specs/) |
| Shockbyte (Premium) | $15.99 list, $11.19 with 30% recurring promo | $31.99 list, $22.39 promo | per RAM tier (1 GB $3.99 … 12 GB $47.99); quarterly −10%, annual −50% | new Shockbyte Control Panel (Multicraft legacy KB still linked) | OVH Virginia + Oregon (undated case study); 16 locations total | one-click Forge/Vanilla/Paper etc.; file manager; mods via panel | separate server; "instances" = up to 3 stored setups per server, one live | automated, retention unstated | yes | 99.9% | 72 h self-serve | [Shockbyte MC page](https://shockbyte.com/games/minecraft-server-hosting) |
| Shockbyte (Budget) | ≈$7.99–$9.99 (1 GB $1.99 … 8 GB $15.99, June 2026) | $15.99 | per RAM | same | fewer | same | same | | | | | [WinterNode comparison](https://winternode.com/blog/minecraft/winternode-vs-shockbyte) |
| BisectHosting (BisectOne) | $11.99 | $23.99 | $2.99–3/GB flat; 2 GB $5.99; quarterly −10%, semi −15%, annual −20% | Starbase (custom) | 21 locations, US list not published | "Full Mod Support", manual modpack installs, Pro File Manager + full FTP | 2 instance slots (40 GB pool) = swap, not concurrent; BisectBoost add-on +2 slots | 2 backup slots, daily, 3 days kept | yes | 99.97% target (iTechGuides) | 3 days, first-time customers | [Bisect MC page](https://www.bisecthosting.com/minecraft-server-hosting), [iTechGuides](https://www.itechguides.com/best/minecraft-server-hosting/compare/bisecthosting-vs-nodecraft/) |
| Nodecraft Lite (hibernates) | $11.92–$13.98 (sources conflict) | $23.84–$27.98 | $2.98/GB; promo "$6.99 first month then $9.98" headline | NodePanel (in-house) | Seattle, San Jose, Denver, Dallas, Houston, Chicago, Atlanta, Miami, Washington DC, Boston (+Toronto, Querétaro) | one-click modpacks/plugins; file manager + FTP/SFTP | instances = save slots; one deployed per plan ("bot"); second plan needed | cloud; auto on hibernation | yes | – | 24 h free trial + 7-day money back | [Nodecraft BYO](https://nodecraft.com/pricing/build-your-own), [Lite vs Pro](https://nodecraft.com/support/knowledgebase/nodecraft-lite-servers/nodecraft-pro-vs-nodecraft-lite-whats-the-difference) |
| Nodecraft Pro (24/7, static IP) | $19.98 | $39.98 | ~$5/GB | same | same | same | same | weekly auto + custom | yes | – | same | [WebSearch summary of nodecraft game pages](https://nodecraft.com/games/valheim-server-hosting) |
| exaroton | 4 credits/h = €0.04/h (≈$0.04–0.05/h) | 8 credits/h = €0.08/h | 1 credit (€0.01) per GB per hour, prorated to 0.01 credit; 2–16 GB; storage 10 credits/month/server, waived if ≥10 credits used | custom panel | "North America" region (no city choice) | Fabric in panel + custom Fabric upload; file manager uploads ≤3 GB; no FTP | unlimited-ish: each server bills separately; credit pools fund many servers | free to Google Drive / OneDrive / Dropbox | yes | – | 14-day refund of unused credits | [exaroton Pricing](https://support.exaroton.com/hc/en-us/articles/360019687657-Pricing), [Region](https://support.exaroton.com/hc/en-us/articles/21659706549789-Server-region) |
| Aternos | free | free | free, no payment possible | custom | not selectable | Fabric offered; mods only from its CurseForge/Modrinth library; datapacks uploadable; no custom jars, no FTP | multiple servers per account possible but each queues/sleeps | Google Drive | yes | none; queue | n/a | [Aternos upload policy](https://support.aternos.org/hc/en-us/articles/360027235831-Uploading-files-and-FTP-access) |
| Kinetic Hosting (Pterodactyl-derived panel) | $4.99 | $7.99 | per RAM tier (≈$1/GB); 60 GB storage | Kinetic Panel | Texas, Washington DC, Florida, San Francisco | Forge + Fabric; "all modpacks, plugins, mods, and datapacks"; file manager | **4 "splits" on 8 GB+: carve unused RAM into extra servers at no extra cost** | 5 backup slots (8/12 GB) | yes | – | 7 days any reason / 14 if fault | [Kinetic MC order page](https://www.kinetichosting.com/game-servers/minecraft/order) |
| Sparked Host | ≈$4 (Budget $1/GB) / ≈$10.36 (Enterprise $2.59/GB) | ≈$8 / ≈$20.72 | per GB, three hardware lines | Apollo Panel (own; has "Server Splitter Tool") | 10 locations, US list not retrieved | one-click + custom modpacks | server splitter (details not retrieved) | automatic | yes | – | 24 h, faults only | [iTechGuides Apex vs Sparked](https://www.itechguides.com/best/minecraft-server-hosting/compare/apex-hosting-vs-sparked-host/), [Sparked home](https://sparkedhost.com/) |

## Key question 1: Per-host plans, prices, regions, panels, Fabric/upload, multi-server, backups, DDoS, uptime, support

### Takeaway
The big four US brands cluster at $3–5/GB/month for always-on servers (Apex $14.99/4 GB, Shockbyte $15.99 list, Bisect $11.99, Nodecraft Pro $19.98), all sell one server per subscription with "instances" that only swap, not run concurrently; the Pterodactyl-style budget tier (Kinetic $4.99/4 GB with resource "splits", Sparked $1–2.59/GB) is 3–4x cheaper and Kinetic is the only one that explicitly lets one plan run several servers at once.

### Cited Findings

**Apex Hosting**
- Order page (read 2026-10-18): 4 GB $11.24 first month then $14.99/month; 6 GB $16.87 then $22.49; 8 GB $20.99 then $27.99; "Custom … Starting at $1.88"; EX-Series 16 GB (4 dedicated vCores, dedicated IP) $53.99 then $71.99; quarterly billing −10%; banner "25% off on first order with APEX25"; features listed: Java & Bedrock, free server transfer, 24/7 FTP & MySQL access, 7-day money-back guarantee, "All Mod & Plugin Support", 24/7 support; footer links "Education Scholarship" and © 2013-2026 Apex Hosting LLC — [Apex Packages and Pricing](https://apexminecrafthosting.com/pricing/)
- North American locations on the current hardware table: New York NY (Ryzen 9 7950X), Dallas TX, San José CA, Miami FL, Portland OR, Vint Hill VA — [Apex server specs](https://apexminecrafthosting.com/server-specs/)
- iTechGuides fact sheet: Multicraft-based panel with built-in video guides, 14 locations, 24/7 live chat, 99.99% SLA, DDoS mitigation rated to 300 Gbps, 7-day refund from server creation, "the panel keeps only one automatic backup at a time", prices checked Oct 2026 — [iTechGuides Apex vs Sparked](https://www.itechguides.com/best/minecraft-server-hosting/compare/apex-hosting-vs-sparked-host/); [iTechGuides Apex page](https://www.itechguides.com/best/minecraft-server-hosting/apex-hosting/)
- Apex's ToS mentions the Multicraft panel ("instant database creation from our Multicraft") and an "Unfair usage" clause against bypassing RAM limits; I found no age clause in the text — [Apex ToS](https://apexminecrafthosting.com/terms-of-service/)
- Reviewer note: Apex's billing system and control panel are separate logins per server — [WiseHosting Apex review (competitor)](https://wisehosting.com/blog/apex-hosting-review)
- Pricing-aggregator cross-check: 6 GB renews $22.49, 8 GB $27.99, 16 GB $51.99, 20 GB $64.99, first month discounted — [WHTOP Apex 8 GB](https://www.whtop.com/plans/apexminecrafthosting.com/139102)

**Shockbyte**
- Order page (read 2026-10-18), Premium line, "30% OFF RECURRING" promo shown on every tier: Dirt 1 GB $3.99→$2.79; Sand 2 GB $7.99→$5.59; Cobblestone 3 GB $11.99→$8.39 ("Most Popular"); Iron 4 GB $15.99→$11.19; Gold 5 GB $19.99→$13.99; Redstone 6 GB $23.99→$16.79; Diamond 7 GB $27.99→$19.59; Emerald 8 GB $31.99→$22.39 ("Mods & Plugins"); Obsidian 9 GB $35.99; Spartan 10 GB $39.99; Zeus 12 GB $47.99; Custom 17 GB+ from $67.83; billing toggles "Quarterly −10% OFF, Annually −50% Off"; badges: 72hr Self-Serve Refund, 99.9% Uptime, 24/7 Support, DDoS Protection; one-click Paper/CraftBukkit/Forge/Vanilla and CurseForge/FTB/Technic/ATLauncher modpacks; "We're rated 4.7 out of 5 stars"; new panel features "Modpack Installer, Server Instances, Config Manager, Backups"; a separate "budget Minecraft server hosting plans" line is linked; footer still lists a "Multicraft Knowledgebase" next to the "Shockbyte Control Panel"; company is Shockbyte PTY LTD (Australia) — [Shockbyte Minecraft hosting](https://shockbyte.com/games/minecraft-server-hosting)
- Budget line: $1.99/month (1 GB) to $15.99/month (8 GB) on "cost-effective hardware" with no published specs, captured 2026-06-20; Premium ≈$4.00/GB captured 2026-09-21; Trustpilot 4.1 stars across 10,306 reviews (77% five-star, 13% one-star) as of 2026-10-05; negative reviews "often mention slow ticket responses" — [WinterNode vs Shockbyte (competitor-authored, updated 2026-10-05)](https://winternode.com/blog/minecraft/winternode-vs-shockbyte)
- Instances: "Each instance stores a separate set of server files, allowing server owners to keep up to three different server setups … switch between instances by hitting the 'Switch' button which takes a few minutes" (one live at a time) — [Shockbyte KB: instances (2024-09-11)](https://shockbyte.com/help/knowledgebase/articles/how-to-create-and-switch-instances-on-your-server-panel)
- Shockbyte runs on OVHcloud data centres incl. Virginia and Oregon in the US (undated case study) — [OVHcloud case study](https://www.ovhcloud.com/es/case-studies/shockbyte/); iTechGuides lists 16 locations and a 72-hour self-serve refund — [iTechGuides Shockbyte](https://www.itechguides.com/best/minecraft-server-hosting/shockbyte/)
- ToS: "you must be at least 13 years of age. If you are 13 or older but under 18 years of age, you must have your parent or legal guardian's permission" — [Shockbyte ToS](https://shockbyte.com/terms-of-service)

**BisectHosting**
- BisectOne (one plan for 100+ games, per-GB): includes DDoS protection, NVMe, unlimited disk, free MySQL, free subdomains, manual modpack installs, 24/7/365 support, Starbase Games Panel, Game Swapping, 2,300+ modpacks, Instance Manager with 2 instance slots (40 GB shared pool), 2 backup slots (40 GB pool), automated daily backups with 3 days of history, Pro File Manager, Full FTP Access; BisectBoost add-on adds +2 instance slots, +2 backup slots, 4 daily backup slots, temporary RAM boosting; billing discounts quarterly 10%, semi-annual 15%, annual 20% (prices themselves render only in JS) — [Bisect Minecraft page](https://www.bisecthosting.com/minecraft-server-hosting); [BisectOne announcement](https://www.bisecthosting.com/blog/bisectone-game-server-hosting-plan-price-features-addons-announcement)
- Prices: 4 GB $11.99/month, 6 GB $17.99, 8 GB $23.99, 10 GB $29.99, custom 4–48 GB, $2.99–$3/GB; entry 2 GB $5.99; 21 locations switchable free; live chat around the clock; 3-day money-back for first-time customers only; "written 99.97% uptime target"; Trustpilot not on page — [iTechGuides Bisect vs Nodecraft](https://www.itechguides.com/best/minecraft-server-hosting/compare/bisecthosting-vs-nodecraft/); [iTechGuides Bisect page](https://www.itechguides.com/best/minecraft-server-hosting/bisecthosting/); [iTechGuides MC directory](https://www.itechguides.com/best/minecraft-server-hosting/)
- Trustpilot 4.8/5 from ~25,900 reviews — [Trustpilot BisectHosting (UK mirror)](https://uk.trustpilot.com/review/bisecthosting.com?page=2)
- Instance Manager lets you "create multiple instances of your server and its settings" and switch between them; nothing on the page says two run at once; no Velocity/proxy mention found — [Bisect Minecraft page](https://www.bisecthosting.com/minecraft-server-hosting)

**Nodecraft**
- Build-your-own page (read 2026-10-18): headline "$6.99 first month then $9.98 per month"; 3-month −10%, yearly −20%; features: Ryzen 9/EPYC, no overselling, integrated file manager, web & FTP/SFTP access, one-click mods/plugins, "Save & Swap games as much as you want", DDoS protection, "4.9/5 with 1800+ reviews"; North America ping list: Seattle, San Jose, Denver, Querétaro, Dallas, Houston, Chicago, Atlanta, Miami, Toronto, Washington D.C., Boston; FAQ: 24-hour trial without a card or 3-day trial with card; Pro servers online 24/7, Lite servers "hibernate automatically when unused"; instances are "like save slots"; "Nodecraft does not limit player slots"; payment: cards, Apple Pay, Google Pay, PayPal — [Nodecraft build-your-own](https://nodecraft.com/pricing/build-your-own)
- Lite vs Pro (updated 2026-07-14): Lite shuts down when not in use (Wake & Play), same hardware and panel as Pro, backups created on hibernation, no custom backups, no automated tasks, no static IP (static DNS hostname instead), Wake & Play share link so friends can wake it; Pro is online 24/7, weekly adjustable auto backups, custom backups, automated tasks, static dedicated IP; both have FTP — [Nodecraft KB Lite vs Pro](https://nodecraft.com/support/knowledgebase/nodecraft-lite-servers/nodecraft-pro-vs-nodecraft-lite-whats-the-difference)
- Prices: Lite 4 GB $11.92, 8 GB $23.84, 10 GB $29.80; Pro 4 GB $19.98; $2.98/GB; 27 locations; 7-day money-back after trial — [iTechGuides Bisect vs Nodecraft](https://www.itechguides.com/best/minecraft-server-hosting/compare/bisecthosting-vs-nodecraft/). Conflicting: a Nodecraft game page lists Lite 4 GB at $13.98 regular, Lite 8 GB $27.98, Pro 8 GB $39.98 regular — [Nodecraft Valheim page](https://nodecraft.com/games/valheim-server-hosting), [Nodecraft ATLauncher page](https://nodecraft.com/games/minecraft-server-hosting/modpacks/atlauncher)
- Support hours: "7:30 AM to 4:00 PM" (competitor review, 2026-09-02) — [WiseHosting Nodecraft review](https://wisehosting.com/blog/nodecraft-review); "daytime-only human support" — [iTechGuides MC directory](https://www.itechguides.com/best/minecraft-server-hosting/)

**Kinetic Hosting (Pterodactyl-derived "Kinetic Panel")**
- Order page (read 2026-10-18): "All performance package prices in USD": 4 GB $4.99, 8 GB $7.99, 10 GB $9.99, 12 GB $12.99, 14 GB $14.00, 16 GB $15.99, 21 GB $20.99, 26 GB $25.99, 32 GB $31.99, 42 GB $41.99, 64 GB $61.99, 124 GB $123.99; 8 GB plan: NVMe, up to Ryzen 9 9950X 5.7 GHz, 6 CPU threads, "24/7 human support", "No player caps", "5 backup slots", "4 splits"; "Split Your Server: Allocate unused resources to additional servers at no extra cost"; "We support all modpacks, plugins, mods, and datapacks"; "Toggle … Java version"; 60 GB storage by default with free upgrades; US locations: Texas, Washington DC, Florida, San Francisco (plus Beauharnois CA, São Paulo, Sydney, Mumbai, Singapore); swap location anytime; MySQL, firewall manager, reverse proxy + custom subdomain for map plugins; refund 7 days any reason, 14 days if fault; blog posts dated 6 and 8 Oct 2026 — [Kinetic Minecraft order page](https://www.kinetichosting.com/game-servers/minecraft/order); [Kinetic Minecraft page](https://www.kinetichosting.com/game-servers/minecraft)
- Kinetic's about page says the company began by "tweaking the open-source panel, Pterodactyl" — [Kinetic about (via search)](https://www.kinetichosting.com/about)

**Sparked Host**
- iTechGuides: Budget $1/GB (older dual-Xeon, 6 of 10 locations), Enterprise $2.59/GB (from $5.18 for 2 GB), Extreme on Ryzen 9 9900X; own "Apollo Panel"; refunds only within 24 hours and only for unresolved faults; Game Vault swapping; Geyser manual or $5 staff add-on — [iTechGuides Apex vs Sparked](https://www.itechguides.com/best/minecraft-server-hosting/compare/apex-hosting-vs-sparked-host/)
- Home page lists Apollo Panel features: console, file manager, one-click modpack/plugin installers, "Secure Reverse Proxy", "Server Importer Tool", "Server Splitter Tool", 24/7 support — [Sparked Host home](https://sparkedhost.com/)
- Undated forum posts by Sparked staff reference Pterodactyl for Budget/Premium plans and Multicraft for a "Regular" tier — [BuiltByBit thread](https://builtbybit.com/threads/finding-the-minecraft-hosting-vps-hosting.396305/post-3334899)

**Cross-host**
- iTechGuides discloses "vendors can pay for top positions" and says no standardized performance tests exist; its MC directory (Oct 2026): Bisect 9.3, Apex 9.1, Shockbyte 9.1, Nodecraft 8.8, Sparked 8.6, Aternos 7.8 editor scores — [iTechGuides MC directory](https://www.itechguides.com/best/minecraft-server-hosting/)
- Fabric supports 26.3 (Loader 0.19.5 at release), Java 25 required; Paper/NeoForge 26.3 still beta and Geyser not yet on 26.3 as of 2026-10-01; new 26.3 servers start with whitelist on — [TroubleChute 26.3 Fabric server](https://hub.tcno.co/games/minecraft/26.3/server/fabric/); [Space-Node 26.3 guide](https://space-node.net/blog/minecraft-26-3-server-update-guide-2026)

### Inferences
- Per-GB always-on cost ranking (4 GB, list price): Kinetic $1.25/GB < Sparked Budget $1 (old hardware) < Nodecraft Lite $2.98 ≈ Bisect $3.00 < Apex $3.75 < Shockbyte $4.00 ($2.80 with the standing 30% promo) < Nodecraft Pro $5.00.
- Three concurrent 4 GB always-on servers would run roughly: Kinetic $15 (or one 12 GB plan at $12.99 with splits), Bisect $36, Apex $45, Shockbyte $48 list / $34 promo, Nodecraft Pro $60. None of the big four discounts a second server; each is a separate subscription.
- "Instances" at Shockbyte, Bisect and Nodecraft solve "multiple worlds" (swap a class's world set) but not "multiple servers at the same time"; for a class where groups play simultaneously they are irrelevant.
- Fabric 26.3 on these hosts is almost certainly a custom-jar install for now (Fabric isn't in Shockbyte's or Apex's one-click lists I could read; Kinetic and Aternos name Fabric). With Java 25 required, hosts that expose a Java-version switch (Kinetic explicitly; Pterodactyl panels generally) are lower risk than Multicraft-based Apex.

### Gaps
- Could not load Apex's Trustpilot score, its "Education Scholarship" page (404 at the guessed URL), any Apex multi-server or proxy KB article, or an Apex age clause.
- Bisect's own price table and US city list render only in JavaScript; the 4/8 GB prices come from iTechGuides (flat per-GB so they should match).
- Nodecraft's Minecraft-specific Lite/Pro 4 GB and 8 GB prices conflict between sources ($11.92 vs $13.98; $23.84 vs $27.98) and the site itself redirects to a JS-only pricing page.
- Trustpilot blocked all fetches; Nodecraft's 4.9 and Shockbyte's 4.7 are self-reported on their own pages (Shockbyte's conflicts with the 4.1/10,306 WinterNode cited on 2026-10-05).
- No host publishes whether 26.3 Fabric is in its one-click list yet; no r/admincraft 2026 threads surfaced in search.
- Sparked Host's own pricing page 404'd; only iTechGuides/forum figures.

## Key question 2: exaroton (pay-per-use) for a 2–3 h/week class

### Takeaway
exaroton bills 1 credit (€0.01) per GB-hour prorated to the hundredth, so a 4 GB server used 3 h/week costs about €0.50/month and several servers can run at once and be funded from one shared credit pool; it offers a North America region, Fabric (panel and custom upload), datapack/mod uploads via the web file manager, and built-in Velocity/BungeeCord proxies, with the 10 GB per-server storage cap and no-FTP the main limits.

### Cited Findings
- "Servers on exaroton don't have a fixed monthly price… each [credit] is worth €0.01… you get 5 credits for free… Running a server on exaroton costs 1 credit per GB of RAM per hour… 2 GB to 16 GB… we don't always charge you for full hours but calculate the exact price and round it up to the next hundredth of a credit… storage is limited to 10 GB per server… storage fee of 10 credits per month… if you spend 10 or more credits per month on running your server, you won't have to pay anything for storage… If you do not have enough credits to pay the storage fee, we have to delete your server" (article updated 2026-09-04) — [exaroton Pricing](https://support.exaroton.com/hc/en-us/articles/360019687657-Pricing)
- Home page: "Don't pay when you are at school… Only pay to play"; worked examples (2 h 24 m × 4 GB = 9.60 credits); "Start by joining" autostart, automatic stop after configurable time, Discord bot, API, custom panel, backups to Google Drive, share access, credit pools, DDoS protected, regions "North America, Europe", "No payment method required for trial" — [exaroton home](https://exaroton.com/)
- Regions: "We currently offer two server regions: Europe, North America… broader regions instead of specific countries or cities"; same price in both; selectable at creation or later in options — [Server region](https://support.exaroton.com/hc/en-us/articles/21659706549789-Server-region)
- Autostop: shuts down after a configurable period with no players; timer shown on the server page; "+5 minutes" button — [Stop your server automatically](https://support.exaroton.com/hc/en-us/articles/360019687297-Stop-your-server-automatically-when-it-s-empty)
- Credit pools: "All members of a credit pool can deposit some of their own credits into the pool, and all assigned servers automatically use those credits"; members can be given permission to add members/servers; "A server can only be added to one credit pool"; each member can withdraw their share — [Credit pools](https://support.exaroton.com/hc/en-us/articles/11567970055581-Credit-pools)
- Share access: per-server permissions for other exaroton users (Start, Stop/Restart, Console, Options, Files, Plugins/Mods, Worlds, Backups, Transactions, "Duplicate: Create copies of the server in their own account", Share access) — [Share access](https://support.exaroton.com/hc/en-us/articles/360019857358-Share-access)
- Uploads: "exaroton does not support FTP, you can still upload various files, including custom mods and plugins… upload button in the file manager… drag and drop files and folders… File uploads are limited to 3 GB"; not available during the free trial — [Uploading files and FTP access](https://support.exaroton.com/hc/en-us/articles/360019687677-Uploading-files-and-FTP-access)
- Custom server software uploads supported for Vanilla, Snapshot, Spigot, PaperMC, Purpur, Forge, NeoForge, Fabric, Quilt, Arclight, Nukkit, plus Velocity/Waterfall/BungeeCord; you select the Minecraft version and the executable (fabric-server-launch.jar for Fabric); not available in the free trial (updated 2026-02-25) — [Uploading custom server software](https://support.exaroton.com/hc/en-us/articles/360019687717-Uploading-custom-server-software-and-modpacks)
- Proxies: BungeeCord, Waterfall and Velocity installable from the Software page, proxy RAM can be as low as 1 GB, BungeeGuard preinstalled and preconfigured; backend servers must run in offline mode and be secured; Paper recommended for backends — [Using Minecraft proxies on exaroton](https://support.exaroton.com/hc/en-us/articles/4404724229137-Using-Minecraft-proxies-on-exaroton)
- Backups: link Google Drive, OneDrive or Dropbox and "store as many backups as you want" for free; automatic backups fall through the ordered services — [Creating and restoring backups](https://support.exaroton.com/hc/en-us/articles/360019857278-Creating-and-restoring-backups)
- 10 GB cap explained: the server is moved between storage and a host machine on every start/stop, so larger servers take minutes — [Maximum allowed server size](https://support.exaroton.com/hc/en-us/articles/360019687317-Maximum-allowed-server-size)
- Terms: operated by Aternos GmbH, Bonn; credits bought via Paddle or Tebex; "You can refund every purchase within 14 days without giving any reason if the corresponding amount of credits is still available in your account"; account closure forfeits credits — [exaroton ToS](https://aternos.gmbh/en/exaroton/terms)
- Aternos positions exaroton as the queue-free, upload-capable paid upgrade "Developed and run completely by the Aternos team" with an "Aternos Import" — [Aternos Queue article](https://support.aternos.org/hc/en-us/articles/360026950812-Queue); [exaroton home](https://exaroton.com/)

### Inferences
- Class cost model (my arithmetic from the 1 credit/GB/h rule): one 4 GB server × 3 h/week × ~4.3 weeks ≈ 52 credits ≈ €0.52/month; three such servers ≈ €1.56/month (~$1.70–1.85 at typical 2026 EUR/USD rates, unverified); each server clears the 10-credit storage threshold so no storage fee; even a 2 GB server at 2 h/week (≈17 credits) clears it. Over a 10-week term with 3 × 4 GB servers, ~360 credits ≈ €3.60.
- Concurrency: nothing in the pricing, pools or share-access articles limits simultaneous servers; pools are explicitly designed for "all assigned servers", and share access lets a teacher give co-teachers start/stop rights per server without sharing the login. I found no per-account server cap (see gaps).
- Pool mechanics fit a program: the teacher (or program account) deposits credits, adds each class server, and can hand "Start" permission to a helper; students would not need accounts at all since AutoStart lets players start the server by joining.
- Risks: a dormant server between terms costs 10 credits/month unless deleted (back it up to Drive and delete, as the article suggests); the North America region gives no city control; no FTP means datapack/mod uploads go through the browser (fine at a few MB); the 3 GB upload limit and 10 GB cap are irrelevant for small class worlds.

### Gaps
- USD price per credit / credit bundle prices are shown only after login (the "100 credits = …" value is filled by JavaScript); only the €0.01 figure is official.
- No documented maximum number of servers per account, and no explicit statement "servers can run concurrently" (strongly implied by pools and per-server billing).
- Whether 26.3 (and Fabric 26.3 with Java 25) is already in the panel's software list could not be verified without logging in; custom upload is the fallback.
- No age clause found in exaroton's ToS text I fetched; Paddle/Tebex checkout terms apply to purchases.

## Key question 3: Aternos free tier and why teachers outgrow it

### Takeaway
Aternos is free with no way to pay, but servers only run while someone is on them, start through a capacity queue with a confirm click, and cannot receive custom mod jars or FTP uploads (mods come only from its CurseForge/Modrinth library, datapacks are allowed), so a Fabric 26.3 server with the program's own server-side mods isn't possible and class start times can't be guaranteed.

### Cited Findings
- "Minecraft servers. Free. Forever… There is no possibility to pay for anything"; 141,991,022 users, "1 Million Players every day", 55,431 players online at fetch time; software offered: Vanilla, Snapshots, Paper, Spigot, Purpur, Glowstone, Forge, NeoForge, Fabric, Quilt, Modpacks, Arclight, Bedrock; "DDOS Protected"; automatic backups to Google Drive — [Aternos home](https://aternos.org/)
- Queue: "When our servers are at full capacity, you'll join a queue before your server starts… You'll see your position and estimated wait time… a confirmation screen appears with a green button. You must click the button to finally start your server… If you don't confirm, you're removed from the queue" — [Aternos Queue](https://support.aternos.org/hc/en-us/articles/360026950812-Queue)
- Uploads: "we can't provide you with FTP access and full file upload capabilities for plugins and mods… your server only runs when someone is actively using it. If we allowed custom plugin and mod uploads, users could potentially bypass our automatic shutdown system… Custom mods and plugins could contain malicious code"; allowed uploads: datapacks, resource packs, Bedrock addons, WorldEdit schematics, config files (updated 2026-10-06) — [Uploading files and FTP access](https://support.aternos.org/hc/en-us/articles/360027235831-Uploading-files-and-FTP-access)
- Mods: "Aternos offers a wide range of mods from CurseForge and Modrinth… It's only possible on Aternos to install mods from our mods library. You can't upload mods you've downloaded from the web"; Fabric/Forge/NeoForge/Quilt loaders available (updated 2026-06-24) — [Install mods (Java)](https://support.aternos.org/hc/en-us/articles/360027235871-Install-mods-Minecraft-Java-Edition)
- Terms (Aternos GmbH, Bonn): account needs only a username (email optional); "We delete servers after a long period of inactivity. Usually, this period lasts 3 months"; third-party content installed at your own risk; no age clause in the fetched text — [Aternos ToS](https://aternos.gmbh/en/aternos/terms)
- Third-party figures (unofficial, conflicting): free RAM "around 1-2 GB" vs "roughly two to two-and-a-half gigabytes"; ~4 GB storage per server; idle timeout ~5 minutes; peak queue waits 5–20+ minutes; no hard slot cap but lag past ~10 players — [Supercraft wiki](https://supercraft.host/wiki/minecraft/aternos_free_limits_when_to_upgrade/); [MineGuard blog](https://mineguard.pro/en/blog/aternos-vs-paid-hosting-comparison)
- iTechGuides characterises Aternos as "Free, ad-funded… No 24/7 uptime; Java, Bedrock, Geyser", editor score 7.8 — [iTechGuides MC directory](https://www.itechguides.com/best/minecraft-server-hosting/)

### Inferences
- For this program Aternos fails on requirement (b) outright: the Command Forge pack's datapacks would upload, but any custom server-side Fabric mod (e.g. the planned key→/trigger instructor mod) cannot be installed unless it is published on Modrinth/CurseForge and whitelisted into Aternos's library.
- Requirement (a) is weak: several free servers per account are possible but each independently queues and sleeps, so three groups starting at 4 pm may wait different amounts of time.
- "Why teachers outgrow it": queue at class start, sleep when the last student leaves (loses scheduled/automated things), no uploads, no fixed capacity, no support SLA, account/data deletion after ~3 months idle (summer break), and no way to pay to fix any of it; Aternos itself routes those users to exaroton.
- Kid-suitability: no payment or email required is convenient, but also means a 10-year-old can create accounts freely; the absence of an age clause in the ToS leaves COPPA handling to the teacher.

### Gaps
- Aternos publishes no numbers for RAM, slots, idle timeout or storage; all figures above are third-party estimates.
- Could not confirm whether Aternos's Fabric list already includes 26.3.
- Ads: the home page text I fetched didn't mention ads; "ad-funded" is iTechGuides' description.

## Key question 4: Nodecraft's instance model

### Takeaway
Nodecraft instances are stored snapshots ("save slots"): deploying one requires a free "bot" (service plan), and with one plan the running instance must be archived before another can deploy, so simultaneous servers need separate subscriptions; Lite hibernates when empty (Wake & Play link), Pro is 24/7.

### Cited Findings
- "An instance is a saved snapshot of a server's files… Deploying requires an available bot (service plan). The article's example of '1/1' means all bots are in use, so you must archive the running instance before deploying another… Archiving zips the server to cloud storage… The IP address often changes" on redeploy — [Nodecraft KB: What are instances](https://nodecraft.com/support/knowledgebase/nodepanel/what-are-instances-and-how-to-use-them)
- FAQ: "Nodecraft allows users to save and swap between games and modpacks by utilizing the server instances available to each plan. These instances can be thought of like save slots" — [Nodecraft build-your-own](https://nodecraft.com/pricing/build-your-own)
- Lite vs Pro differences and the Wake & Play share link — [Nodecraft KB Lite vs Pro](https://nodecraft.com/support/knowledgebase/nodecraft-lite-servers/nodecraft-pro-vs-nodecraft-lite-whats-the-difference)
- One listing shows a Pro plan with "3 Save & Swap instances" — [search summary via Nodecraft pages](https://nodecraft.com/pricing?games=tf2)
- Fabric: Nodecraft's pages cite one-click modpacks/plugins (520+ modpacks); no explicit Fabric statement found — [iTechGuides MC directory](https://www.itechguides.com/best/minecraft-server-hosting/)

### Inferences
- Instances suit a single class that rotates between worlds/games week to week (swap takes minutes, IP may change — use the hostname), not parallel groups.
- Nodecraft Lite is the only big-brand "pay less when idle" option, but it is a flat monthly fee, not metered: hibernation saves Nodecraft money, not the buyer.
- Daytime-only support (per two competitor-authored sources) matters for an after-school program hitting problems at 4–6 pm; treat as unverified.

### Gaps
- No Nodecraft statement that explicitly says "only one instance runs at a time"; it's the documented bot/archive mechanic.
- Instance count per Lite plan not found.

## Key question 5: Built-in multi-server networking / sub-servers on one plan

### Takeaway
Only exaroton documents a first-class proxy workflow (Velocity/BungeeCord/Waterfall with BungeeGuard preinstalled, 1 GB proxy servers), and only Kinetic (4 "splits") and Sparked ("Server Splitter Tool") let one plan be carved into several concurrently running servers; Apex, Shockbyte, Bisect and Nodecraft treat each backend as a separate paid server.

### Cited Findings
- exaroton proxies article (see KQ2) — [Using Minecraft proxies on exaroton](https://support.exaroton.com/hc/en-us/articles/4404724229137-Using-Minecraft-proxies-on-exaroton)
- Kinetic: "4 splits" on the 8 GB and 12 GB plans; "Split Your Server: Allocate unused resources to additional servers at no extra cost"; "Split user resources across multiple servers on the fly" — [Kinetic order page](https://www.kinetichosting.com/game-servers/minecraft/order)
- Sparked Apollo Panel lists a "Server Splitter Tool" and "Secure Reverse Proxy" — [Sparked home](https://sparkedhost.com/)
- Shockbyte's BungeeCord guide: a network is "a group of at least three servers, usually a hub/lobby and at least one gamemode server, all connected by a BungeeCord proxy"; each backend set up as its own server (old-panel article) — [Shockbyte KB BungeeCord](https://shockbyte.com/billing/knowledgebase/90/Automatically-Setup-a-BungeeCord-Network-with-Shockbyte.html)
- Bisect: no Velocity/proxy mention on its Minecraft page; instance slots swap only — [Bisect Minecraft page](https://www.bisecthosting.com/minecraft-server-hosting)
- Apex: no multi-server/proxy KB article surfaced; billing and panel logins are per server — [WiseHosting Apex review](https://wisehosting.com/blog/apex-hosting-review)
- For context, a German host (Starmine) advertises school terms plus Velocity/BungeeCord multi-server setups — [Starmine partners page](https://www.starmine.net/en/partners.html)

### Inferences
- Note the Fabric wrinkle: exaroton's proxy guide assumes Paper backends and offline-mode; vanilla-client Fabric backends behind Velocity need the FabricProxy-Lite style mod for modern forwarding, so a proxy adds complexity the program may not want. For a kids' class, separate direct-join servers (one address per group) are simpler than a proxy network on every host here.
- Kinetic's split model is the closest thing to "sub-servers on one plan" among US-priced managed hosts: a $12.99 12 GB plan split into three 4 GB servers is $4.33 per concurrent server.

### Gaps
- Kinetic's split rules (minimum RAM per split, whether each split gets its own port/IP and Java version, whether splits count toward the 60 GB) weren't retrievable from the pages I could read.
- Sparked's splitter details and current pricing page could not be fetched.

## Key question 6: Age/payment rules, education programs and discounts

### Takeaway
Only Shockbyte's terms were readable on age (13+, parental permission under 18); none of these hosts advertises a classroom discount, but BisectHosting runs the Craft Together Project (free servers for schools/libraries, 2022 announcement, eligibility unpublished) and Apex links an "Education Scholarship" page.

### Cited Findings
- Shockbyte: 13+, under-18s need parent/guardian permission — [Shockbyte ToS](https://shockbyte.com/terms-of-service)
- BisectHosting "Craft Together Project aims to provide those schools, libraries, and other small learning communities with quality Minecraft servers completely free of charge… no catch or hidden fees" (posted 2022-08-02) — [Bisect blog announcement](https://www.bisecthosting.com/it-it/blog/bisecthosting-presents-the-craft-together-project); a public library documents using it — [Framingham Public Library](https://framinghamlibrary.org/minecraft)
- Apex's footer lists "Education Scholarship" — [Apex pricing page footer](https://apexminecrafthosting.com/pricing/)
- exaroton purchases go through Paddle/Tebex with their buyer terms; 14-day refund of unused credits — [exaroton ToS](https://aternos.gmbh/en/exaroton/terms)
- Aternos accounts need only a username; servers deleted after ~3 months idle — [Aternos ToS](https://aternos.gmbh/en/aternos/terms)
- Industry pattern from other hosts' terms (not these): minimum 13 to use, 18 to purchase/manage billing, parent as contracting party for minors (Expanse, Pyro, MintServers) — [Expanse ToS](https://expanse.host/terms-of-services); [Pyro ToS](https://pyro.host/legal/terms)

### Inferences
- An adult teacher as account holder and payer satisfies every host's terms I could read; the open question is each host's privacy policy for players under 13, which is a Mojang-account matter rather than a hosting one since kids never log into the host panel (except Aternos, where they would).
- Bisect's Craft Together is worth an email: a free 4–8 GB BisectOne server for a nonprofit kids' program is plausible, but it would still be one server per grant.

### Gaps
- Apex, Bisect, Nodecraft, Kinetic, exaroton and Aternos age clauses not found in fetched text (Nodecraft's ToS URL 404'd; Apex's ToS text has no age wording in my search).
- Craft Together eligibility, application process and current status (2026) unknown.
- No education discount found at any of the eight hosts.
