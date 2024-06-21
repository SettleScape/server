World-Border
################################################################################

As nice as it is to have a virtually infinite world;  infinity is not a practical reality for us.
Storage, ultimately, is not free.
As such, we need to set world borders that will limit disk usage, while still allowing for plenty of exploration and expansion.

An additional benefit of having a world border, besides saving space, is that, when Minecraft's terrain generation inevitably changes at some point in the future, we can just pregenerate the world to the current world border, and then expand the border to a new limit, thus giving a very clear delineation between the old terrain and the new terrain.

Current world borders
================================================================================

**Overworld**

* `worldborder set 12288` (I think a world border at 32768 is probably ideal as a size, but our particular seed needs at least around 65536 in order to give players access to certain rare biomes. To save space space and take advantage of updated terrain generation in newer versions, I've opted to limit the size of the world to just 24 regions.)
* `worldborder center 3072 -1024` (This essentially centers the 24x24-region world's border on the central ocean.)

**Nether**

* `worldborder set 1536` (This has to be 1/8 the Overworld world border.)
* `worldborder center 384 -128` (This has to be 1/8 the Overworld center's coordinates.)

**The End**

* `worldborder set 2048` (There is nothing interesting far-out in the End;  therefore, we should make the world border small, to save storage space.  8192 is pretty reasonable in terms of functionality;  but I think I'm going to set it at 2048 and gradually increase it from there as newer and newer versions come out, to pace exploration.)
* `worldborder center 0 0` (Should be centered on origin, where the return fountain is.)

Synergistic settings
================================================================================

* `plugins/dynmap/worlds.txt`

  * `visibilitylimits`:  This defines a series of boxes that Dynmap is supposed to render.  We should not render outside of the world border.
  * `showborder`: This would seem to be handy, and it *is*, but its aesthetics are unconfigurable -- it's better to use a custom outline in `plugins/dynmap/markers.yml`.  And when `plugins/WorldBorder.jar` is active, this setting is wholly redundant;  this plugin also automatically prefills settings for its configured world borders to `markers.yml`.

Pregeneration
================================================================================

* We should make sure that the regions immediately adjacent to the world border are pregenerated, so that there is land for players to look out at past the world border.
  * Example command: `wb world fill 20 512 false`