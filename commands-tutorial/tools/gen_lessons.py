#!/usr/bin/env python3
"""Generate the quest text from Python data: dialog screens (what the SHOW QUEST button opens since 2026-10-18) and the older chat part functions (kept, no longer printed).

Run from the pack root:  python3 tools/gen_lessons.py
For each quest it writes s1/eN/part1.mcfunction (.. partK) for chat and the matching
data/tut/dialog/s1/eN/partK.json dialog screens (the QUEST button opens the dialog; see internal/show_part), title.mcfunction (sign text + number of parts), plus s1/done and common/all_done.

Pressing the QUEST button prints part 1, the next press part 2, ... and once all
parts have been shown, further presses print the last part again.

Rules of thumb: a part is at most 3 short lines (chat fades after 10 s), one idea
per quest, the command on its own line.
"""
import json
import pathlib

ROOT = pathlib.Path(__file__).resolve().parent.parent / "data" / "tut" / "function"
FONT = "minecraft:uniform"


def t(text, **style):
    return {"text": text, "font": FONT, **style}


def cmd(text, suggest=None):
    """A command shown in aqua; clicking puts it in the chat box."""
    return {"text": text, "font": FONT, "color": "aqua", "bold": True,
            "click_event": {"action": "suggest_command", "command": suggest or text},
            "hover_event": {"action": "show_text", "value": t("Click to put this in your chat box")}}


def key(text):
    return t(text, color="aqua", bold=True)


def line(*parts, color="white"):
    parts = [p if isinstance(p, dict) else t(p) for p in parts]
    return "tellraw @s " + json.dumps([t("", color=color)] + parts, ensure_ascii=False)


FADE_TIP = line(t("Text fading? Press t to read it again. Esc closes chat.", color="gray", italic=True))
NEXT = t("Then press the NEXT QUEST button.", color="green", bold=True)
CONTINUE = t("Press the NEXT QUEST button to continue.", color="green", bold=True)
BLANK = line("")


def write(rel, lines):
    p = ROOT / rel
    p.parent.mkdir(parents=True, exist_ok=True)
    p.write_text("\n".join(lines) + "\n")


DIALOG_ROOT = ROOT.parent / "dialog"


def write_dialog(rel, data):
    p = DIALOG_ROOT / rel
    p.parent.mkdir(parents=True, exist_ok=True)
    p.write_text(json.dumps(data, indent=2, ensure_ascii=False) + "\n")


def tellraw_components(tellraw_line):
    """Turn a 'tellraw @s [...]' line back into its component list."""
    return json.loads(tellraw_line[len("tellraw @s "):])


def find_suggest(components):
    for c in components:
        ce = c.get("click_event") if isinstance(c, dict) else None
        if ce and ce.get("action") == "suggest_command":
            return ce["command"], c.get("text", "").strip() or ce["command"]
    return None


DIALOG_FONT = "tut:clean"  # Liberation Sans TTF from resourcepacks/no-moon (Dave 2026-10-18: default was blocky); needs the pack
DIALOG_BODY = "#CFE8FF"  # pale blue body text, key words stay yellow


def restyle(c):
    """Chat components -> dialog style: default font, white bold text, yellow highlights."""
    if not isinstance(c, dict):
        return c
    c = dict(c)
    c["font"] = DIALOG_FONT
    c["bold"] = False  # Dave 2026-10-18: no bold in dialogs (blocky/blurry), same as the intro
    if c.get("color") in ("aqua", "green"):
        c["color"] = "yellow"
    elif c.get("color") in (None, "white"):
        c["color"] = DIALOG_BODY
    return c


def dt(text, **style):
    """Dialog text (buttons, titles) in the dialog font."""
    return {"text": text, "font": DIALOG_FONT, **style}


