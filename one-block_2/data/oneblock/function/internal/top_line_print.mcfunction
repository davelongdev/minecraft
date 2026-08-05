# Macro: the actual leaderboard line for top_line (as the ranked player).
# Shows the stored display name when the player has set one (id found in the
# players list), otherwise their username. id 0 = never set, always falls back.
$execute if data storage oneblock:main players[{id:$(id)}] run tellraw @a [{"text":"","color":"aqua"},{"score":{"name":"rank","objective":"ob_work"}},{"text":". "},{"nbt":"players[{id:$(id)}].name","storage":"oneblock:main"},{"text":" — "},{"score":{"name":"@s","objective":"ob_ds"}},{"text":"."},{"score":{"name":"@s","objective":"ob_dt"}},{"text":"s"}]
$execute unless data storage oneblock:main players[{id:$(id)}] run tellraw @a [{"text":"","color":"aqua"},{"score":{"name":"rank","objective":"ob_work"}},{"text":". "},{"selector":"@s"},{"text":" — "},{"score":{"name":"@s","objective":"ob_ds"}},{"text":"."},{"score":{"name":"@s","objective":"ob_dt"}},{"text":"s"}]
