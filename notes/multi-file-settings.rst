Multi-File Settings
################################################################################

Some settings have to be harmonized across multiple files.
This text document keeps track of these settings.

View Distance
================================================================================

View Distance in server configs is the same as Render Distance in-game.

Render Distance information:  https://minecraft.gamepedia.com/Options#Video_settings

When changing View Distance, you need to edit the following:

* `server.properties`

  * `view-distance`

* `spigot.yml`

  * `view-distance` (Should be same as in `server.properties`.)

  * `mob-spawn-range` (Should generally be `1` less than `view-distance`.)

  * `*range*` (Make sure these don't exceed the blocks loaded by the view-distance.)

* `paper.yml`

  * `despawn-ranges`

    * `hard` (Should generally be equal to the blocks loaded by the view-distance.)

Entity Collisions
================================================================================

* `spigot.yml`

  * `max-entity-collisions` (Should be same as in `paper.yml`.)

* `paper.yml`

  * `max-entity-collisions`
