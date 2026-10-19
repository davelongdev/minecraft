# Modrinth Servers ("Modrinth Hosting") as a host for Minecraft Java 26.3 + server-side Fabric mods (state as of 2026-10-18)

Naming note: the product launched as "Modrinth Servers" (beta, Nov 2024, run with Pyro). Modrinth took it fully in-house in March 2025 and its help center, changelog, and landing page now call it **"Modrinth Hosting"** (landing page is `modrinth.com/hosting`; `modrinth.com/servers` serves the same page). The "run with Pyro" description in the assignment is stale. Anything cited from 2024–mid-2025 below is marked **(possibly stale)**.

Research limits: Reddit (r/admincraft, r/Minecraft) is blocked for this crawler, so community threads could not be read; third-party review sites and Trustpilot were used instead. Modrinth's official developer docs (`docs.modrinth.com`) cover only the API and contain no hosting pages; the hosting documentation is 15 Intercom help-center articles at `support.modrinth.com`. No official page lists the exact Minecraft/loader versions available in the panel; that was inferred (see Q2).

## Q1. Plans, prices (USD/month), RAM/CPU/storage, regions (US East?), and pausing/stopping billing between sessions

### Takeaway
Three preset plans are listed at **$10 / $15 / $20 per month billed quarterly** (4/6/8 GB RAM, 2/3/4 shared vCPUs with 2x burst, 32/48/64 GB storage), but **all three were "out of stock" on 2026-10-18**; the only orderable option was a **custom plan "starting at $5/month"** with no public per-GB price. There is **no pause feature**: a stopped server still bills, the only ways to stop paying are cancel (self-serve in billing settings) or let payment fail, and the refund policy only covers the first 24 hours, verified non-use, or Modrinth-caused outages.

