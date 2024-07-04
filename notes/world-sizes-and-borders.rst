World Sizes and Borders
################################################################################

As nice as it is to have a virtually infinite world;  infinity is not a practical reality for us.
Storage, ultimately, is not free.
As such, we need to set world borders that will limit disk usage, while still allowing for plenty of exploration and expansion.

An additional benefit of having a world border, besides saving storage space, is that, when Minecraft's terrain generation inevitably changes at some point in the future, we can just pregenerate the world to the current world border, and then expand the border to a new limit, thus giving a very clear delineation between the old terrain and the new terrain.

For optimality, we should try to get the world size to align with region boundaries (so, a multiple of 512 blocks).
Because terrain generates around players up to the server's view distance, we should make the world border `(viewDistance + 1) * chunkSize * 2` smaller in each dimension (with the `+1` to act as a buffer / margin of error, just in case).
Because positions in the Nether are linked to those in the overworld and we need these to be in-sync, the Nether border must be exactly 1/8 the overworld border.  This means that the area outside the Nether's world border will always be quite large, given the requirement that we always generate to region boundaries.

Lastly, it's important to note that positive coordinates are bounded 1 lower than negative ones.  (ie, -512 to -1 is 0 to 511.)  (This is true both of individual blocks and of region coordinates.)  A quick heuristic for whether your values are right is whether your positive bounds are all odd.

Current world sizes and borders
================================================================================

World1
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Overworld
--------------------------------------------------------------------------------
* Regions: -6 17 | -14 9
* Size: `12288`
* Visibility: `12288`
* Border: `12096` (I think a world border at 32768 is probably ideal as a size, but our particular seed needs at least around 65536 in order to give players access to certain rare biomes. To save space space and take advantage of updated terrain generation in newer versions, I've opted to limit the size of the world to just 24 regions, which fits pretty well with the world's terrain.)
* Center: `3072 -1024` (This essentially centers the 24x24-region world's border on the central ocean, and ensures a pretty logical edge as well.)

Nether
--------------------------------------------------------------------------------
* Regions: -2 1 | -2 1
* Size: `2048` (This has to be the smallest multiple of `512` that is greater than or equal to the visibility.)
* Visibility: `1704` (This is the border plus `(viewDistance + 1) * chunkSize * 2`)
* Border: `1512` (This has to be 1/8 the Overworld world border.)
* Center: `384 -128` (This has to be 1/8 the Overworld center's coordinates.)

The End
--------------------------------------------------------------------------------
* Regions: -4 3 | -4 3
* Size: `4096` (There is nothing interesting far-out in the End;  therefore, we should make the world border small, to save storage space.  8192 is pretty reasonable in terms of functionality;  but I think I'm going to set it at 4096 and gradually increase it from there as newer and newer versions come out, to pace exploration.)
* Visibility: `4096`
* Border: `3904`
* Center: `0 0` (Should be centered on origin, where the return fountain is.)

Synergistic settings
================================================================================

Set to world region bounds
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

* `scripts/worlds/validate-regions.bash` (Ensure the variables at the start of the script match the values in this file before you run it.)

Set to world size
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

* `plugins/WorldBorder/config.yml`

  * `worlds` (The WorldBorder plugin should be configured at the world size and not the world border, because this facilitates easy and mistakeless pregeneration.)

Set to world visibility
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

* `plugins/dynmap/worlds.txt`

  * `visibilitylimits` (This defines a series of boxes that Dynmap is supposed to render.  There is no reason to render outside of the target world size.)

Set to world border
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

* The actual world border

  * `minecraft:worldborder set BORDER`
  * `minecraft:worldborder center X Y`

* `plugins/dynmap/markers.yml`

  * `worldborder.markerset` (Note that these values will conflict with the plugin that normally defines that markerset (WorldBorder), so make sure its config (`plugins/WorldBorder/config.yml`) is set so that `dynmap-border-enabled` is `false`, just in case.)

Pregeneration
================================================================================

* We should make sure that the regions immediately adjacent to the world border are pregenerated, so that there is land for players to look out at past the world border.

  * Example command: `wborder world fill 60 0 false`
