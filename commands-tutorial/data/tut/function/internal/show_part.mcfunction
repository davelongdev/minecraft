# QUEST button: clear the chat and print the current part, so pressing again shows one clean copy.
# Part functions are tick-gated on tut_pp (see tools/gen_lessons.py): tick 0 prints now,
# print_tick keeps feeding later ticks for quests that have a line delay.
function tut:internal/clear_chat
scoreboard players set @s tut_pp 0
$function tut:s$(sec)/e$(ex)/part$(part)
