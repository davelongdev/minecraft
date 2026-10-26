# Kid-friendly, educationally gated Bed Wars for Game Forge

Research pass 2026-10-26, about 17 searches and fetches. The web results were thin on Bed Wars specifics. The Hypixel wiki pages returned 402 or bot-block errors and the Connected Camps write-up failed TLS, so many Bed Wars mechanics below come from search snippets only. Evidence labels used throughout: **[research]** = peer-reviewed or a meta-analysis; **[reporting]** = journalism or official documents; **[wiki/guide]** = a community wiki or guide site; **[opinion]** = designer, forum, or vendor opinion.

## 1. Why Bed Wars is popular with kids, and what frustrates them

### Takeaway
Bed Wars is huge on both Roblox and Hypixel. Its core loop (protect your bed, respawn while it stands, final death once it's gone) gives an early "safety net" phase and a dramatic late phase. The standard frustrations are matching new players against veterans ("sweats"), long games, and the wait after elimination. I found no reliable age-demographic data.

### Cited Findings
- Roblox BedWars: about 11.16 billion lifetime visits, about 4.4 million favourites, and a snapshot of about 18,858 concurrent players (third-party tracker; estimated monthly revenue of about $111.6k at "0.58 confidence") [wiki/guide] — [RoWatcher](https://rowatcher.com/games/2619619496/bedwars)
- Roblox platform scale: about 68 million average monthly active users, and figures near 130 million monthly over the past year (third-party, not BedWars-specific) [wiki/guide] — [Udonis](https://blog.udonis.co/mobile-marketing/mobile-games/roblox-player-count)
- Roblox BedWars Classic mode: last player or team standing wins, and "the only way to permanently kill an opponent is by destroying their Beds" [wiki/guide] — [Sportskeeda Classic guide](https://sportskeeda.com/roblox-news/bedwars-classic-mode-guide)
- Roblox BedWars has Solos, Doubles, Squads, Duels, and 30v30 modes [wiki/guide] — [ProGameGuides](https://progameguides.com/guides/all-maps-in-roblox-bedwars/). It also has a capture-the-flag mode with two teams of up to 12 [wiki/guide] — [Sportskeeda CTF guide](https://www.sportskeeda.com/roblox-news/bedwars-ctf-guide). And it has more than 100 kits [wiki/guide] — [Bloxodes](https://bloxodes.com/wiki/bedwars)
- Roblox BedWars Ranked requires an account at least 7 days old and level 10 or higher, with tiers Bronze to Nightmare. This is a gate that keeps new players out of the competitive queue [wiki/guide] — [Sportskeeda Ranked guide](https://www.sportskeeda.com/roblox-news/roblox-bedwars-ranked-guide)
- Hypixel Bed Wars core modes: Solo, Doubles, 3v3v3v3, and 4v4v4v4, plus a separate 4v4. "Dreams" variants rotate weekly (Rush, Ultimate, 40v40 Castle, Voidless, Lucky Blocks, Armed, Swap, One Block; the lists disagree between wiki mirrors) [wiki/guide] — [Hypixel Fandom wiki](https://hypixel.fandom.com/wiki/Bed_Wars), [BreezeWiki mirror](https://breezewiki.discard.no/hypixel/wiki/Bed_Wars)
- Hypixel's event order: alternating diamond and emerald generator upgrades up to tier III, then automatic destruction of all remaining beds, then sudden death with dragons. Diamonds run at 30 s at tier I and emeralds at 65 s (snippet only; exact minute marks unverified) [wiki/guide] — [Hypixel Fandom wiki](https://hypixel.fandom.com/wiki/Bed_Wars)
- Typical plugin default phase timings: Diamond II 6 min, Emerald II 6 min, Diamond III 6 min, Emerald III 6 min, Bed Break 10 min, Game End 10 min, so about 44 min worst case [wiki/guide] — [CurseForge Bedwars Minigame](https://www.curseforge.com/minecraft/bukkit-plugins/bedwars-minigame). Another plugin upgrades diamonds at 300/600/900 s and emeralds at 360/720/1080 s [wiki/guide] — [Modrinth l-bedwars](https://modrinth.com/plugin/l-bedwars)
- Skill-gap complaint: competitor servers advertise MMR matchmaking because "traditional Bedwars servers constantly match new players against experienced sweats" (a sales pitch) [opinion] — [BuiltByBit HexaBeds thread](https://builtbybit.com/threads/bedwars-hexabeds-investment.737857/)
- Forum advice tells new players to practise bridging and PvP in other modes (Skywars) first and to watch for high-rank players in the lobby [opinion] — [Pika Network forum](https://pika-network.net/goto/post?id=744782)

### Inferences
- Bed Wars already has a built-in "protection phase" (you respawn while your bed stands), which suits beginners. The pain arrives when a skilled rusher breaks a bed in minute 2, collapsing that phase for the weakest team.
- The usual 30–45+ min game is too long for a studio session. The phase clock is the obvious lever: compress the generator and bed-break timers.
- Both big platforms use gates (Ranked level and account age) or matchmaking to protect newcomers. In a 10–20 kid studio with no matchmaking pool, the equivalent is teacher team balancing and handicaps.

### Gaps
- I found no reliable age demographics for Roblox BedWars or Hypixel Bed Wars. Roblox's investor reports give platform-wide age splits, but those weren't retrieved.
- I found no Hypixel or Easy Games official statement on new-player experience or toxicity, and nothing citable on spawn camping or griefing frequency.

## 2. Variants suited to classrooms and young players

### Takeaway
I found no published classroom Bed Wars ruleset from Minecraft Education, Connected Camps, or clubs. The existing variant evidence is the Dreams and Rush family (faster) and plugin timer configs (shorter). Minecraft Education offers PvP toggles and teacher controls, not a PvP lesson. Most kid-friendly rules have to be designed.

### Cited Findings
- No official Minecraft Education PvP lesson or minigame was found. Classroom Settings (host or Teacher permission) can switch PvP damage off, and the Classroom Mode companion app lets teachers teleport students, pause the game, monitor chat, and change rules. Multiplayer supports up to 30 students [reporting / wiki/guide] — [Minecraft Edu support community](https://edusupport.minecraft.net/hc/en-us/community/posts/360072426991-Simplify-Player-Permissions-Settings), [Edu community: Add More Teacher Controls](https://educommunity.minecraft.net/hc/en-us/community/posts/360072477992), [Educator Toolbox docs](https://educator-tools.readthedocs.io/en/latest/Educator-Toolbox/)
- Outschool runs paid "Minecraft Battle Mobs and PvP" classes mixing building with PvP/PvE on Education Edition (no published rules retrieved) [reporting] — [Outschool](https://outschool.com/classes/minecraft-battle-mobs-and-pvp-p09Gf1Pq)
- Connected Camps: Kid Club for ages 8–13 is a moderated community and ConnectedCraft covers 14–17. Counselors are background-checked and trained on safe online practice [reporting] — [THE Journal 2020](https://thejournal.com/articles/2020/05/21/students-get-online-minecraft-camp-opportunity.aspx). Instructor-moderated, with bullying and offensive language banned (secondhand) [opinion] — [Confessions of a Homeschooler](https://www.confessionsofahomeschooler.com/?p=26797). Katie Salen's essay "Can Minecraft Help Raise a Generation of Good Gamers?" is the relevant piece, but it couldn't be fetched — [UCI Informatics](https://www.informatics.uci.edu/?p=4570)
- Community PvP etiquette norms: don't interrupt 1v1s, don't snipe someone who just won a fight [opinion] — [Sportskeeda](https://www.sportskeeda.com/minecraft/unwritten-rules-minecraft-pvp)
- Hypixel's Rush, Voidless, Lucky Blocks, Armed, and One Block Dreams variants show the genre tolerates big rule changes and short-game variants [wiki/guide] — [Hypixel Fandom wiki](https://hypixel.fandom.com/wiki/Bed_Wars)

### Inferences (design proposals, not evidence)
- **Length:** compress the phase clock so the full game ends in 12–15 min. For example, generator upgrades every 2 min, auto bed-break at about 9 min, sudden death and a hard end at 12–15 min with a tiebreak on beds left, then finals, then kills.
- **Bed shield / protection timer:** beds unbreakable for the first 3–4 min (a glass or barrier dome, or a cancel-break check) so no team loses in minute 2; announce "shields down" with a sound and title.
- **Limited elimination:** after the bed falls, players still respawn but with a longer timer (10 s → 20 s), or get N "final lives" before spectating. Or score by points (beds broken, objectives) instead of last team standing.
- **No TNT, fireballs, or griefing:** the hub already sets `tnt_explodes` and `mob_griefing` false. Drop fireballs and TNT from the shop, block breaking limited to player-placed blocks (classic Bed Wars convention), no lava or water buckets.
- **Fairness:** teacher-picked or snake-drafted teams; a catch-up mechanic (the trailing team's generators run faster, or a free item when their bed falls); fixed kits instead of an open shop for the youngest groups.
- **Cooperative option:** a PvE "defend your beds from mobs" mode for groups or kids who don't want PvP, which matches the Newburgh Creates tabletop framing (co-op board games).
- **Map:** 2–4 small islands close together, with short bridges pre-built or limited to reduce the bridging skill gap (bridging is a known skill wall per the forum advice).

### Gaps
- I found no Roblox BedWars "bed shield" mechanic or kid-specific feature. Couldn't confirm.
- I found no published camp or club Bed Wars rules (Connected Camps, CoderSchool, and others).

## 3. Spectator engagement for eliminated kids

### Takeaway
Game-design writing agrees that waiting time is the main cost of player elimination. Spectating helps if the game is fun to watch, but the better fixes are short games, a choice of what to do next, and a way back in. I found no child-specific research.

### Cited Findings
- "One of the most obvious potential issues with player elimination is the time eliminated players have to wait for the game to end." Keep that wait short [opinion] — [Tabletop Games Blog 2022](https://tabletopgamesblog.com/2022/09/13/slow-death-player-elimination-in-board-games-topic-discussion)
- Elimination has fallen out of favour because eliminated players sit out and game length becomes erratic. Knocking friends out also feels bad for the knocker [opinion] — [League of Game Makers](https://www.leagueofgamemakers.com/game-elements-elimination/)
- Design pattern: let eliminated players continue following the game as spectators [opinion] — [Game design patterns: Spectators](https://math.vu.nl/~eliens/demo/pattern-spectators.html), [Early Elimination](https://math.vu.nl/~eliens/demo/pattern-earlyelimination.html)
- Give eliminated players the choice to spectate or leave (a Board Game Arena feature request citing existing games) [opinion] — [BGA #30375](https://ca.boardgamearena.com/bug?id=30375)
- A return-with-a-new-character option keeps players in the game while the loss still stings [opinion] — [There Will Be Games: Slow Death](https://therewillbe.games/articles-essays/9111-slow-death-player-elimination-in-board-games)

### Inferences
- In Minecraft: spectator mode with team-coloured glowing; a "ghost helper" role (eliminated players can drop one resource to their team every 60 s, or ring an alarm); a side mini-game in the stands (parkour or a target range that earns a cheer token for their team); a prediction vote before sudden death (no stakes, or tiny cosmetic stakes; avoid "betting" framing for kids).
- PvP Arena's existing stands (Resistance V, back to stands on death) are a ready pattern to reuse.

### Gaps
- I found no studies of eliminated-player behaviour among children in video games.

## 4. Gating fun games behind learning: rewards, currencies, unlocks

### Takeaway
The evidence is mixed but consistent on a few points. Expected, tangible, contingent rewards tend to undermine intrinsic motivation for tasks kids already enjoy (Deci, Koestner & Ryan 1999; contested by Cameron & Pierce). Gamification overall shows small positive effects (Sailer & Homner 2020), but leaderboards and badges can backfire (Hanus & Fox 2015), and levels seem to drive more of the effect than points or badges. Commercial edtech currencies (Prodigy) drew a formal complaint for pushing rewards over learning. The safest gate is informational ("you've learned the commands you need for this game") rather than controlling ("pay 50 coins").

### Cited Findings
- Deci, Koestner & Ryan (1999), *Psychological Bulletin* 125:627–668: a meta-analysis concluding that tangible rewards have a substantial undermining effect on intrinsic motivation, supporting cognitive evaluation theory [research] — [Behavioral Economics mini-encyclopedia](https://www.behavioraleconomics.com/resources/mini-encyclopedia-of-be/overjustification-effect). Per a secondary source, it covered 128 experiments, found expected tangible rewards at about d = −0.40, and verbal praise at about d = +0.31 (unverified against the paper) [opinion summarising research] — [Yu-kai Chou blog](https://yukaichou.com/?p=45914)
- Contested: Cameron & Pierce (1994) and later Cameron, Banko & Pierce (2001) found the undermining effect minimal and limited to specific conditions. The debate continues [research] — [Cameron, Banko & Pierce (Springer)](https://link.springer.com/doi/10.1007/BF03392017), [Deci, Koestner & Ryan 2001, Review of Educational Research](https://journals.sagepub.com/doi/10.3102/00346543071001001), [Ewha "myth continues" record](https://scholarhub.vn/publication/:slug/9460423c-1ed9-4760-995d-5dd57e6628aa)
- A replication-crisis overview of the overjustification effect warns that the evidence is less robust than its reputation [opinion] — [Atticus Li](https://atticusli.com/replication-crisis/overjustification-effect/)
- Sailer & Homner (2020), *Educational Psychology Review* 32:77–112: small significant gamification effects on cognitive (g = .49, k = 19, N = 1686), motivational (g = .36, k = 16, N = 2246), and behavioral outcomes (g = .25, k = 9, N = 951). Only the cognitive effect was stable among high-rigour studies [research] — [Uni Augsburg OPUS](https://opus.bibliothek.uni-augsburg.de/opus4/frontdoor/index/index/docId/109056)
- A programming-education gamification meta-analysis found d = 0.4 overall, "essentially due to the use of levels". Badges, points, avatars, and leaderboards showed no significant effect [research] — [ISCTE repository PDF](https://repositorio.iscte-iul.pt/bitstream/10071/29213/1/article_95533.pdf)
- Hanus & Fox (2015), *Computers & Education* 80:152–161: in a 16-week course (about 80 students), the badges + leaderboard section showed declining motivation, satisfaction, and empowerment versus control, and lower exam scores mediated by lower intrinsic motivation. The authors blame social comparison and loss of autonomy (pre-2020 but foundational; a review notes other longitudinal studies disagree) [research] — [UCLA SMHP PDF summary](https://www.smhp.psych.ucla.edu/pdfdocs/gamil.pdf), [Critical review, ETHE 2017](https://educationaltechnologyjournal.springeropen.com/articles/10.1186/s41239-017-0042-5/tables/13)
- Prodigy (math RPG; about 55 million players claimed in 2023; free for schools, revenue from parent memberships unlocking items): in Feb 2021, the Campaign for a Commercial-Free Childhood (now Fairplay) plus 21 groups filed an FTC complaint. It reported 16 membership ads and only 4 math problems in 19 minutes of play, and classroom inequity ("bejeweled members sail around on a cloud, while non-members literally tromp"). Membership cost $59.88–$107.40 per year. The Woburn, MA district moved Prodigy to "Not Approved" [reporting] — [Axios 2021](https://www.axios.com/2021/02/19/prodigy-math-game-ftc-complaint), [Fairplay complaint PDF](https://fairplayforkids.org/wp-content/uploads/2021/02/Prodigy_Complaint_Feb21.pdf), [Wikipedia: Prodigy Education](https://en.wikipedia.org/wiki/Prodigy_Education), [Markey letter](https://www.markey.senate.gov/download/ftc-prodigy?download=1)
- Code.org Hour of Code: an SDT study of 47 high school and 51 university students found more self-determined motivation during the activities (the certificate wasn't isolated). Completion certificates are a common, low-stakes reward [research / reporting] — [Nikou & Economides PDF](https://www.conta.uom.gr/conta/publications/PDF/HourOfCode%20C.pdf), [RIMSD41 news](https://rimsd41.org/apps/news/article/793843)

### Inferences
- **Frame the gate as readiness, not payment:** "Bed Wars unlocks when you finish Section 1, because you'll use /give-style shop commands there". This is informational feedback (competence, in SDT terms) and less controlling than "spend 100 Forge Coins".
- If Forge Coins exist, use them for cosmetics or optional extras (team banner, victory firework, kit skin), never for power. That avoids the Prodigy-style "members fly, others walk" inequity, which is very visible in a shared studio.
- Prefer levels and unlocks (the one element with evidence) over public leaderboards of coins. Command Forge's existing top-3 medals are fine for a quest leaderboard, but don't add a coin-wealth leaderboard.
- Keep the tutorial worth doing on its own (Habgood & Ainsworth's "intrinsic integration", see Gaps). Bed Wars could reward command knowledge in-game: shop purchases via `/trigger`, a command-block trap upgrade, so learning is the mechanic, not only the ticket.
- Expect undermining risk mainly for kids who already enjoy the tutorial. Make the unlock a surprise or a milestone celebration rather than an announced pay rate, since unexpected rewards weren't the problem condition in DKR 1999 (from general knowledge of the paper; verify).
- Give a teacher override so a kid isn't locked out of the group game on a given day (social exclusion in a 10–20 kid room is a real cost; opinion).

### Gaps
- I couldn't retrieve Habgood & Ainsworth (2011), "Motivating children to learn effectively: exploring the value of intrinsic integration in educational games" (J. Learning Sciences). The claim that integrated learning-plus-mechanic beats extrinsic gating comes from background knowledge only and needs verification.
- No FTC outcome for the Prodigy complaint was found.
- I found no studies of "learn first, then play the fun game" gating specifically, and no Minecraft Education currency or unlock data.
- I didn't verify the DKR 1999 effect sizes or the unexpected-reward finding against the original paper.

## 5. Teacher controls worth having

### Takeaway
Minecraft Education's controls (pause, teleport, chat monitoring, per-rule toggles) show what teachers expect. A forum thread asking for "more teacher controls" suggests even those feel insufficient. For a datapack Bed Wars, the must-haves are round start/stop/pause, team assignment and rebalancing, removing a player from a round, and chat limiting.

### Cited Findings
- Classroom Mode lets teachers teleport students, pause the game, monitor chat, and adjust rules without entering the game [reporting] — [Educator Toolbox docs](https://educator-tools.readthedocs.io/en/latest/Educator-Toolbox/), [Edu support community](https://edusupport.minecraft.net/hc/en-us/community/posts/360072426991-Simplify-Player-Permissions-Settings)
- Educators publicly request more teacher controls in Minecraft Education [opinion] — [Edu community post](https://educommunity.minecraft.net/hc/en-us/community/posts/360072477992)
- Connected Camps relies on live, trained moderators rather than only technical controls [reporting] — [THE Journal 2020](https://thejournal.com/articles/2020/05/21/students-get-online-minecraft-camp-opportunity.aspx)

### Inferences (proposed control set for a datapack)
- `___bw_start` / `___bw_stop` / `___bw_pause` (freeze with Slowness 255 or adventure, pause the phase clock); `___bw_teams` auto-balance (by Command Forge points or a past win record) plus a manual `___bw_move {player,team}`; `___bw_kick {player}` to spectator or the hub; `___bw_shield {minutes}` to extend bed protection live; `___bw_end` with a tiebreak.
- Chat: vanilla has no per-player mute. Options are the server-wide `/gamerule` for chat on 26.x (if one exists; unverified), team-only messaging norms, or a server-side mod. Mostly, an adult in the room is the real control (a LAN studio advantage).
- Keep the teacher functions `___`-prefixed and op-only, matching the existing pack conventions.

### Gaps
- I didn't verify whether vanilla 26.3 has a gamerule or permission to mute player chat.
- I found no camp or club write-ups listing which controls they actually use in PvP rounds.
