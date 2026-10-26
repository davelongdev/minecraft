# Recursive loop for ___list_saves' named section: prints work[0], consumes it,
# recurses while entries remain. Caller copies saves -> work and guards on [0].
function oneblock:internal/list_named_line with storage oneblock:main work[0]
data remove storage oneblock:main work[0]
execute if data storage oneblock:main work[0] run function oneblock:internal/list_named_loop
