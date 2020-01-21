World-Border
################################################################################

Current world borders
================================================================================

**Overworld**

* `worldborder set 32768` (This is a good size -- it makes the world feel big and gives a lot of room for exploration;  but it's not ridiculously big.)
* `worldborder center 3072 0` (This centers the world border on the central ocean.)

**Nether**

* `worldborder set 4096`
* `worldborder center 384 0`

**The End**

* `worldborder set 32768`
* `worldborder center 0 0`

Synergistic settings
================================================================================

* `plugins/dynmap/worlds.txt`

  * `visibilitylimits`:  This defines a series of boxes that Dynmap is supposed to render.  We should not render outside of the world border.
