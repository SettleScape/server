World-Border
################################################################################

As nice as it is to have a virtually infinite world;  infinity is not a practical reality for us.
Storage, ultimately, is not free.
As such, we need to set world borders that will limit disk usage, while still allowing for plenty of exploration and expansion.

An additional benefit of having a world border, besides saving space, is that, when Minecraft's terrain generation inevitably changes at some point in the future, we can just pregenerate the world to the current world border, and then expand the border to a new limit, thus giving a very clear delineation between the old terrain and the new terrain.

Current world borders
================================================================================

**Overworld**

* `worldborder set 65536` (While I think a worldborder of 32768 is a better, size, our particular seed needs at least around 65536 in order to give players access to certain rare biomes.)
* `worldborder center 3072 0` (This centers the world border on the central ocean.)

**Nether**

* `worldborder set 8192` (This has to be 1/8 the Overworld worldborder.)
* `worldborder center 384 0` (This has to be 1/8 the Overworld center's coordinates.)

**The End**

* `worldborder set 8192` (There is nothing interesting far-out in the End;  therefore, we should make the worldborder small, to save storage space.)
* `worldborder center 0 0`

Synergistic settings
================================================================================

* `plugins/dynmap/worlds.txt`

  * `visibilitylimits`:  This defines a series of boxes that Dynmap is supposed to render.  We should not render outside of the world border.