def dialog_part(sec, i, k, n, header, body_lines):
    """Build a multi_action dialog for part k of quest i from the same lines used for chat."""
    # the green closer (CONTINUE / NEXT) goes on its own line in the dialog
    split = []
    for l in body_lines:
        cs = tellraw_components(l)
        if len(cs) > 2 and cs[-1] in (CONTINUE, NEXT):
            split.append("tellraw @s " + json.dumps(cs[:-1], ensure_ascii=False))
            split.append("tellraw @s " + json.dumps([cs[0], cs[-1]], ensure_ascii=False))
        else:
            split.append(l)
    # chat blank lines are not needed in the dialog: every line already gets one blank line after it
    body_lines = [l for l in split if l != BLANK]
    # the quest's name is the first line of the body; the window title is just "Quest N of T" (Dave 2026-10-18)
    comps = [dt(header, color="gold"), {"text": "\n\n"}]
    suggest = None
    for idx, l in enumerate(body_lines):
        cs = tellraw_components(l)
        if idx:
            comps.append({"text": "\n\n"})
        comps.extend(restyle(c) for c in cs)
        suggest = suggest or find_suggest(cs)
    actions = []
    if suggest:
        command, label = suggest
        actions.append({"label": dt("Put " + (label if label.startswith("/") else "the command") + " in my chat box"),
                        "tooltip": dt("Types it for you. You press Enter."),
                        "action": {"type": "minecraft:suggest_command", "command": command}})
    if k < n:
        actions.append({"label": dt(f"Part {k + 1}", color="green"),
                        "action": {"type": "minecraft:show_dialog", "dialog": f"tut:s{sec}/e{i}/part{k + 1}"}})
    if sec == 1 and i == 0:
        # quest 1: no NEXT QUEST post yet. "Try it" just closes the screen; "I did it!" completes the quest
        # (trigger 6 -> internal/try_complete). Stacked in that order, no extra Close button (Dave 2026-10-18).
        actions.append({"label": dt("Try it", color="yellow")})
        actions.append({"label": dt("I did it!", color="green"),
                        "action": {"type": "minecraft:run_command", "command": "trigger tut_btn set 6"}})
    if not actions:
        actions.append({"label": dt("Got it!", color="green")})
    title = f"Quest {i + 1} of {TOTAL}" + (f"  (part {k} of {n})" if n > 1 else "")
    write_dialog(f"s{sec}/e{i}/part{k}.json", {
        "type": "minecraft:multi_action",
        "title": {"text": title, "font": DIALOG_FONT, "color": "gold", "bold": True},
        "external_title": {"text": f"Quest {i + 1}", "font": DIALOG_FONT},
        "pause": False,
        "can_close_with_escape": True,
        "after_action": "close",
        "body": [{"type": "minecraft:plain_message", "width": 320, "contents": {"text": "", "font": DIALOG_FONT, "color": DIALOG_BODY, "extra": comps}}],
        "columns": 1,
        "actions": actions,
        **({} if (sec == 1 and i == 0) else {"exit_action": {"label": dt("Close")}}),
    })


def quest(sec, i, short, header, parts, delay=0):
    """parts: list of line-lists. The sign shows `short` ("|" = line break); chat headers show `header`.
    delay: 0 = the whole part prints at once; N (ticks) = the part prints in blocks N ticks
    apart; "shift" = each block waits for a shift press (sneak), with a gray prompt.
    Blocks: every body line is its own block unless wrapped in a nested list (one block);
    blank lines ride with the block before them; the title, a blank, and the first body
    line always form block 0. Lines are gated on the player's tut_pp score (block index or
    tick), which internal/show_part sets to 0 and internal/print_tick advances; tut_pm is
    1 while a shift-paced part is waiting for a shift press."""
    n = len(parts)
    total = len(SECTIONS[sec])
    for old in (ROOT / f"s{sec}/e{i}").glob("part*.mcfunction"):
        old.unlink()
    for old in (DIALOG_ROOT / f"s{sec}/e{i}").glob("part*.json"):
        old.unlink()
    for k, body in enumerate(parts, start=1):
        head = f"Quest {i + 1} of {total}: {header}" + (f" (part {k} of {n})" if n > 1 else "")
        footer = [BLANK, line(t(f"Press QUEST again for part {k + 1}.", color="gray", italic=True))] if k < n else []
        blocks = [[line(t("━━ " + head + " ━━", color="gold", bold=True)), BLANK]]
        for idx, item in enumerate(body + footer):
            if item == BLANK:
                blocks[-1].append(item)
            elif idx == 0:
                blocks[0].extend(item if isinstance(item, list) else [item])
            else:
                blocks.append(item if isinstance(item, list) else [item])
        paced = delay == "shift"
        out = [f"execute if score @s tut_pp matches 0 run scoreboard players set @s tut_pm {1 if paced else 0}"]
        for gi, block in enumerate(blocks):
            gate = gi if paced else gi * delay
            if paced and gi < len(blocks) - 1:
                block = block + [line(t("Press shift for more ... (chat box open? press Esc first)", color="gray", italic=True))]
            for ln in block:
                out.append(f"execute if score @s tut_pp matches {gate} run {ln}")
        out.append(f"execute if score @s tut_pp matches {gate} run scoreboard players set @s tut_pp -1")
        write(f"s{sec}/e{i}/part{k}.mcfunction", out)
        dialog_part(sec, i, k, n, header, [ln for item in body for ln in (item if isinstance(item, list) else [item])])
    write(f"s{sec}/e{i}/title.mcfunction", [
        f"scoreboard players set @s tut_parts {n}",
        f'function tut:internal/sign_quest {{n:{i + 1},total:{total},title:"{short.split("|")[0]}",title2:"{short.split("|")[1] if "|" in short else ""}"}}',
    ])


