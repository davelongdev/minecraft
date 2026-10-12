# Dev: reload the pack, then reset yourself with the freshly loaded code.
# Run as a player: /function tut:___rr
# The reset can't run here (this function is the old code), so tag yourself and
# let the first tick after the reload (internal/tick) do it.
tag @s add tut_rr
reload
