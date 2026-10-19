#!/usr/bin/env python3
"""Generate the Little Command Book (internal/give_book + book_<level>).

Run from the pack root:  python3 tools/gen_book.py
The book fills in as quests are completed: every quest adds a note to a page (LEARN below).
Level = quests completed so far (tut_quests: section 1 quest n -> n, section 2 quest n -> 12 + n);
give_book picks book_<level>. The book is first given when quest 2 is completed (internal/complete
re-gives it after every quest); join and the ___book trigger give it only once tut_quests >= 2. Pages are small (about 14 short lines).
"""
import json
import pathlib

ROOT = pathlib.Path(__file__).resolve().parent.parent / "data" / "tut" / "function" / "internal"
FONT = "minecraft:uniform"
S1 = 12  # quests in section 1

# page order and titles
PAGES = [
    ("book", "Little Command Book"),
    ("chat", "Chat"),
    ("commands", "Commands"),
    ("keys", "Handy keys"),
    ("words", "Big words"),
    ("names", "Names and numbers"),
    ("know", "Commands I know"),
    ("cb", "Command blocks"),
    ("boxes", "The three boxes"),
    ("boxes2", "The three boxes (2)"),
    ("redstone", "Redstone signals"),
    ("bknow", "Block commands"),
]
JOIN = {"know": "\n", "bknow": "\n"}  # list pages: one entry per line; the rest get blank lines between notes

# (section, quest number completed, page key, note)
LEARN = [
    (1, 2, "book", "Right-click the book to read your notes. A new note appears after every quest."),
    (1, 1, "chat", "t = open chat.\nEsc = close chat."),
    (1, 2, "chat", "Type words and press Enter: everyone sees them."),
    (1, 4, "chat", "With chat open, you can click things in chat."),
    (1, 5, "commands", "Type / first: it's a command, not chat."),
    (1, 5, "know", "/effect give @s glowing"),
    (1, 6, "words", "CLI = command-line interface. You control a program by typing words, not clicking."),
    (1, 6, "know", "/xp add @s 3 levels"),
    (1, 7, "words", "REPL = Read, Evaluate, Print, Loop. You type, Minecraft reads it, runs it, answers, and waits for more."),
    (1, 7, "know", "/give @s stick"),
    (1, 8, "keys", "Tab = finish my word. Tab again = next choice. Space = take it and keep typing. Enter = take it and run."),
    (1, 8, "know", "/gamemode creative"),
    (1, 9, "keys", "/ then Tab = every command. Scroll with Tab, Shift+Tab, or the arrow keys."),
    (1, 9, "know", "/effect give @s invisibility\n/help <command>"),
    (1, 10, "names", "minecraft:cookie and cookie mean the same thing."),
    (1, 10, "know", "/give @s <item> <count>"),
    (1, 11, "keys", "Up arrow = my last command comes back."),
    (1, 11, "know", "/give @s bread"),
    (1, 12, "names", "X Y Z = east, up, south.\n-X west, -Y down, -Z north."),
    (1, 12, "know", "/tp @s X Y Z"),
    (2, 1, "cb", "A block that runs a command on its own.\n\n/give @s command_block (creative mode only)."),
    (2, 2, "cb", "Right-click to open it. No / in the box.\n\n@p = the nearest player. In a block, @s is the block, so use @p."),
    (2, 2, "boxes", "Right box:\nNeeds Redstone = Runs when it gets a signal.\nAlways Active = Runs right away.\n\nCenter box: leave it on Unconditional."),
    (2, 2, "bknow", "give @p carrot"),
    (2, 3, "redstone", "Button = a short signal. Sneak (shift) to place it on a command block."),
    (2, 4, "boxes2", "Left box:\nImpulse = Runs once per signal.\nChain = Runs right after the block pointing into it.\nRepeat = Runs 20 times a second while active."),
    (2, 4, "names", "~ = right here (the block's own spot)."),
    (2, 4, "bknow", "particle happy_villager ~ ~2 ~ 1 1 1 0 10"),
    (2, 5, "bknow", "random roll 1..6\nrandom roll 1..20 (D20)"),
    (2, 6, "redstone", "Chain: the arrow points to the next block. Set it to Always Active."),
    (2, 6, "bknow", "say <words>"),
    (2, 7, "redstone", "Pressure plate = a signal when stepped on. Hide a command block under it: a trap!"),
    (2, 7, "bknow", "effect give @p levitation 3 1"),
    (2, 8, "bknow", "tp @p X Y Z"),
]
MAX_LEVEL = S1 + 8


def level_of(sec, n):
    return n if sec == 1 else S1 + n


def page(text, **extra):
    d = {"font": FONT, "text": text}
    d.update(extra)
    return d


def book(level):
    pages = []
    if level == 0:
        pages.append(page("Little Command Book\n\nNew information will be recorded here after each quest.\n\nHave fun adventuring and completing quests, young hero!"))
    for key, title in PAGES:
        notes = [note for sec, n, k, note in LEARN if k == key and level_of(sec, n) <= level]
        if notes:
            body = JOIN.get(key, "\n\n").join(notes)
            text = f"{title}\n\n{body}"
            assert len(text) <= 256, f"page {key} too long at level {level}: {len(text)}"
            pages.append(page(text))
    # the "Stuck? [Start this exercise over]" page (trigger tut_btn set 3) was removed 2026-10-18 at Dave's request;
    # TODO.md notes it may come back after a particular quest
    return pages


for old in ROOT.glob("book_*.mcfunction"):
    old.unlink()
for level in range(MAX_LEVEL + 1):
    body = ",".join(json.dumps(p, ensure_ascii=False) for p in book(level))
    (ROOT / f"book_{level}.mcfunction").write_text(
        "# GENERATED by tools/gen_book.py — edit the Python, not this file.\n"
        "clear @s written_book\n"
        f'give @s written_book[written_book_content={{title:"Little Command Book",author:"Command Forge",pages:[{body}]}}]\n')

lines = ["# GENERATED by tools/gen_book.py — edit the Python, not this file.",
         "# The Little Command Book fills in as quests are completed: pick the variant for tut_quests (quests done).",
         "scoreboard players add @s tut_quests 0"]
for level in range(MAX_LEVEL, 0, -1):
    lines.append(f"execute if score @s tut_quests matches {level}.. run return run function tut:internal/book_{level}")
lines.append("function tut:internal/book_0")
(ROOT / "give_book.mcfunction").write_text("\n".join(lines) + "\n")
print(f"wrote give_book + book_0..{MAX_LEVEL} under", ROOT)
