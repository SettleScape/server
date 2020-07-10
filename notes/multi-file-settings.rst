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

Time until Inactive
================================================================================

* `plugins/Essentials/config.yml`

  * `auto-afk`

* `plugins/Towny/settings/config.yml`

  * `inactive_after_time`

Join/Quit Messages
================================================================================

* `plugins/Essentials/config.yml`

  * `custom-join-message`
  * `custom-quit-message`
  * `death-messages`

* `plugins/dynmap/configuration.txt`

  * `joinmessage`
  * `quitmessage`

* `plugins/WorldGuard/config.yml`

  * `disable-death-messages`

Protections
================================================================================
Prefer Towny's protections, where possible -- they're integrated with Towny, whereas WorldGuard's are not.

* `plugins/WorldGuard/config.yml`

  * `ignition.block-*`
  * `fire.disable-all-fire-spread`
  * `mobs.block-*-explosions`
  * `mobs.block-*-block-damage`
  * `mobs.disable-enderman-griefing`
  * `crops.disable-creature-trampling`
  * `crops.player-creature-trampling`

* `plugins/Towny/settings/config.yml`

  * `protection.item_use_ids`
  * `new_world_settings.fire.world_firespread_enabled`
  * `new_world_settings.explosions.world_explosions_enabled`
  * `new_world_settings.plot_management.wild_revert_on_mob_explosion`
  * `new_world_settings.enderman_protect`
  * `new_world_settings.disable_creature_crop_trampling`
  * `new_world_settings.disable_player_crop_trampling`
  * `new_world_settings.`
