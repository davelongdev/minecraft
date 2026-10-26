# Classic Bed Wars rules and balance (Hypixel-style)

Source situation (read first): the **official Hypixel Wiki (wiki.hypixel.net) was closed by Hypixel on 2026-07-21**; its URLs now redirect to the closure announcement, with no official replacement named — [Hypixel announcement](https://hypixel.net/threads/end-of-the-official-hypixel-wiki-july-2026.6112020/). The community Fandom wiki (hypixel.fandom.com) and NamuWiki refused automated fetches (HTTP 402/403), and the Wayback Machine was rate-limited, so these notes rest mainly on **Hypixel forum guides (2017-2025)**, which disagree with each other in places. Every conflict is flagged. Numbers marked "older" may have changed; nothing here was checked in game.

## Core rules: teams, beds, respawn, final kills, win condition, spectating

### Takeaway
Each team defends a bed on its own island; while the bed stands, dead players respawn, and once it's broken, the next death is permanent (a "final kill"). The last team with a living player wins. The exact respawn delay wasn't confirmed by any source I could fetch.

### Cited Findings
- While your bed is alive you can respawn; once it's broken you "will not be able to respawn." — [Hypixel forum guide, 2020](https://hypixel.net/threads/guide-tool-an-updated-guide-on-bedwars.3617022/)
- Castle (Dream mode) is the exception that shows the general rule: each team has 3 beds that must all be destroyed to win. — [Hypixel forum overview, 2025-08-10](https://hypixel.net/threads/hypixel-bedwars-a-brief-overview.5969542/)
- Older guide: "Games last at max: 50 minutes." — [Hypixel forum guide, 2017](https://hypixel.net/threads/guide-bedwars-everything-you-need-to-know.1203017/)

### Inferences
- For a simplified version, the bed-plus-final-death rule is the whole game. Everything else (shop, upgrades) is tuning.

### Gaps
- **Respawn timer:** widely known as 5 seconds (spectator view during the countdown), but I found no fetchable source stating it. Treat as unverified.
- Exact spectating rules after a final death (spectator mode, teleporting to teammates) weren't confirmed by a fetched source.

## Modes: team counts, players per team, islands

### Takeaway
There are four core modes, Solo, Doubles, 3v3v3v3, and 4v4v4v4, and the team count runs 4 to 8 depending on the mode. Prices and upgrade costs differ between Solo/Doubles and 3s/4s.

### Cited Findings
- Core modes: Solo, Doubles, 3v3v3v3, 4v4v4v4. — [Hypixel forum overview, 2025](https://hypixel.net/threads/hypixel-bedwars-a-brief-overview.5969542/)
- "There are 4-8 teams depending on mode." — [Hypixel forum guide, 2017](https://hypixel.net/threads/guide-bedwars-everything-you-need-to-know.1203017/)
- A 2020 guide also lists a "4v4" mode (two teams of four) next to 4s. — [Hypixel forum guide, 2020](https://hypixel.net/threads/guide-tool-an-updated-guide-on-bedwars.3617022/)
- Four diamond islands per map; emerald generators: 4 in Solo/Doubles, 2 in Triples/Fours (older guide). — [Hypixel forum guide, 2017](https://hypixel.net/threads/guide-bedwars-everything-you-need-to-know.1203017/)

### Inferences
- The "4-8 teams" range fits 8 teams in Solo/Doubles (8 islands) and 4 teams in 3s/4s (4 islands), which is the commonly known layout. Not stated explicitly in the sources I fetched.

### Gaps
- No fetched source states island counts per map explicitly, or the current emerald generator count per mode.

## Resource generators

### Takeaway
Iron and gold come from each team's island forge; diamonds come from four diamond islands and emeralds from the middle. Diamond intervals of 30/24(or 23)/12 s by tier are the most-cited figures; emerald intervals vary by mode and by source. On-ground stacks are capped. I found no sourced iron/gold base rates.

### Cited Findings
- Diamond generator (older guide, "same in every mode"): Tier 1 one every 30 s, Tier 2 every 24 s, Tier 3 every 12 s. — [Hypixel forum guide, 2017](https://hypixel.net/threads/guide-bedwars-everything-you-need-to-know.1203017/)
- Emerald generator (same guide): Solo/Doubles 65 / 50 / 35 s; Triples/Fours 56 / 40 / 28 s. — [same](https://hypixel.net/threads/guide-bedwars-everything-you-need-to-know.1203017/)
- 2021 players' reports: diamonds in Solo/Doubles 30 / 23 / 12 s; emerald Tier 1 about 60 s; another poster's 45/30/15 (diamond) and 60/45/30 (emerald) was self-described as "likely wrong." — [Hypixel forum thread, 2021-06](https://hypixel.net/threads/emerald-and-diamond-generators-speeds-depending-on-their-tier.4316840/)
- Stack caps (2021 players' reports): diamonds cap at 4 in Solo/Doubles and 8 in 3s/4s; emeralds 2 in Solo/Doubles (one poster), "6 or 8" / "above 5" in 3s/4s (unsure). — [same](https://hypixel.net/threads/emerald-and-diamond-generators-speeds-depending-on-their-tier.4316840/)
- Forge upgrade effects: +50% iron and gold, +100% iron and gold, activates emerald spawning at the team forge, +200% iron/gold/emerald. — [Hypixel forum guide, 2017](https://hypixel.net/threads/guide-bedwars-everything-you-need-to-know.1203017/)
- Iron spawns constantly and gold less often, from the island forge; no rates given. — [same](https://hypixel.net/threads/guide-bedwars-everything-you-need-to-know.1203017/)

### Inferences
- The diamond rhythm (30 → ~24 → 12 s) is consistent across sources. Emerald intervals around 55-65 s at Tier 1 are the safest range.
- For a simplified pack, scoreboard-driven item spawns at fixed intervals plus a per-generator cap are easy to do. Exact Hypixel rates matter less than "iron fast, gold slow, diamond/emerald contested."

### Gaps
- No fetched source gives iron/gold base intervals or island-forge caps (commonly cited as roughly 1 iron per second with an iron cap around 48 and gold cap around 12, unverified).
- Current (2025-2026) generator rates aren't confirmed anywhere fetchable.

## Item shop: categories, items, prices

### Takeaway
The shop has seven categories (Blocks, Melee, Armor, Tools, Ranged, Potions, Utility). Iron buys basic blocks and gear, gold buys mid-tier gear, and emeralds buy top gear. Several prices differ between Solo/Doubles and 3s/4s, and some changed between 2017 and 2020-21.

### Cited Findings
Shop categories: Blocks, Armor, Tools, Weapons, Bows, Potions, Utilities — [Hypixel forum guide, 2020](https://hypixel.net/threads/guide-tool-an-updated-guide-on-bedwars.3617022/).

Prices below are from the two 2020-21 guides, [Dec 2020](https://hypixel.net/threads/in-depth-bedwars-guide-for-beginners.3658536/) ("2020") and [Aug 2021](https://hypixel.net/threads/guide-bedwars-item-prices-uses.4506178/) ("2021"), with the [2017 guide](https://hypixel.net/threads/guide-bedwars-everything-you-need-to-know.1203017/) ("2017") where it differs. "S/D" = Solo/Doubles, "3s/4s" = Threes/Fours.

**Blocks**
- Wool ×16: 4 iron (all three)
- Hardened clay (terracotta): ×16 for 12 iron (2021); "16 iron for 24" (2020). These conflict.
- Glass (blast-proof) ×4: 12 iron (2020) / 11 iron (2021)
- End stone: ×12 for 24 iron (2017, 2020); "24 iron for 16" (2021). These conflict.
- Ladder ×16: 4 iron
- Oak planks ×16: 4 gold
- Obsidian ×4: 4 emeralds (2020 notes 8 blocks fully cover a bed)
- Sandstone ×16 for 12 iron in 2017 (since replaced by clay)

**Melee**
- Wood sword: free, permanent (2021)
- Stone sword 10 iron; iron sword 7 gold
- Diamond sword: 4 emeralds (2017; a 2021 reply also says 4); 2021 post says 3; 2020 says "4 S/D, 3 3s/4s." These conflict.
- Knockback stick: 5 gold (2020, 2021); 10 gold in 2017

**Armor** (permanent, all three sources)
- Chainmail 40 iron, iron 12 gold, diamond 6 emeralds

**Tools** (tiered; 2020/2021 prices)
- Shears: 20 iron, permanent (30 in 2017)
- Pickaxe: wood 10 iron → iron 10 iron → gold 3 gold → diamond 6 gold
- Axe: wood 10 iron → stone 10 iron → iron 3 gold → diamond 6 gold
- Pickaxes and axes drop one tier when you die (e.g. a diamond axe becomes an iron axe) — [2020 guide](https://hypixel.net/threads/in-depth-bedwars-guide-for-beginners.3658536/)

**Ranged**
- Arrows ×8: 2 gold; Bow: 12 gold; Power I bow: 24 gold; Power I + Punch I bow: 6 emeralds

**Potions**
- Speed (45 s): 1 emerald; Jump Boost (45 s; Jump V in 2017): 1 emerald; Invisibility (30 s): 2 emeralds (1 in 2017)

**Utility**
- Golden apple: 3 gold
- Bed Bug (silverfish snowball): 40 iron
- Dream Defender (iron golem): 120 iron (150 in 2017)
- Fireball: 40 iron (50 in 2017)
- TNT: 4 gold S/D, 8 gold 3s/4s (5 gold all modes in 2017)
- Ender pearl: 4 emeralds
- Water bucket: 3 gold S/D, 6 gold 3s/4s (1 emerald in 2017)
- Bridge egg: 2 emeralds S/D, 1 emerald 3s/4s (2020; a later search summary saw "1 in S/D" in one guide)
- Magic milk (immunity to traps): 4 gold
- Sponge: "3 gold for 6 S/D, 6 gold for 6 3s/4s" (2020); 2021 wording is ambiguous
- Pop-up tower: 24 iron (2020, 2021)
- Icefish/Unbreaking items were in the 2017 shop only

### Inferences
- The price ladder (wool 4 iron → end stone 24 iron → obsidian 4 emeralds; stone sword 10 iron → iron 7 gold → diamond 4 emeralds) is the key balance shape to copy. A kids' version can keep 3 tiers per category.

### Gaps
- No 2025-2026 shop list was fetchable. Hypixel's in-game shop is the only authoritative source now that the official wiki is gone.

## Team upgrades and traps (diamond costs)

### Takeaway
Upgrades are bought with diamonds and cost roughly double in 3s/4s. Traps form a queue that triggers one at a time, priced 1, 2, then 4 diamonds. Dragon Buff was reported removed in 2025.

### Cited Findings
Costs from the 2021 guide (S/D vs 3s/4s), matching the 2020 guide except where noted — [2021](https://hypixel.net/threads/guide-bedwars-item-prices-uses.4506178/), [2020](https://hypixel.net/threads/in-depth-bedwars-guide-for-beginners.3658536/):

| Upgrade | S/D | 3s/4s |
|---|---|---|
| Sharpened Swords (Sharpness I) | 4 | 8 |
| Reinforced Armor Prot I/II/III/IV | 2/4/8/16 | 5/10/20/30 |
| Maniac Miner Haste I/II | 2/4 | 4/8 |
| Forge: Iron/Gold/Emerald/Molten | 2/4/6/8 (2021); 2/4/8/16 (2020) | 4/8/12/16 |
| Heal Pool | 1 | 3 |
| Dragon Buff | 5 | 5 |
| Traps 1st/2nd/3rd | 1/2/4 | 1/2/4 |

- The 2020 guide's trap prices are inconsistent (1/2/4 in its rules, 1/2/3 per trap). — [2020](https://hypixel.net/threads/in-depth-bedwars-guide-for-beginners.3658536/)
- Trap effects: It's a Trap = blindness + slowness for 8 s; Counter-Offensive = Speed + Jump for defenders (6 s per one guide, 8 s per another); Alarm = reveals invisible enemies; Miner Fatigue = mining fatigue for 8 s; magic milk counters traps. — [2020 guide A](https://hypixel.net/threads/guide-tool-an-updated-guide-on-bedwars.3617022/), [2020 guide B](https://hypixel.net/threads/in-depth-bedwars-guide-for-beginners.3658536/)
- Heal Pool = regeneration at your base; Dragon Buff = your team gets 2 dragons instead of 1 in the deathmatch. — [2017](https://hypixel.net/threads/guide-bedwars-everything-you-need-to-know.1203017/)
- "Dragon Buff is described as removed" (2025 overview). — [Hypixel forum, 2025](https://hypixel.net/threads/hypixel-bedwars-a-brief-overview.5969542/)

### Inferences
- Traps map neatly onto a datapack: a per-team queue score, base-region check with `execute positioned … if entity`, and `effect give`.

### Gaps
- No fetched source confirms whether Dragon Buff removal is official. Also unconfirmed: current trap costs and the trap queue length (commonly 3).

## Timeline: tier-ups, bed destruction, sudden death, dragons, game length

### Takeaway
Six-minute steps: diamond II, emerald II, diamond III, emerald III, then all beds destroyed, sudden death with dragons, and a tie if the game runs out. Sources disagree on the first step (5 vs 6 minutes) and on the end times.

### Cited Findings
- 2020 timeline: 5 min Diamond II; 11 min Emerald II; 17 min Diamond III; 23 min Emerald III; 29 min all beds destroyed; 39 min Sudden Death + dragons; ~49 min game ends in a tie (cumulative from stated +6/+10 steps). — [Hypixel forum guide, 2020](https://hypixel.net/threads/guide-tool-an-updated-guide-on-bedwars.3617022/)
- 2017 timeline: Tier 2 at 6 min, Tier 3 at 18 min, beds break 10 min after the last generator upgrade, then a dragon deathmatch, max 50 minutes; internally inconsistent. — [Hypixel forum guide, 2017](https://hypixel.net/threads/guide-bedwars-everything-you-need-to-know.1203017/)
- A forum user claims six-minute intervals with sudden death "at 10 minutes" after; ambiguous. — [Hypixel thread](https://hypixel.net/threads/bedwars-generator-upgrade-delay-times.2095956/)

### Inferences
- Most games end long before the scripted end; for kids' class sessions, a compressed timeline (e.g. beds break at 10-15 min) suits a single lesson better.

### Gaps
- No fetched source gives typical real game length. Also unconfirmed: the current (2025-26) exact schedule.

## Island/map layout, breakable blocks, void, build height

### Takeaway
Islands float over the void, with team islands around four diamond islands and a central emerald island. I found no sourced numbers for island spacing, height limits, or the "only player-placed blocks break" rule, though all are standard.

### Cited Findings
- Four diamond islands per map (one generator each); emeralds in the middle. — [2017 guide](https://hypixel.net/threads/guide-bedwars-everything-you-need-to-know.1203017/)
- Typical bed defence layering: wool first, then wood, then end stone or obsidian. — via search summary of a [Pika Network guide](https://pika-network.net/goto/post?id=1285211) (not fetched directly)
- Voidless (Dream mode) = Rush without the void, which shows that the void is the default. — [2025 overview](https://hypixel.net/threads/hypixel-bedwars-a-brief-overview.5969542/)
- Community "ranked" games bridge to the height limit before fighting (there is a height limit). — [2025 overview](https://hypixel.net/threads/hypixel-bedwars-a-brief-overview.5969542/)

### Gaps
- Unsourced (commonly known, verify before relying on it): only player-placed blocks can be broken (map blocks are protected); falling into the void = death; per-map build height and "no building near generators/spawn" zones; island distances (roughly 30-70 blocks, varies per map).

## What's kept or lost on death

### Takeaway
Armor bought is permanent. Pickaxes and axes are permanent but drop one tier on death. Swords reset to wood. Resources in the inventory go to the killer.

### Cited Findings
- Chainmail, iron, and diamond armor are labelled "permanent." — [2017](https://hypixel.net/threads/guide-bedwars-everything-you-need-to-know.1203017/), [2020](https://hypixel.net/threads/in-depth-bedwars-guide-for-beginners.3658536/)
- Permanent pickaxes/axes drop one tier on death. — [2020](https://hypixel.net/threads/in-depth-bedwars-guide-for-beginners.3658536/)
- Wood sword, wood pickaxe, wood axe, and shears are listed as permanent. — [2021](https://hypixel.net/threads/guide-bedwars-item-prices-uses.4506178/)

### Gaps
- Unsourced: the killer receiving the victim's iron/gold/diamonds/emeralds (void deaths credit the last hitter); swords and blocks being lost. Standard behaviour, but no fetched source states it.

## Notable variants

### Takeaway
Hypixel rotates "Dream" modes weekly: Rush, Ultimate, Castle (40v40, 3 beds), Voidless, Armed (guns), Lucky Blocks, Swappage, and One Block.

### Cited Findings
- Current rotation per the Fandom wiki: Rush v2, Ultimate v2, 40v40 Castle v2, Voidless, Armed, Lucky Blocks v2, Swappage, One Block; a different mode each Thursday afternoon (US Eastern). — via search summary of [Fandom Bed Wars/Dreams](https://hypixel.fandom.com/wiki/Bed_Wars/Dreams) (page itself returned 402)
- Rush: every generator at max tier, a pre-built bed defence, cheaper pearls and bridge eggs. Ultimate: pick one of seven ultimate abilities. Castle: 40 vs 40, 3 beds per team. — via search summary of the same Fandom page
- Rush = premade bed defence + maxed generator; Voidless = Rush without the void; Armed, Ultimate, and Lucky Blocks are also listed. — [2025 overview](https://hypixel.net/threads/hypixel-bedwars-a-brief-overview.5969542/)
- Community "Ranked Bedwars" (unofficial): 4v4 that bridges to the height limit before fighting. Peak of 47,720 concurrent Bed Wars players in 2021. — [2025 overview](https://hypixel.net/threads/hypixel-bedwars-a-brief-overview.5969542/)

### Gaps
- Other servers (BlocksMC, Pika, Minemen) and "Capture the Bed" style variants aren't covered by any source I fetched. Open-source plugins such as [BedWars1058](https://github.com/andrei1058/BedWars1058) copy Hypixel's structure (shop, upgrades, generators) and could serve as a reference config, but I didn't read its defaults.

### Inferences (most important rules for a simplified Game Forge version)
- Keep: bed = respawn (with a short delay), final kills, last team standing, a void, only player-placed blocks breakable, and iron/gold at home with diamonds/emeralds in contested spots.
- Simplify: a 3-tier shop (wool/end stone/obsidian, stone/iron/diamond sword, permanent armor), 2-3 team upgrades (Sharpness, Protection, Forge), one trap, and a short fixed timeline (beds break at about 10-15 min).
- Rush/Voidless show that a pre-built bed defence and maxed generators make a good fast, kid-friendly preset.
