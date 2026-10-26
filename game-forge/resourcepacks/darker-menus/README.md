# darker-menus (Game Forge resource pack)

Only one change: the blurred background behind every menu and dialog screen is darkened (Factor 0.4), so
white dialog text reads well. It's the backdrop part of Command Forge's `no-moon` pack
(`commands-tutorial/resourcepacks/no-moon/`), without the sun/moon removal or the dialog font.

- `assets/minecraft/post_effect/blur.json`: vanilla's blur passes plus two passes of `forge:post/darken`
  (Factor 0.4, then 1.0 to copy back). Change the first Factor to make it lighter or darker.
- `assets/forge/shaders/post/darken.fsh`: multiplies the colour by Factor.

Build: `cd game-forge/resourcepacks/darker-menus && zip -r ../../../zips/darker-menus.zip pack.mcmeta assets`
Served by the box's `mc-www` (`/srv/mc/_shared/www/`), set in a server's `server.properties` as
`resource-pack=<url>` + `resource-pack-sha1=<sha1sum of the zip>`. Resource pack format 97 (26.3).
