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

  1. `view-distance`

* `spigot.yml`

  1. `view-distance` (Should be same as in `server.properties`.)

  * `mob-spawn-range` (Should generally be `1` less than `view-distance`.)

  * `*range*` (Make sure these don't exceed the blocks loaded by `view-distance`.)

* `paper.yml`

  * `despawn-ranges`

    * `hard` (Should generally be equal to the blocks loaded by `view-distance`.)

* `plugins/LagFixer/config.yml`

  1. `view_distance` (Should be less than `view-distance`)

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

  1. `custom-join-message`
  2. `custom-quit-message`
  3. `death-messages`

* `plugins/dynmap/configuration.txt`

  1. `joinmessage`
  2. `quitmessage`

* `plugins/WorldGuard/config.yml`

  3. `disable-death-messages`

Protections
================================================================================

Order of preference for different protection plugins:  Towny > WorldGuard > EssentialsXProtect.
For the sake of brevity, EssentialsXProtect is not included below.

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

Cooldowns
================================================================================

This one is weird, in that the same setting is in the same file twice.

* `plugins/Essentials/config.yml`

  * `heal-cooldown`
  * `command-cooldowns`
