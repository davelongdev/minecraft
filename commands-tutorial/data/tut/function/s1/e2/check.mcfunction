# The Little Command Book was opened (right-click counts as using the item), and then closed again: the first time
# the open is seen, remember the view (internal/view_mark); pass once it changes, so "Great job!" isn't hidden
# behind the open book (Dave 2026-10-26).
execute unless score @s tut_book matches 1.. run return fail
execute unless score @s tut_flag matches 1 run function tut:internal/view_mark
execute if function tut:internal/view_moved run return 1
return fail