CLICK_ME = {"text": "[Click me!]", "font": FONT, "color": "green", "bold": True, "underlined": True,
            "click_event": {"action": "suggest_command", "command": "/give @s apple"},
            "hover_event": {"action": "show_text", "value": t("Click to put a command in your chat box")}}

I_SEE_IT = {"text": "[I see it!]", "font": FONT, "color": "green", "bold": True, "underlined": True,
            "click_event": {"action": "run_command", "command": "trigger tut_btn set 1"},
            "hover_event": {"action": "show_text", "value": t("Click me")}}

DID_IT = {"text": "[I did it!]", "font": FONT, "color": "green", "bold": True, "underlined": True,
          "click_event": {"action": "run_command", "command": "trigger tut_btn set 1"},
          "hover_event": {"action": "show_text", "value": t("Click me")}}

QUESTS = [
    dict(short="t and Esc", header="t and Esc",
         parts=[[
             line("When you press ", key("t"), ", a chat window in the bottom left of the screen opens up."),
             line(""),
             line("When you press ", key("Esc"), ", the box closes, and you're back in the game."),
             line(""),
             line("Click ", key("Try it"), " to close this window and test it out."),
             line(""),
             line("Once you've done it, click ", t("I did it!", color="#55FF55"), " to move to your next quest!"),
         ]]),

    dict(short="Say Hello", header="Say Hello",
         parts=[[
             line("Press ", key("t"), ", type ", key("hello"), ", press ", key("Enter"), ". Your words appear in chat, and all players can read your message."),
             line(""),
             line("Did your words show up in chat? If so, you've completed the quest! ", CONTINUE),
         ]]),

    dict(short="Open the|Book", header="Open the Book",
         parts=[[
             line("You just earned a book! It's the ", key("Little Command Book"), ", and it's in your hotbar at the bottom of the screen."),
             line(""),
             line(key("Your Mission"), " - Open the book. Do you see the 9 inventory boxes at the bottom of the screen? You can select the first one by pressing ", key("1"), " on the keyboard. Then ", key("right-click"), " to open it."),
             line(""),
             line("Done reading? If so, you've completed the quest! ", CONTINUE),
         ]]),

    dict(short="The Chat Box", header="Click in Chat",
         parts=[[
             line("When the chat box is open, your mouse is free, so you can click things in chat."),
             line(""),
             line("Try it: press ", key("t"), " to open the chat box, then click ", CLICK_ME, " and watch the chat box fill in. Then press ", key("Enter"), "."),
             line(""),
             line("Got an apple? If so, you've completed the quest! ", CONTINUE),
         ]]),

    dict(short="The Forward Slash", header="The Forward Slash",
         parts=[[
             line("The ", key("/"), " tells Minecraft: this is a command, not chat. Type this and press Enter:"),
             line(""),
             line("    ", cmd("/effect give @s glowing")),
             line(""),
             line("Are you glowing? If so, you've completed the quest! ", CONTINUE, t("   (click the blue text and it jumps into the chat box)", color="gray")),
         ]]),

    dict(short="CLI", header="CLI", delay="shift",
         parts=[[
             [line(key("CLI = Command Line Interface"), " - you do things by typing commands instead of using a mouse or touchpad."),
              line(""),
              line(key("Interface"), " is just a word for how you interact with something."),
              line(""),
              line("The ", key("Chat Box"), " is a ", key("Command Line"), ", a line where you write commands.")],
             line(""),
             [line(key("Your Mission"), " - Type ", cmd("/xp add @s 3 levels"), " and press Enter."),
              line(""),
              line("Did your green bar jump to 3? If so, you've completed the quest! ", CONTINUE)],
         ]]),

    dict(short="REPL", header="REPL", delay="shift",
         parts=[[
             line(key("REPL = Read, Evaluate, Print, Loop"), " - you type a line, Minecraft reads it, evaluates it (runs it), prints a reply, and loops back for your next line."),
             line(""),
             [line(key("Your Mission"), " - Type ", cmd("/give @s stick"), " and press Enter."),
              line(""),
              line("Watch Minecraft print a reply in chat. That's the Print step."),
              line(""),
              line("Got the stick? If so, you've completed the quest! ", CONTINUE)],
         ]]),

    dict(short="Autocomplete", header="Autocomplete", delay="shift",
         parts=[[
             [line(key("Autocomplete"), " - Minecraft types things out for you."),
              line(""),
              line(key("Tab"), " - Choose from a list of suggestions with ", key("Tab"), "."),
              line(""),
              line(key("Space"), " picks the highlighted word if you want to add more. ", key("Enter"), " picks it and runs the command."),
              line(""),
              line("This is sometimes called ", key("Code Completion"), ", ", key("Tab Completion"), ", or ", key("IntelliSense"), ".")],
             line(""),
             [line(key("Your Mission"), " - Type ", key("/gam"), " and press ", key("Tab"), ". Then a space, then ", key("Tab"), " twice to land on ", key("creative"), ". Press ", key("Enter"), " to select and run it."),
              line(""),
              line("Stuck? ", cmd("/help gamemode"), " shows what a command wants."),
              line(""),
              line("Are you in creative mode now? (Creative lets you fly: double-tap space.) If so, you've completed the quest! ", CONTINUE)],
         ]]),

    dict(short="View All Commands", header="View All Commands", delay="shift",
         parts=[[
             [line("Minecraft has lots of commands. You don't have to remember them - the game can show you the whole list."),
              line(""),
              line(key("/ then Tab"), " - press ", key("t"), ", type ", key("/"), ", then press ", key("Tab"), ". A list of every command pops up."),
              line(""),
              line("You can scroll through the list of commands with ", key("Tab"), " (down), ", key("Shift + Tab"), " (up), or the ", key("Up / Down arrow keys"), ".")],
             line(""),
             [line(key("Your Mission"), " - Open the list and scroll through it. Spot ", key("xp"), ", ", key("gamemode"), ", and ", key("give"), "?"),
              line(""),
              line("Now scroll to ", key("effect"), " and press ", key("space"), " to type it. Finish the line so it says ", cmd("/effect give @s invisibility"), " and press Enter."),
              line(""),
              line("Are you invisible? Your hand should be gone. Press ", key("F5"), " to look at yourself from behind - nothing there! (F5 again to go back.) If so, you've completed the quest! ", CONTINUE),
              line(""),
              line(t("Curious what a command does? /help plus its name tells you.", color="gray"))],
         ]]),

    dict(short="/give", header="/give", delay="shift",
         parts=[[
             [line("Commands can give you things."),
              line(""),
              line("Here is an example - ", cmd("/give @s cookie 10"))],
             line(""),
             [line(key("/give"), " - the main command"),
              line(""),
              line(key("@s"), " - who to give it to - @s is your player"),
              line(""),
              line(key("cookie"), " - which item to give"),
              line(""),
              line(key("10"), " - how many to give (optional - 1 if left blank)")],
             line(""),
             [line(key("Your Mission"), " - Type ", cmd("/give @s cookie 10"), " and press Enter."),
              line(""),
              line("Press Tab after /give @s to see every item name."),
              line(""),
              line("Do you have 10 cookies? If so, you've completed the quest! ", CONTINUE)],
         ]]),

    dict(short="The Up Arrow", header="The Up Arrow",
         parts=[[
             line("Press t, then the ", key("Up arrow"), ". Your last command comes back!"),
             line(""),
             line("Change ", key("cookie"), " to ", key("bread"), ", then Enter."),
             line(""),
             line(key("Hint"), " - you can move left and right on the ", key("command line"), " with the arrow keys."),
             line(""),
             line("Got the bread? If so, you've completed the quest! ", CONTINUE),
         ]]),

    dict(short="Teleport with|Coords", header="Teleport with X Y Z Coordinates",
         parts=[
             [line("Every spot has 3 numbers called ", key("coordinates"), " (", key("coords"), "): ", key("X"), " east (-X west), ", key("Y"), " up (-Y down), ", key("Z"), " south (-Z north)."),
              line(""),
              line("Press ", key("F3"), " to see your own numbers.")],
             [line("See the bridge to the new platform? Find the glass cage there, then type ", cmd("/tp @s ", "/tp @s "), " and the 3 numbers on the sign."),
              line(""),
              line(key("Tab trick"), " - look at any block, type ", cmd("/tp @s ", "/tp @s "), " and press Tab. It types that block's numbers! (It can't see through glass, so use the sign's numbers for the cage.)"),
              line(""),
              line("Made it inside? If so, you've completed the quest! The sign in the cage shows the numbers to get back to your island. ", CONTINUE)],
         ]),
]
TOTAL = len(QUESTS)

