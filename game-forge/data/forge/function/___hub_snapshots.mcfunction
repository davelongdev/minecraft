# Teacher: list the newest 20 automatic hub snapshots (every 5 minutes while anyone plays, all kept; made by
# mc-hub-snapshot on the box) and click one to put the hub back to that moment. An older one by name:
#   /function forge:internal/restore_hub_auto {name:"2026-10-25_21-47"}
# ___restore_hub = the known-good one shipped in the pack.
execute unless data storage forge:main hub_auto[0] run return run tellraw @s {text:"No hub snapshots yet: one is taken every 5 minutes while someone's on.",color:"yellow"}
tellraw @s {text:"Newest hub snapshots, oldest first. Click one to restore the hub to that time:",color:"aqua"}
data modify storage forge:main tmp.list set from storage forge:main hub_auto
function forge:internal/hub_list_trim
function forge:internal/hub_list_loop
