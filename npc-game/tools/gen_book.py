#!/usr/bin/env python3
"""Generate the two instruction books (internal/give_book.mcfunction).

Run from the pack root:  python3 tools/gen_book.py
BOOKS lists each book: the NPC Forge Book (welcome, triggers, command basics, the game) and the original
Little NPC Book (2026-10-17 morning version, kept as a second book for now at Dave's request). Every player gets
both on first join (tick: @a[tag=!npc_book]) and again with /trigger give_new_books, which replaces old copies
(each book carries its own custom_data tag). Pages are small (about 14 short lines in the uniform font).
"""
import json
import pathlib

OUT = pathlib.Path(__file__).resolve().parent.parent / "data" / "npc" / "function" / "internal" / "give_book.mcfunction"
FONT = "minecraft:uniform"
# (title, body) - title becomes the first line of the page. A page holds about 14 short lines.
PAGES_FORGE = [
    ("NPC Forge",
     "Welcome to NPC Forge!\n\n"
     "This is a sandbox game to learn how to work with NPCs (characters) in Minecraft Java Edition.\n\n"
     "Right-click a character to talk to them."),
    ("Get started",
     "Try these three commands:\n\n"
     "/trigger create_npc\n"
     "/trigger clear_all_npcs\n"
     "/trigger refresh_starter_npcs\n\n"
     "New to commands? Next page!"),
    # command basics, lifted from the first Command Forge quests
    ("Chat",
     "t = open the chat box.\nEsc = close it.\n\n"
     "Type words and press Enter: everyone sees them.\n\n"
     "With the chat box open, your mouse is free, so you can click things in chat."),
    ("Commands",
     "Type / first: that tells Minecraft it's a command, not chat.\n\n"
     "Try it: type /effect give @s glowing and press Enter.\n\n"
     "@s means your player."),
    ("Handy keys",
     "Tab = finish my word.\nTab again = next choice.\nEnter = take it and run.\n\n"
     "/ then Tab = a list of every command.\n\n"
     "Up arrow = my last command comes back."),
    ("/give",
     "/give @s cookie 10\n\n"
     "/give = the command\n@s = who gets it\ncookie = which item\n10 = how many\n\n"
     "Press Tab after /give @s to see every item name."),
    ("Spots",
     "Every spot has 3 numbers: X Y Z.\n\n"
     "X = east, Y = up, Z = south.\n\n"
     "Press F3 to see your own numbers. Spawn is 0 65 0.\n\n"
     "/tp @s X Y Z jumps you there."),
    # the game itself
    ("Make a character",
     "Stand where they should live.\n\n"
     "Type /trigger create_npc and press Enter.\n\n"
     "Fill in Name, Look, and Greeting, then press Create."),
    ("Buttons",
     "Each character gets up to 3 buttons.\n\n"
     "Dialogue = they say a line.\n\n"
     "Command = runs a command for whoever pressed it. No slash. @s = that player."),
    ("Command ideas",
     "give @s cookie 5\n\n"
     "effect give @s levitation 3 1\n\n"
     "tp @s 0 65 0\n\n"
     "time set 18000\n\n"
     "summon chicken"),
    ("Edit a character",
     "Sneak (shift) + right-click them.\n\n"
     "Name, look, and greeting\n"
     "Buttons\n"
     "Bring here\n"
     "Delete\n\n"
     "An empty box keeps what was there.\n\n"
     "/trigger clear_one_npc picks one NPC to remove from a list."),
    ("Rules",
     "No quote marks (\") in any box.\n\n"
     "Fell off the island? You pop back to spawn. So do the characters.\n\n"
     "You can only change or delete NPCs you made. clear_all_npcs asks first.\n\n"
     "Lost this book? /trigger give_new_books"),
    ("Ideas",
     "A shopkeeper who hands out gear.\n\n"
     "A guard with a riddle.\n\n"
     "A guide who teleports you around.\n\n"
     "A villain who turns the day to night."),
]
# the original book, unchanged
PAGES_LITTLE = [
    ("The Little NPC Book",
     "Welcome to NPC Island!\n\n"
     "Right-click a character to talk to them. Their buttons will show dialogue or make something happen (by running commands).\n\n"
     "Try interacting with Bob the Baker and Mira the Guide."),
    ("Make a character",
     "Stand where you want the NPC to spawn.\n\n"
     "Type /trigger create_npc and press Enter.\n\n"
     "Fill in Name, Look, and Greeting, then press Create."),
    ("Buttons",
     "Each NPC can have up to 3 buttons. Each button can be set to either show dialogue or run a command (make something happen).\n\n"
     "Dialogue = The NPC says something.\n\n"
     "Command = A command is run. (Don't use a slash.)"),
    ("Example Commands",
     "give @s cookie 5\n\n"
     "effect give @s levitation 3 1\n\n"
     "tp @s 0 65 0\n\n"
     "time set 18000\n\n"
     "summon chicken"),
    ("Edit a character",
     "Sneak (shift) + right-click them.\n\n"
     "Name, look, and greeting\n"
     "Buttons\n"
     "Bring here\n"
     "Delete\n\n"
     "An empty box keeps what was there."),
    ("Rules",
     "No quote marks (\") in any box.\n\n"
     "Fell off the island? You pop back to spawn. So do the characters.\n\n"
     "Lost this book? /trigger give_new_books"),
    ("Start over",
     "You can only change or delete NPCs you made.\n\n"
     "/trigger clear_one_npc = pick one NPC to remove.\n\n"
     "/trigger clear_all_npcs = delete all your NPCs (it asks first).\n\n"
     "/trigger refresh_starter_npcs = Bob and Mira come back."),
    ("Ideas",
     "A shopkeeper who hands out gear.\n\n"
     "A guard with a riddle.\n\n"
     "A guide who teleports you around.\n\n"
     "A villain who turns the day to night."),
]

# (title, author, custom_data tag, pages)
BOOKS = [
    ("NPC Forge Book", "NPC Forge", "npc_book", PAGES_FORGE),
    ("Little NPC Book", "NPC Island", "npc_book2", PAGES_LITTLE),
]


def page(title, body):
    return {"font": FONT, "text": f"{title}\n____\n\n{body}"}


def item(title, author, tag, pages):
    body = ",".join(json.dumps(page(t, b)) for t, b in pages)
    return (f"written_book[written_book_content={{title:{json.dumps(title)},author:{json.dumps(author)},"
            f"pages:[{body}]}},custom_data={{{tag}:1b}}]")


def main():
    lines = [
        "# GENERATED by tools/gen_book.py - edit the Python, not this file.",
        "# The instruction books: given once on first join (tick) and again by /trigger give_new_books. Old copies are replaced.",
        "tag @s add npc_book",
    ]
    for title, author, tag, pages in BOOKS:
        lines.append(f"clear @s written_book[custom_data~{{{tag}:1b}}]")
        lines.append(f"give @s {item(title, author, tag, pages)}")
    OUT.write_text("\n".join(lines) + "\n")
    print(f"wrote {OUT}: " + ", ".join(f"{t} ({len(p)} pages)" for t, _, _, p in BOOKS))

if __name__ == "__main__":
    main()
