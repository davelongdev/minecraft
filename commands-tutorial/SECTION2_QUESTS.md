# Section 2 draft: Command Blocks (island 2)

**Status 2026-10-12 evening: all eight quests below are implemented in `tools/gen_lessons.py` (QUESTS2) and `s2/e0..e7`;**
**the final order is 1 give yourself a command block, 2 /give + command blocks (carrot), 3 press a button (cookie), 4 repeat,**
**5 roll the dice, 6 chain (cake), 7 pressure plate trap, 8 teleporter. The text below is the original draft.**

Draft 2026-10-12. Same style as section 1: aqua-bold key phrases, blank lines between
sentences, a "Your Mission" line, NEXT QUEST runs an in-world check. Not generated yet;
once the text settles it moves into `tools/gen_lessons.py` as `SECTION 2` and the checks
into `s2/e<i>/check`. Island 2 needs the same three button posts as island 1 plus a
"build pad": a row of glowing spots (sea lanterns in the floor) where the quests ask for
command blocks, so the checks know where to look.

Big idea for the kids: in section 1 YOU typed commands. A command block is a block that
types a command for you when redstone tells it to. That is how Minecraft maps get made.

---

## 1. Give Yourself a Command Block  (sign: Give Yourself a / Command Block) — IMPLEMENTED 2026-10-12 as s2/e0

Command blocks only open in creative mode.

Your Mission - Type /gamemode creative and press Enter. Then type /give @s command_block.

Look in your inventory - an orange block with a face. That is a command block.

Check: player is creative and has a command_block item (`execute if entity @s[gamemode=creative] if items entity @s container.* command_block`).

## 2. Place and Open  (sign: Place / and Open)

A command block runs a command for you. You just have to tell it which one.

Put the block on the glowing spot in front of you. Right-click it to open it.

The big box at the top is the Console Command - type a command there, without the slash.

Your Mission - Type say Hello from a block! in the box and click Done.

Nothing happened? Right. The block is waiting for a signal. Next quest.

Check: command block on pad spot 1 whose Command contains "say" (`execute if block <pad1> command_block{Command:"say Hello from a block!"}` is too strict; use `data get` + string check, or just any `command_block` on the spot with a non-empty Command).

## 3. Needs Redstone  (sign: Needs / Redstone)

Redstone is Minecraft's electricity. A command block runs when redstone tells it to.

A button makes a short pulse of redstone.

Your Mission - Type /give @s stone_button, put the button on the command block, and press it.

Read the chat - your block just talked!

Check: button attached to the block on pad 1 and the block's SuccessCount is 1 or more (`store result score @s tut_tmp run data get block <pad1> SuccessCount`).

## 4. Give Yourself Stuff  — IMPLEMENTED 2026-10-12 as s2/e1 "/give + Command Blocks" (give @p carrot, Always Active; check = carrot in inventory)

Any command you typed in section 1 works in a block. Let the block do the typing.

Your Mission - Open the block again. Change the command to give @p diamond 1. Press the button three times.

@p means the nearest player - that is you when you press it.

Check: player has 3 or more diamonds (`execute if items entity @s container.* diamond[count~{min:3}]`).

## 5. Roll the Dice  (sign: Roll / the Dice)

Board games need dice. Minecraft has them built in.

Your Mission - Put a new command block on the second glowing spot. Give it the command random roll 1..6 and a button. Press it a few times.

Everyone on the server sees the roll - perfect for a game.

(Later: random roll 1..20 for a D20.)

Check: command block on pad 2 whose Command starts with "random" and SuccessCount >= 1.

## 6. Repeat  (sign: Repeat)

Open a command block and click the Impulse button. It changes to Chain, then Repeat.

Impulse = run once. Repeat = run 20 times every second, as long as it is powered.

Your Mission - Put a block on the third spot, set it to Repeat and Always Active, and give it the command particle happy_villager ~ ~2 ~ 1 1 1 0 10.

Green sparkles forever. Break the block to stop it.

Check: `repeating_command_block{auto:1b}` on pad 3.

## 7. Chain  (sign: Chain)

Chain blocks run right after the block pointing into them. That is how you make a block do two things.

Your Mission - On the fourth spot: an Impulse block with give @p cookie, then a Chain block right after it (the arrow on the block points the way) set to Always Active with say Enjoy your cookie!

Press the button. Cookie and a message - two commands from one press.

Check: `command_block` on pad 4 and `chain_command_block{auto:1b}` on the next block, cookie in inventory.

## 8. Pressure Plate Trap  (sign: Pressure / Plate Trap)

A pressure plate is a redstone signal you step on. A command block under it is a trap.

Your Mission - Dig a hole in the trap square, put a command block in it with effect give @p levitation 3 1, cover it with a stone pressure plate, and walk on it.

Up you go! Try slow_falling, speed, or jump_boost instead.

Check: pressure plate on the trap square with a command block below it, SuccessCount >= 1.

## 9. Teleporter  (sign: Teleporter)

Section 1 ended with /tp. Now a block does it for you - that is how maps send players to the next level.

Your Mission - Put a command block with a button on the fifth spot. Its command: tp @p <x> <y> <z> using the numbers on the TARGET sign across the island. Press it.

Made it across? That is a teleporter. Every adventure map has one.

Check: player standing on the target pad (or has been, flag like tut_cage).

## 10. Your Own Game  (sign: Your / Own Game)

You know how to type commands, how a block runs them, and how redstone sets them off.

Your Mission - Anywhere on this island, build something of your own with at least one command block and a button, plate, or lever. Press it so it runs once.

Ideas: a dice table, a cookie shop, a trap, a secret teleporter.

Check: any command block within the island whose SuccessCount >= 1 outside the pads (scan with `execute positioned` over the 36x36, or count via a repeating `fill ... replace` trick; simplest: `execute if blocks`? -> settle when implementing).

---

Open questions for Dave:
- 10 quests ok, or trim to 8 (drop 4 and 8)?
- Kids will leave Repeat blocks running; the island repair (`___fix_island`) clears them, fine.
- `random roll` prints to everyone in chat - good for a class, noisy with 10 kids. `random value` prints only to you.
- Levitation on a void island: 3 seconds at level 1 is safe; `void_catch` brings them back anyway.
