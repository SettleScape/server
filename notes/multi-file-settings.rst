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

    2. `hard` (Should generally be equal to the blocks loaded by `view-distance`.)

* `plugins/LagFixer/config.yml`

  1. `view_distance` (Should be less than `view-distance`)

* `plugins/Towny/settings/config.yml` (All values should be the number of plots that equal `view-distance`.)

  * `min_distance_between_homeblocks`
  * `min_distance_for_outpost_from_plot`
  * `min_plot_distance_from_town_plot`
  * `nationZonesSize` 

* The world border -- see `./world-sizes-and-borders.rst` for more info.

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

Nation Prices & Upkeep
================================================================================

* `plugins/Towny/settings/config.yml`

  * `price_new_nation` (Should be some multiple of `price_new_town`.)
  * `nation_pertown_upkeep` (Should be true.)
  * `nationTownUpkeepModifier` (Should be set so that the effective `price_nation_upkeep * numResidents` is never lower than `price_new_nation / 365.24` -- players should be able to afford to pay for a nation at least once a year.)
  * `price_nation_upkeep` (Should be equal to `town_plotbased_upkeep_minimum_amount`.)
  * `bail_amount_king` (Should be the same multiple of `bail_amount_mayor` as `price_new_nation` is of `price_new_town`)
  * `bailmax_amount` (Should be `bail_amount_king` -- a king's ransom.)

Town Prices & Upkeep
================================================================================

* `plugins/Towny/settings/config.yml`

  * `price_new_town`
  * `max_nation_conquered_tax`
  * `price_outpost`
  * `price_reclaim_ruined_town`
  * `town_plotbased_upkeep_minimum_amount` (Should be divided by `365.25` -- players should be able to afford to pay for a town at least once a year.)
  * `bail_amount_mayor` (Should be some multiple of `bail_amount`.)

Plot Prices & Upkeep
================================================================================

* `plugins/Towny/settings/config.yml`

  * `price_purchased_bonus_townblock`
  * `bail_amount`
  * `default_nation_conquered_tax`
  * `max_price_claim_townblock`
  * `price_claim_townblock_refund` (Should be divided by `-2` to discourage abusing reclaims to avoid paying for an outpost.)
  * `price_purchased_bonus_townblock_max_price`
  * `price_town_merge`
  * `takeoverclaim.price`
  * `town_plotbased_upkeep` (Should be `true`.)

Town Plot Limits
================================================================================

* `plugins/Towny/settings/config.yml`

  * `townBlockBuyBonusLimit`
  * `max_buytown_price` (Should be `townBlockBuyBonusLimit * price_purchased_bonus_townblock`)

World border display
================================================================================

* `plugins/dynmap/configuration.txt`

  1. `showworldborder`

* `plugins/dynmap/worlds.txt`

  1. `showborder`

* `plugins/WorldBorder/config.yml`

  2. `dynmap-border-enabled`

* `plugins/dynmap/markers.yml`

  3. `worldborder.markerset`