# Section 2: command blocks, on island 2. Quest functions run positioned at (px, 100, 1036) = island 2's
# origin + 12 south, so the sign/post offsets are the same as island 1's (see internal/store_args, args.pz).
QUESTS2 = [
    dict(short="Give Yourself a|Command Block", header="Give Yourself a Command Block", delay="shift",
         parts=[[
             # one shift pause, before the mission (nested lists = one block each)
             [line("In Section 1, ", key("you"), " typed the commands. A ", key("command block"), " is a block that runs commands on its own."),
              line(""),
              line("Command blocks only open in ", key("Creative mode"), ".")],
             line(""),
             [line(key("Your Mission"), " - Type ", cmd("/gamemode creative"), " and press Enter. Then type ", cmd("/give @s command_block"), " and press Enter."),
              line(""),
              line("Look in your inventory. Do you see an orange block? That's a command block! If so, you've completed the quest! ", CONTINUE)],
         ]]),

    dict(short="/give +|Command Blocks", header="/give + Command Blocks", delay="shift",
         parts=[[
             [line("Take the command block out of your inventory and place it on the ground. ", key("Right-click"), " it to open it."),
              line(""),
              line("The big box at the top is where the command goes. ", key("No slash needed"), " - the block already knows it's a command."),
              line(""),
              line("One catch: ", key("@s"), " means whoever runs the command. In a block, that's the block! Use ", key("@p"), " instead - it means the ", key("nearest player"), ", and that's you.")],
             line(""),
             [line(key("Your Mission"), " - Open the block and type ", key("give @p carrot"), " in the box. You should see three boxes side by side right above the ", key("Done"), " and ", key("Cancel"), " boxes at the bottom."),
              line(""),
              line("These three boxes set options for how command blocks work. Change the box all the way to the right to say ", key("Always Active"), " instead of ", key("Needs Redstone"), ". Leave the other ones (the left box should say ", key("Impulse"), ", and the center box should say ", key("Unconditional"), "). Then click ", key("Done"), "."),
              line(""),
              line("Do you have a carrot in your inventory? If so, you've completed the quest! ", CONTINUE)],
         ]]),

    dict(short="Press a|Button", header="Press a Button", delay="shift",
         parts=[[
             [line(key("Always Active"), " ran your command once, the moment you clicked ", key("Done"), ". To run a command at a different time, a command block needs a signal. In Minecraft, ", key("redstone"), " creates the needed signal."),
              line(""),
              line("One way to create the redstone signal is using a ", key("button"), ", which sends out a short burst of redstone energy that can trigger a command block.")],
             line(""),
             [line(key("Your Mission"), " - Type ", cmd("/give @s stone_button"), " and press Enter (any button would work). Open your command block, change the command to ", key("give @p golden_apple"), ", and set the box on the right in the row of three boxes back to ", key("Needs Redstone"), " (in the last quest we changed it to ", key("Always Active"), "). Click ", key("Done"), ". Now put the button on the command block and press it."),
              line(""),
              line(key("Hint"), " - You have to sneak (hold shift) while placing the button."),
              line(""),
              line("Do you get a golden apple every time you press the button? If so, you've completed the quest! ", CONTINUE)],
         ]]),

    dict(short="Repeat", header="Repeat", delay="shift",
         parts=[[
             [line("See the ", key("blue block"), " in the floor, just ahead? From now on, build on it so the quests can check your work."),
              line(""),
              line("Remember the three boxes lined up next to each other in the command block menu? We looked at the one all the way on the right earlier. Now we're going to look at the one on the left. This one has three options:"),
              line(""),
              line("    ", key("Impulse"), " - runs the command once, each time it gets a signal."),
              line("    ", key("Chain"), " - runs right after another command block (more on this later)."),
              line("    ", key("Repeat"), " - runs the command 20 times every second, as long as it's active.")],
             line(""),
             [line(key("Your Mission"), " - Put a new command block on the blue block. Give it the command ", key("particle happy_villager ~ ~2 ~ 1 1 1 0 10"), ". Click ", key("Impulse"), " until it says ", key("Repeat"), ", set the right box to ", key("Always Active"), ", and click ", key("Done"), "."),
              line(""),
              line("Are you seeing green sparkles? (The ", key("~"), " means \"right here\" - the block's own spot.) If so, you've completed the quest! ", CONTINUE)],
         ]]),

    dict(short="Roll the|Dice", header="Roll the Dice", delay="shift",
         parts=[[
             [line("Board games need dice. Minecraft has them built in: ", key("random roll 1..6"), " rolls a six-sided die and shows the result to everyone.")],
             line(""),
             [line(key("Your Mission"), " - Break the sparkle block and put a new command block on the blue block. Give it the command ", key("random roll 1..6"), " and leave the boxes on ", key("Impulse"), " and ", key("Needs Redstone"), ". Put a button on it and press it a few times."),
              line(""),
              line("Do you see a dice roll in chat each time you press the button? (Try ", key("random roll 1..20"), " for a D20.) If so, you've completed the quest! ", CONTINUE)],
         ]]),

    dict(short="Chain", header="Chain", delay="shift",
         parts=[[
             [line("A ", key("Chain"), " command block runs right after the block pointing into it. That's how one press does two things."),
              line(""),
              line("Look at the ", key("arrow"), " on a command block - it points the way the chain goes.")],
             line(""),
             [line(key("Your Mission"), " - Open the command block on the blue block (put a new one there if it's gone) and change its command to ", key("give @p cake"), ". Then put a second command block right where its arrow points. Set the new block's left box to ", key("Chain"), " and right box to ", key("Always Active"), ", and give it the command ", key("say Enjoy your cake!"), ". Press the button."),
              line(""),
              line("Do you get a cake and a nice message in chat each time you press the button? If so, you've completed the quest! ", CONTINUE)],
         ]]),

    dict(short="Pressure|Plate Trap", header="Pressure Plate Trap", delay="shift",
         parts=[[
             [line("A ", key("pressure plate"), " sends a redstone signal when you step on it. A command block hidden under one is a ", key("trap"), ".")],
             line(""),
             [line(key("Your Mission"), " - Find the ", key("red block"), " in the floor. Break it and put a command block in the hole with the command ", key("effect give @p levitation 3 1"), " (", key("Impulse"), ", ", key("Needs Redstone"), "). Type ", cmd("/give @s stone_pressure_plate"), ", put the plate on top, and walk onto it."),
              line(""),
              line("Did you float up when you stepped on the plate? (Try ", key("slow_falling"), ", ", key("speed"), ", or ", key("jump_boost"), " instead.) If so, you've completed the quest! ", CONTINUE)],
         ]]),

    dict(short="Teleporter", header="Teleporter", delay="shift",
         parts=[[
             [line("Section 1 ended with ", key("/tp"), ". Now a block does it for you - that's how a game sends players to the next level."),
              line(""),
              line("Across the island is a ", key("gold pad"), ". The ", key("TARGET"), " sign next to the blue block shows the pad's coordinates.")],
             line(""),
             [line(key("Your Mission"), " - Put a new command block with a button on the blue block. Its command: ", key("tp @p"), " followed by the three numbers on the TARGET sign, with spaces between them. Press the button."),
              line(""),
              line("Did you land on the gold pad? That's a teleporter - every adventure map has one. If so, you've completed the quest! Walk back to the buttons. ", CONTINUE)],
         ]]),
]

SECTIONS = {1: QUESTS, 2: QUESTS2}

for sec, quests in SECTIONS.items():
    for i, q in enumerate(quests):
        quest(sec, i, q["short"], q["header"], q["parts"], q.get("delay", 0))

write("s1/done.mcfunction", [
    line(t("━━ Section 1 done! ━━", color="gold", bold=True)),
    line("You can open chat with t, finish words with Tab, repeat with Up, and use effect, xp, gamemode, give, and tp."),
    line("Section 2 is next: command blocks!"),
])
write("s2/done.mcfunction", [
    line(t("━━ Section 2 done! ━━", color="gold", bold=True)),
    line("You can make blocks run commands with buttons and pressure plates, repeat them, chain them, roll dice, and teleport. That's the toolkit for building a game!"),
    line("More is coming soon. Free play for now!"),
])
write("common/all_done.mcfunction", [
    line(t("━━ That's all for now ━━", color="gold", bold=True)),
    line("You finished everything built so far. Free play! Try /give and /tp on your island."),
    line(t("Teachers: /function tut:___reset_player starts a player over.", color="gray")),
])

print("wrote", {sec: len(q) for sec, q in SECTIONS.items()}, "quests under", ROOT)
