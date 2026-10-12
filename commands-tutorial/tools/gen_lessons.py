#!/usr/bin/env python3
"""Generate the chat-only quest text from Python data.

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


DIALOG_FONT = "minecraft:default"  # bolder than uniform: easier to read over the blurred game view


def restyle(c):
    """Chat components -> dialog style: default font, white bold text, yellow highlights."""
    if not isinstance(c, dict):
        return c
    c = dict(c)
    c["font"] = DIALOG_FONT
    c["bold"] = True
    if c.get("color") in ("aqua", "green"):
        c["color"] = "yellow"
    elif c.get("color") in (None, "white"):
        c["color"] = "white"
    return c


def dialog_part(i, k, n, header, body_lines):
    """Build a multi_action dialog for part k of quest i from the same lines used for chat."""
    comps = []
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
        actions.append({"label": t("Put " + (label if label.startswith("/") else "the command") + " in my chat box"),
                        "tooltip": t("Types it for you. You press Enter."),
                        "action": {"type": "minecraft:suggest_command", "command": command}})
    if k < n:
        actions.append({"label": t(f"Part {k + 1}", color="green"),
                        "action": {"type": "minecraft:show_dialog", "dialog": f"tut:s1/e{i}/part{k + 1}"}})
    if not actions:
        actions.append({"label": t("Got it!", color="green")})
    title = f"Quest {i + 1} of {TOTAL}: {header}" + (f"  (part {k} of {n})" if n > 1 else "")
    write_dialog(f"s1/e{i}/part{k}.json", {
        "type": "minecraft:multi_action",
        "title": {"text": title, "font": DIALOG_FONT, "color": "gold", "bold": True},
        "external_title": {"text": f"Quest {i + 1}", "font": DIALOG_FONT},
        "pause": False,
        "can_close_with_escape": True,
        "after_action": "close",
        "body": [{"type": "minecraft:plain_message", "width": 320, "contents": {"text": "", "font": DIALOG_FONT, "extra": comps}}],
        "columns": 1,
        "actions": actions,
        "exit_action": {"label": t("Close")},
    })


def quest(i, short, header, parts):
    """parts: list of line-lists. The sign shows `short`; chat headers show `header`."""
    n = len(parts)
    for old in (ROOT / f"s1/e{i}").glob("part*.mcfunction"):
        old.unlink()
    for old in (DIALOG_ROOT / f"s1/e{i}").glob("part*.json"):
        old.unlink()
    for k, body in enumerate(parts, start=1):
        head = f"Quest {i + 1} of {TOTAL}: {header}" + (f" (part {k} of {n})" if n > 1 else "")
        footer = [line(t(f"Press QUEST again for part {k + 1}.", color="gray", italic=True))] if k < n else []
        write(f"s1/e{i}/part{k}.mcfunction", [line(t("━━ " + head + " ━━", color="gold", bold=True))] + body + footer)
        dialog_part(i, k, n, header, body)
    write(f"s1/e{i}/title.mcfunction", [
        f"scoreboard players set @s tut_parts {n}",
        f'function tut:internal/sign_quest {{n:{i + 1},total:{TOTAL},title:"{short}"}}',
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
    dict(short="t and Esc", header="Open and close the chat",
         parts=[[
             line("Press ", key("t"), ". A box opens at the bottom of the screen. That's the chat box."),
             line("Press ", key("Esc"), ". The box closes and you're back in the game."),
             line("Open and close it a few times. ", NEXT),
         ]]),

    dict(short="Say hello", header="Say hello",
         parts=[[
             line("Press ", key("t"), ", type ", key("hello"), ", press ", key("Enter"), ". Your words appear in chat, and all players can read your message."),
             line(NEXT),
         ]]),

    dict(short="The chat box", header="Click in chat",
         parts=[[
             line("When the chat box is open, your mouse is free, so you can click things in chat."),
             line("Try it: press ", key("t"), " to open the chat box, then click ", CLICK_ME, " and watch the chat box fill in. Then press ", key("Enter"), "."),
             line("Got an apple? ", NEXT),
         ]]),

    dict(short="The slash", header="Every command starts with /",
         parts=[[
             line("The ", key("/"), " tells Minecraft: this is a command, not chat. Type this and press Enter:"),
             line("    ", cmd("/effect give @s glowing")),
             line("You glow! ", NEXT, t("   (click the blue text and it jumps into the chat box)", color="gray")),
         ]]),

    dict(short="Big word: CLI", header="Big word: CLI",
         parts=[[
             line(key("CLI"), " = command-line interface. You do things by typing commands instead of using a mouse or touchpad."),
             line("The chat box is your CLI. Type ", cmd("/xp add @s 3 levels"), " and press Enter."),
             line("Your green bar jumps to 3. ", NEXT),
         ]]),

    dict(short="Big word: REPL", header="Big word: REPL",
         parts=[[
             line(key("REPL"), " = Read, Evaluate, Print, Loop. You type a line. Minecraft reads it, evaluates it (runs it), prints a reply, and loops back for your next line."),
             line("Watch the Print step: type ", cmd("/give @s stick"), " and press Enter. Watch Minecraft print a reply in chat."),
             line("Got the stick? ", NEXT),
         ]]),

    dict(short="Tab + help", header="Tab finishes your words",
         parts=[[
             line("Type ", key("/gam"), " and press ", key("Tab"), ". Then a space, then Tab again to pick ", key("creative"), ". Enter."),
             line("Stuck? ", cmd("/help gamemode"), " shows what a command wants."),
             line("Goal: ", cmd("/gamemode creative"), "  Creative lets you fly: double-tap Space. ", NEXT),
         ]]),

    dict(short="Snack time", header="Snack time",
         parts=[[
             line("Commands can give you things:   ", cmd("/give @s cookie 10")),
             line(key("@s"), " means ME.  ", key("10"), " is how many.  Press Tab after /give @s to see every item name. ", NEXT),
         ]]),

    dict(short="The Up arrow", header="The Up arrow",
         parts=[[
             line("Press t, then the ", key("Up arrow"), ". Your last command comes back!"),
             line("Change ", key("cookie"), " to ", key("bread"), ", then Enter. ", NEXT),
         ]]),

    dict(short="Teleport X Y Z", header="Teleport with X Y Z",
         parts=[
             [line("Every spot has 3 numbers: ", key("X"), " east, ", key("Y"), " up, ", key("Z"), " south."),
              line("Press ", key("F3"), " to see your own numbers.")],
             [line("See the glass cage? Type ", cmd("/tp @s ", "/tp @s "), " and the 3 numbers on the sign."),
              line("Tab trick: look at a block, type /tp @s and press Tab. It types that block's numbers! ", NEXT)],
         ]),
]
TOTAL = len(QUESTS)

for i, q in enumerate(QUESTS):
    quest(i, q["short"], q["header"], q["parts"])

write("s1/done.mcfunction", [
    line(t("━━ Section 1 done! ━━", color="gold", bold=True)),
    line("You can open chat with t, finish words with Tab, repeat with Up, and use effect, xp, gamemode, give, and tp."),
    line("Section 2 (command blocks) is coming soon!"),
])
write("common/all_done.mcfunction", [
    line(t("━━ That's all for now ━━", color="gold", bold=True)),
    line("You finished everything built so far. Free play! Try /give and /tp on your island."),
    line(t("Teachers: /function tut:___reset_player starts a player over.", color="gray")),
])

print(f"wrote {TOTAL} quests under", ROOT)