### Cited Findings
- Plans on the official landing page (fetched 2026-10-18): **Small $10/month, billed quarterly** — 4 GB RAM, 32 GB storage, 2 shared CPUs, bursts up to 4, "1–5 friends with a few light mods", *out of stock*; **Medium $15/month, billed quarterly** — 6 GB RAM, 48 GB storage, 3 shared CPUs, bursts up to 6, "Great for 6–15 players and multiple mods", "Most popular", *out of stock*; **Large $20/month, billed quarterly** — 8 GB RAM, 64 GB storage, 4 shared CPUs, bursts up to 8, "Ideal for 15–25 players, modpacks, or heavy modding", *out of stock*; **Custom plan "Starting at $5 / month"**, "Pick a customized plan with just the specs you need." — [modrinth.com/hosting](https://modrinth.com/hosting) (same content at [modrinth.com/servers](https://modrinth.com/servers))
- The page has a "Pay monthly" / "Pay quarterly" toggle and says **quarterly billing saves 16%**; the fetched (default, quarterly) view did not show separate monthly prices — [modrinth.com/hosting](https://modrinth.com/hosting)
- Older/other published figures for the same tiers: **Small 4 GB $12/mo, Medium 6 GB $18/mo, Large 8 GB $24/mo, "Custom: up to 48GB RAM", average "$3.00/GB"** (competitor WiseHosting's review page, "Last updated: Sep 2, 2026"; competitor-authored, treat as promotional) — [WiseHosting review](https://wisehosting.com/blog/modrinth-servers-review)
- Launch pricing was **"$3 per GB of RAM"** in Small/Medium/Large tiers, custom URLs, ports, off-site backups and storage included at no extra cost; **US-only during beta** **(possibly stale: Nov 3, 2024)** — [Modrinth news: Modrinth Servers beta](https://modrinth.com/news/article/modrinth-servers-beta/)
- A third-party review in September 2026 also found "the 4GB, 6GB and 8GB standard plans were all showing out of stock when we checked", and lists the same $10/$15/$20 quarterly-equivalent prices and "custom plan: starts around $5/month" — [gameserverhosting.co.uk review 2026](https://gameserverhosting.co.uk/reviews/modrinth-hosting-review/)
- Another third-party guide (dated Aug 3, 2026) repeats $10/$15/$20 quarterly and says monthly billing is "higher than quarterly" without giving figures — [natchecker.com guide](https://natchecker.com/blog/modrinth-server-hosting)
- Stock has been an issue for a long time: changelog entries "Added an indicator to show when certain server plans are running low on availability" (Feb 12, 2025), "Fixed server upgrades being allowed when out of stock, despite warning" (Feb 25, 2025), "Fixed Modrinth Servers showing as out of stock when navigating to the page directly" (Jul 8, 2025) — [Modrinth changelog](https://modrinth.com/news/changelog)
- Hardware: "powered by AMD Ryzen 7950X or 9950X equivalent, paired with DDR5 memory"; burst CPU threads are temporary, for high-load periods, "This helps prevent the TPS from going below 20" — [modrinth.com/hosting FAQ](https://modrinth.com/hosting)
- Storage: "Yes, storage can be increased on your server at no additional cost" (contact support) — [modrinth.com/hosting FAQ](https://modrinth.com/hosting)
- Regions listed: **North America, Europe, Southeast Asia, and Australia**; you choose at purchase; to switch regions, contact support — [modrinth.com/hosting FAQ](https://modrinth.com/hosting)
- Region history from the changelog: "Added Dallas location to Modrinth Servers landing page" (Feb 20, 2025); "Added support for servers in Europe" (Jun 3, 2025); Europe shown as "Central Europe with the flag of Germany" (Jul 10, 2025); "new UK location" added to FAQ (Jul 15, 2025); "Added a new Australia region for Modrinth Hosting" (May 31, 2026) — [Modrinth changelog](https://modrinth.com/news/changelog)
- The landing page's decorative globe component in Modrinth's open-source frontend marks five active North American points: New York, Los Angeles, Miami, Spokane, Dallas (European and Asian points are commented out, so this file is not an authoritative region list) — [modrinth/code Globe.vue](https://github.com/modrinth/code/blob/main/apps/frontend/src/components/ui/servers/Globe.vue)
- Free trial: a "limited five-day, 3GB US trial powered by Medal", usable without a card — [gameserverhosting.co.uk](https://gameserverhosting.co.uk/reviews/modrinth-hosting-review/); the changelog records on **Oct 9, 2026**: "Removed the Modrinth Hosting x Medal five-day trial promo" — [Modrinth changelog](https://modrinth.com/news/changelog)
- Upgrades: "You can upgrade a server's hosting plan at any time from your account's billing settings"; steps include "Get started" to "pick a memory amount" (custom sizing); "Upgrades are prorated... you pay only the difference between plans for the current billing period"; upgrade completes in "about 5 to 10 minutes"; "an average server needs no more than 12 GB of memory" — [Upgrading Subscriptions](https://support.modrinth.com/en/articles/16753926-upgrading-subscriptions)
- Refund policy: full refund "If a refund is requested within 24 hours of the transaction"; after 24 h a partial refund for the remaining days if support "can verify that you have not used your server during the billing cycle"; partial refund for days the server was inaccessible due to "the Modrinth Servers hardware/software" (crashes from mods, configs, or mod loaders don't qualify); **chargeback = "immediately terminate all servers associated with your account and prevent you from creating servers in the future"** — [Modrinth Servers refund policy](https://support.modrinth.com/en/articles/11190387-modrinth-servers-refund-policy)
- Failed payments: "the system retries the charge every 48 hours until it eventually works" unless the subscription is cancelled; support can convert a failed payment to cancelled via a ticket ("I have a billing issue with my server") — [Repeated failed charges](https://support.modrinth.com/en/articles/11190444-repeated-failed-charges)
- Self-serve cancellation exists: changelog "Added feedback survey upon Modrinth Servers cancellation" (Apr 26, 2025), "Failed subscriptions can now be cancelled" (Jun 16, 2025), "Suspended servers now display a clear 'Suspended' status" (Dec 12, 2024), and **Sep 7, 2026: "Added a button on the Manage servers page to download files from suspended or cancelled servers"** — [Modrinth changelog](https://modrinth.com/news/changelog)
- Non-USD pricing display was fixed Sep 14, 2026 ("fixed non-USD pricing for Modrinth Hosting and Modrinth+"), so prices are shown in local currency for some users — [Modrinth changelog](https://modrinth.com/news/changelog)
- A Trustpilot reviewer (Mar 24, 2026, 1 star) says they "Bought a $45/month Medium plan" — [Trustpilot page 2](https://uk.trustpilot.com/review/www.modrinth.com?page=2) (reviewer wording; $45 matches a quarterly charge for the $15/month Medium plan)
- Billing complaint (Sep 29, 2026, 1 star): contacted support about cancelling a server "SEVERAL TIMES" and reports being charged repeatedly afterwards — [Trustpilot](https://ca.trustpilot.com/review/www.modrinth.com) (unverified individual review)

### Inferences
- Monthly billing is probably about **$12 / $18 / $24** for Small/Medium/Large: the page states quarterly "saves 16%", and 10/0.84 ≈ 11.9, 15/0.84 ≈ 17.9, 20/0.84 ≈ 23.8, matching the $12/$18/$24 figures still printed by third-party reviews and the original $3/GB launch rate. Not directly observed on the page; verify by flipping the "Pay monthly" toggle.
- The custom plan at "$5/month" is most likely a ~2 GB server at roughly the same per-GB rate (the Medal trial was 3 GB); no official per-GB number for custom plans was found.
- For a program that runs, say, 2 hours a week, there is no documented way to pay only for session time: you would pay the full month/quarter for every server you keep. The cheapest legitimate "between terms" option is to download a backup, cancel, and re-create later (the Sep 2026 "download files from suspended or cancelled servers" button supports this).
- "US East" is not named anywhere official. Modrinth's own changelog names Dallas (US Central) as the first location; the globe graphic suggests New York/Miami are among North American points, but the actual region picker only appears at checkout. A US East node is plausible but unconfirmed.

### Gaps
- Exact monthly (non-quarterly) prices and the custom-plan per-GB price and RAM steps (the configurator requires an account/checkout).
- Whether the preset plans' "out of stock" state is temporary; no restock ETA found.
- The specific city/region list in the checkout region picker (US East vs Central vs West).
- Any pause/hibernate billing option (none found; absence is strong but not officially stated).

## Q2. Minecraft 26.3 + Fabric Loader support; installing mods and datapacks (Modrinth only vs own jars/zips, file manager, SFTP)

### Takeaway
The panel installs **Vanilla, Fabric, Forge, Quilt, NeoForge, Paper, Purpur** on "any version of Minecraft: Java Edition going all the way back to version 1.2.5, including snapshot versions" where the loader supports it, and Fabric officially lists 26.3 as a stable game version, so a 26.3 Fabric server should be a dropdown pick (not directly screenshot-verified). **Custom jars and datapack zips are explicitly supported** via the web Files tab (upload / drag-and-drop) and built-in SFTP; Modrinth's own help article documents dropping a datapack zip into `world/datapacks`.

### Cited Findings
- "any version of Minecraft: Java Edition going all the way back to version 1.2.5, including snapshot versions. Loader availability depends on whether the loader supports the chosen version." Loaders: "Vanilla, Fabric, Forge, Quilt, and NeoForge" for mods; "Paper and Purpur" for plugins — [modrinth.com/hosting FAQ](https://modrinth.com/hosting)
- "Added support for installing snapshot versions of Minecraft" (Apr 29, 2025); "Fixed NeoForge installs sending an empty loader version" (Mar 26, 2026); "The 'Change version' and 'Re-install modpack' buttons are hidden for custom file modpacks" (Mar 27, 2026, i.e. you can install a custom uploaded modpack file) — [Modrinth changelog](https://modrinth.com/news/changelog)
- Fabric's official version metadata lists `26.3` as `stable: true` (newer entries are 26.4 snapshots 1–4), so Fabric Loader supports 26.3 — [meta.fabricmc.net/v2/versions/game](https://meta.fabricmc.net/v2/versions/game)
- A 26.3 mod's changelog on Modrinth names the loader build: dependencies moved to **fabric-loader 0.19.5** and **fabric-api 0.161.0+26.3**, with the 26.3 stable release dated 2026-09-15 — [Modrinth mod version page](https://modrinth.com/mod/lava-boats/version/4vKjDtW8)
- Included tools per server: "a console and server properties manager", a file manager ("Search, edit, and upload files"), "Built-in SFTP access to server files", custom domain support, "up to 15 reserved ports" — [modrinth.com/hosting](https://modrinth.com/hosting)
- Datapack install (official article): stop the server; open **Files** tab → world folder ("usually named 'world'") → `datapacks`; click **+** → **Upload file**, "or drag and drop the ZIP onto the file manager"; restart and confirm with `/datapack list enabled`. Warns that command-based datapacks "can still use a lot of server tick time", especially ones that "run commands every tick, especially per player" — [Datapacks on Modrinth Hosting](https://support.modrinth.com/en/articles/14030919-datapacks-on-modrinth-hosting)
- SFTP credentials: server panel → cog → **Advanced** → **Launch SFTP**; password on the server's **Info** page; worlds > 1 GB have "alternative steps"; recommends compressing before upload because "Small or individual files transfer slowly over SFTP"; to use an imported world, rename its folder to `world` — [Import an Existing World Onto a Server](https://support.modrinth.com/en/articles/10348540-import-an-existing-world-onto-a-server)
- File-manager upload features in the changelog: "Added file upload queue status bar" plus parallel uploads (Dec 22, 2024); "You can now upload directly from the content page" (Jan 10, 2025); drag-and-drop upload fix in the Files tab (Jun 8, 2026); file zipping added to the Files tab (Sep 7, 2026); "Update all" modal with per-project version pick (Sep 27, 2026); a toggle for server-side-only content when browsing Modrinth mods from the panel (Jul 4, 2026) — [Modrinth changelog](https://modrinth.com/news/changelog)
- Third-party reviewers list "No world manager, live player manager, or version switcher" and "No CurseForge support" (CurseForge packs must be uploaded manually) as cons — [WiseHosting review](https://wisehosting.com/blog/modrinth-servers-review) (competitor)
- An unofficial Mintlify-generated mirror of the repo docs says the panel has a "Startup configuration option for the Java version and startup command" and a web file manager; this mirror is not Modrinth-published and is otherwise out of date (it lists 20/30/40 GB storage) — [mintlify.wiki mirror](https://mintlify.wiki/modrinth/code/hosting) (unverified)

### Inferences
- A custom server-side Fabric mod jar that is **not** published on Modrinth can be installed by uploading it to `mods/` via the Files tab or SFTP exactly like a world or datapack; nothing found says uploads are restricted to Modrinth-hosted projects, and the datapack article's upload flow is generic file upload.
- 26.3 Fabric should be selectable because Fabric's own metadata marks 26.3 stable and the panel's stated rule is "any version... if the loader supports it"; a quick confirmation is to open the Platform → version dropdown on a trial/custom server before committing to a quarter.
- Java 25 (required by 26.3) is presumably provisioned automatically with the version pick, since the panel installs the loader for you; no article states the Java version.

### Gaps
- No official screenshot/list of the panel's version dropdown confirming 26.3 or Fabric Loader 0.19.5 specifically.
- No official statement on whether the startup JVM command/Java version is user-editable (only the unofficial mirror says so).
- Whether SFTP is restricted (bandwidth, concurrent sessions); one Trustpilot reviewer complained of slow upload/download speeds.

## Q3. Multiple servers per account, price per additional server, multi-world or proxy (Velocity) support

### Takeaway
One account can own several servers (the panel has a "My Servers" / "Manage servers" page and the changelog talks about "all servers associated with your account"), but **each server is its own subscription at full plan price**, with no bundle or multi-server discount found. **No multi-world switching, Velocity/BungeeCord proxy, or sub-server feature is documented**; a Modrinth server is one Minecraft process with one `world` folder.

### Cited Findings
- "Server status information is now correctly displayed in the 'My Servers' page" (Aug 2, 2025); "Fixed upgrading Medal servers from the Manage servers page" (Aug 14, 2026); "Added a button on the Manage servers page to download files from suspended or cancelled servers" (Sep 7, 2026) — [Modrinth changelog](https://modrinth.com/news/changelog)
- Chargeback clause refers to "all servers associated with your account", implying accounts can hold more than one — [Refund policy](https://support.modrinth.com/en/articles/11190387-modrinth-servers-refund-policy)
- Each server includes "up to 15 reserved ports" and custom domain support — [modrinth.com/hosting](https://modrinth.com/hosting); the help center's extra-port use cases are Simple Voice Chat and Geyser (Bedrock crossplay), not proxies — [Adding Simple Voice Chat](https://support.modrinth.com/en/articles/10351579-adding-simple-voice-chat-to-your-server), [Adding Geyser](https://support.modrinth.com/en/articles/10986613-adding-geyser-to-your-server)
- The datapack article says the `datapacks` folder lives inside "the world folder you're targeting" and does not cover running multiple worlds — [Datapacks on Modrinth Hosting](https://support.modrinth.com/en/articles/14030919-datapacks-on-modrinth-hosting); the world reset article covers "Creating a new world or resetting the existing one" only — [Reset a Server's World](https://support.modrinth.com/en/articles/11107875-reset-a-server-s-world)
- Modrinth's landing page lists only Vanilla/Fabric/Forge/Quilt/NeoForge/Paper/Purpur as installable platforms, i.e. no Velocity/BungeeCord/Waterfall proxy platform — [modrinth.com/hosting](https://modrinth.com/hosting)
- A separate 2026 feature, **Server Projects** (Mar 4, 2026), is a *listing* type for public servers (vanilla / linked Modrinth modpack / uploaded custom pack; app auto-installs the pack and joins) and is not a hosting feature; "Servers that can't be pinged for a sustained period are removed from discovery" — [Introducing Server Projects](https://modrinth.com/news/article/introducing-server-projects/)
- Reviewers list "No world manager" as a missing feature — [WiseHosting review](https://wisehosting.com/blog/modrinth-servers-review) (competitor)

### Inferences
- For "several games at once", the realistic Modrinth setup is **N separate servers = N subscriptions** (e.g. three Small servers would be 3 × $10/month on quarterly billing, if Small is in stock, or 3 custom plans from $5/month each). A single larger server could instead host several games as *dimensions/areas within one world* via datapacks/mods (as the repo's Command Forge islands already do), which fits Modrinth better than multi-world.
- Running a Velocity proxy plus backend servers would need a proxy process; Modrinth offers no proxy platform and no documented way to launch extra processes, so a proxy network is effectively unsupported here. The 15 reserved ports are for sidecar mods (voice chat, Geyser), not for additional Minecraft servers.
- With the Jun 2026 Access feature (Q4), the teacher can own all subscriptions on one account and give co-teachers Editor/Limited access per server.

### Gaps
- No official statement of a maximum number of servers per account or any multi-server discount.
- No official statement on whether a single server can run more than one Java process (e.g. a proxy); absence inferred from docs, not confirmed by support.

## Q4. Operational features: console, scheduled restarts, backups, whitelist/ops, subdomain, DDoS, uptime/SLA

### Takeaway
Console, properties editor, file manager, SFTP, a free `*.modrinth.gg` subdomain, custom domains, DDoS protection, and **15 off-site backup slots** are included, and since **June 4, 2026** the owner can invite other Modrinth users as Editor or Limited co-admins with an activity log. **Automatic/scheduled backups are currently off** ("we do not create automatic backups"; the server must be stopped to back up), **no scheduled-restart or task scheduler is documented**, and **no uptime SLA** exists.

### Cited Findings
- Included with every server: "15 backups stored off-site"; DDoS protection "with up to 17 Tbps capacity in some locations"; "A custom modrinth.gg URL"; console and server properties manager; file manager; SFTP; custom domains and up to 15 reserved ports; "Modrinth support" — [modrinth.com/hosting](https://modrinth.com/hosting)
- Backups (official article): "Currently, we do not create automatic backups for servers." / "In the near future, you'll be able to set up automatic scheduled backups through our panel!"; the server must be **stopped** before creating a backup (use "Kill" if the button is greyed out); backups are "stored separately from your server's files and will persist through server erasures and mod pack swaps"; restore "will essentially erase your server's files and replace them with the exact files from the restored backup" and can take minutes to an hour; backups made after Oct 14, 2025 download as a streamed ZIP — [Managing Backups](https://support.modrinth.com/en/articles/14030930-managing-backups)
- Backup history shows auto-backups once existed and were pulled: "Automatic backups are now rolling" (Dec 12, 2024); "Auto-backup now lists options in a dropdown" (Jan 10, 2025); "Temporarily disabled auto backups button, since they are currently not working" (Apr 17, 2025); backups page overhauled Dec 4, 2025; "Backups now show their creator" (Jun 8, 2026) — [Modrinth changelog](https://modrinth.com/news/changelog); the frontend still carries a "Backup schedule" label string — [modrinth/code BackupItem.vue](https://github.com/modrinth/code/blob/main/packages/ui/src/components/servers/backups/BackupItem.vue)
- Shared access (Jun 4, 2026): invite by Modrinth username; roles **Owner** (full, incl. billing; the creator), **Editor** ("Manages content, files, backups, settings, and installation. Can also execute commands"), **Limited** ("Can start, stop, and view the server, but can't make changes"); only Owners invite users, reset the server, and manage billing; an **activity log** records what changed, who, and when, filterable by period/user/action; no stated limit on invitees — [Manage servers together](https://modrinth.com/news/article/server-access/)
- Before that feature, reviewers complained "No sub user support, not even power control access" (Jan 8, 2026, 2 stars) — [Trustpilot page 2](https://uk.trustpilot.com/review/www.modrinth.com?page=2)
- Support channel: a live-chat/ticket bubble on every server page (Dec 2024 changelog; refund article describes "the green bubble in the bottom-right corner") — [Modrinth changelog](https://modrinth.com/news/changelog), [Refund policy](https://support.modrinth.com/en/articles/11190387-modrinth-servers-refund-policy)
- Help center for hosting is 15 articles total (12 + 3 billing) — [Modrinth Hosting collection](https://support.modrinth.com/en/collections/11303951-modrinth-hosting); a reviewer called the knowledge base weak ("only eight help articles at the time of writing") and said "Assistance is limited to set hours" (no 24/7 support) — [WiseHosting review](https://wisehosting.com/blog/modrinth-servers-review) (competitor)
- Spark profiler guide for performance diagnosis exists — [Creating Performance Profiles](https://support.modrinth.com/en/articles/16838029-creating-performance-profiles)

### Inferences
- Whitelist and ops are managed the ordinary way (console commands `whitelist`/`op`, or `server.properties` via the properties manager); no GUI player manager exists (reviewers explicitly note the lack of a "live player manager").
- Because backups require a stopped server and are manual, a teacher should make a habit of "stop → Create backup" at the end of each session; 15 slots is enough for weekly snapshots over a term.
- Scheduled restarts would have to come from a server-side mod/plugin rather than the panel.

### Gaps
- No uptime guarantee / SLA document found anywhere on Modrinth's site.
- No official documentation of a task scheduler, scheduled restarts, or crash auto-restart behaviour.
- No official statement of backup size limits or whether the 15-slot cap is per server or per account (the landing page phrasing "included with every server" suggests per server).

## Q5. Restrictions: content policy, age, player caps, CPU limits, classroom-relevant terms (owner age, sharing with other admins)

### Takeaway
Modrinth's Terms (last modified Aug 13, 2026) set a **13+ minimum** and require legal capacity to contract; there is **no hosting-specific terms or acceptable-use page** beyond the refund/chargeback policy, so a teacher (adult, with a card) should own the account and share via the Access roles. There are **no published player caps**; CPUs are shared vCPUs with burst, and plan copy suggests 6–15 players on 6 GB and 15–25 on 8 GB.

### Cited Findings
- "The Service is offered and available to users who are 13 years of age or older" and users represent they are "of legal age to form a binding contract with the Company"; "Last modified: August 13, 2026"; the Terms define the Service as the website, API, and App and contain no hosting-specific billing/suspension/content clauses — [Modrinth Terms of Service](https://modrinth.com/legal/terms)
- Hosting-specific policy found is limited to refunds and the chargeback rule (a dispute terminates all your servers and bars future ones) — [Refund policy](https://support.modrinth.com/en/articles/11190387-modrinth-servers-refund-policy)
- CPU model: "shared CPUs" with burst ("2 shared CPUs, bursts up to 4" on Small, etc.); burst threads "are temporary and mainly for high-load periods" — [modrinth.com/hosting](https://modrinth.com/hosting)
- Player guidance is only the plan copy ("1–5 friends", "6–15 players", "15–25 players"); no hard slot cap is listed — [modrinth.com/hosting](https://modrinth.com/hosting); the sizing article says "The numbers on the website are estimates for an average server" and "A heavily modded server with a view and simulation distance of 4 may run better than a vanilla server with 4 players" — [Choosing a Hosting Plan](https://support.modrinth.com/en/articles/16754012-choosing-a-hosting-plan)
- Memory troubleshooting: a server that "stops without a crash log" is the OOM symptom covered by the help center — [Troubleshooting Memory Issues](https://support.modrinth.com/en/articles/16753970-troubleshooting-memory-issues)
- Co-admin sharing is officially supported via Owner/Editor/Limited roles (Jun 4, 2026) — [Manage servers together](https://modrinth.com/news/article/server-access/)

### Inferences
- A program lead over 18 with a payment method must be the Owner; students (13+) could in principle hold Modrinth accounts and be given Limited/Editor access, but kids under 13 cannot have Modrinth accounts at all under the Terms, so they would only ever *join* the server, never log into the panel.
- No content/AUP specific to hosting means the general Modrinth content rules and the chargeback clause are the only written restrictions; nothing found that prohibits educational/private use.
- For 10–20 kids with light custom Fabric mods and command-heavy datapacks, Medium (6 GB) or Large (8 GB) matches Modrinth's own guidance; the datapack article's warning about per-tick command datapacks applies directly to Command Forge-style packs.

### Gaps
- No hosting acceptable-use policy, no statement on whether an account owner may be an organisation, and no statement on sharing one account's login (as opposed to the Access roles).
- No published per-server player slot limit or network bandwidth limit.

## Q6. Reviews and reliability in 2026: outages, support quality, common complaints

### Takeaway
Public reviews are **mixed-to-negative on support and reliability**: Trustpilot scores Modrinth 2.8/5 across 87 reviews (app and hosting combined), with 2026 hosting reviews citing multi-hour and multi-week downtime, 8-hour support gaps, 16-hour provisioning waits, and cancellation/billing friction, against a few reports of fast, competent human help. Modrinth's status page lists six API/search incidents between Aug 1 and Oct 14, 2026, but none explicitly names Hosting, and there is no public hosting uptime history.

### Cited Findings
- Trustpilot: "TrustScore 2.8 out of 5, based on 87 reviews (43% are 1-star)"; Trustpilot notes the company hasn't invited customers to review — [Trustpilot (CA)](https://ca.trustpilot.com/review/www.modrinth.com)
- Hosting-specific reviews: Oct 19, 2025, 1★ — upgraded "from a $75 plan to a $105 plan", server offline about 10 hours with no updates; Jan 4, 2026, 1★ "Support System is a Joke" — "the server I PAY FOR has been down since December", no 24/7 support; Jan 8, 2026, 2★ "Good app, terrible hosting." — no sub-users, automated-seeming support; Feb 22, 2026, 5★ "Really Amazing Support" — "I got extremely fast assistance" setting up; Mar 24, 2026, 1★ — "$45/month Medium plan", still not provisioned 16 hours later, no ticket reply, "no Discord support"; May 29, 2026, 1★ — "server will constantly go offline for hours at a time", support "only responds once every 8 hours"; Sep 29, 2026, 1★ — "the servers are so glitchy", repeated cancellation requests, still charged — [Trustpilot page 2](https://uk.trustpilot.com/review/www.modrinth.com?page=2), [Trustpilot page 1](https://ca.trustpilot.com/review/www.modrinth.com) (all unverified individual reviews)
- Independent test (Sep 2026): support ticket about a mod/plugin startup issue got "a human reply in about 70 minutes" that was "useful and specific"; overall score 8.8/10 (Support 8.8); con: not a budget host, presets out of stock; latency figures on that page are modelled, "Low" confidence, not measured — [gameserverhosting.co.uk](https://gameserverhosting.co.uk/reviews/modrinth-hosting-review/)
- Competitor review quotes a user: "Modrinth servers work phenomenally (outside of a few things) but the customer support and knowledgebase is awful." Pros listed: ~2-minute setup, one-click Modrinth installs, backups "with no paywall" — [WiseHosting review](https://wisehosting.com/blog/modrinth-servers-review) (competitor)
- Official status page incidents (Aug–Oct 2026): "Search is down" (Aug 1); "API, Search, and 1 other service are down" (Aug 31–Sep 1); same title (Sep 14); "API and Version API are down" (Sep 26); "API and Version API are down" (Oct 3); "API is down" (Oct 13–14, resolved 2:17am UTC). None names Hosting; the "1 other service" is unidentified — [status.modrinth.com/incidents](https://status.modrinth.com/incidents)
- Third-party monitor: 5 Modrinth outages since Feb 17, 2026 totalling ~17 h, largest Feb 26, 2026 (API and search, 12 h 26 m); covers the website/API, not hosting nodes — [pingoru.io outage history](https://pingoru.io/providers/modrinth/outage-history)
- Panel resilience fix: "Fixed the panel constantly reconnecting when the Hosting API was unavailable" (Sep 7, 2026) — [Modrinth changelog](https://modrinth.com/news/changelog)
- Operator history: beta launched Nov 3, 2024 "in partnership with Pyro", who ran the physical machines **(possibly stale)** — [Modrinth Servers beta](https://modrinth.com/news/article/modrinth-servers-beta/); on **Mar 13, 2025** Modrinth announced Servers is "now fully operated in-house by the Modrinth Team", citing growth, deeper integration, and avoiding "running out of server stock", with a promised zero-downtime migration — [A new chapter for Modrinth Servers](https://modrinth.com/news/article/a-new-chapter-for-modrinth-servers/)

### Inferences
- The recurring 2026 complaint pattern is **support latency and provisioning/stock**, not raw performance; several reviewers praise the panel and hardware. For a scheduled kids' session, the risk is a server stuck "installing" or offline with support hours away, so build the server days ahead and keep a downloaded backup.
- The negative Trustpilot skew is partly structural (no invited reviews; angry customers self-select), but the May and Sep 2026 reports of repeated multi-hour outages are recent enough to matter.
- Because Modrinth's status page tracks only platform services, hosting outages are invisible publicly; there is no way to audit hosting uptime before buying.

### Gaps
- No Reddit/r/admincraft threads could be read (crawler blocked); community consensus beyond Trustpilot and review sites is unknown.
- No hosting-specific uptime statistics or incident history from Modrinth.
- No published support hours.
