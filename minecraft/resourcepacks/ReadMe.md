Each "Selected Packs (version).txt" file in this directory, except the latest one, contains only those modules we use that VanillaTweaks stopped providing after that version.  The latest one contains every module that is still supported by VanillaTweaks.
You can drag&drop these such files into the VanillaTweaks website to download their associated textures.  Here's the URL:  https://vanillatweaks.net/picker/resource-packs
Download them all and then paste them on-top of each other, in order from oldest to newest.
Following this, you need to manually apply specific textures from specific versions' packs over the top of the compilation you just made:
- Our custom UI textures
- Our custom metadata (the SettleScape logo and a JSON file with the pack's name, version, etc)
That should fully recreate the resource pack used on SettleScape.

We maintain the following custom resources:
- We unfortunately are forced to maintain our own custom version of DarkUI because the one VanillaTweaks provides is woefully incomplete.  Here are the main changes in ours:
  - The lighter blue of 1.16's BlueWidgetsHighlight is preferred over the darker blue of 1.17's BlueWidgetsHighlight.
  - Several buttons in various UI files need to be manually modified to be blue when highlighted.  (BlueWidgetsHighlight is incomplete.)
  - The center pane for the Brewing Stand Menu should come from BrewingGuideDark (discontinued after 1.16), and the side panes should be from the latest version's BrewingGuide.
  - There are some other tweaks as well.
  - Every update, we have to manually port over any new UI elements from the latest VanillaTweaks into our custom textures.  We also have to be careful to not replace dark textures with light ones -- sometimes, new versions of DarkUI inexplicably remove dark textures that they used to have.
- We use the larger plus from LargeAttackIndicator without using its larger sword.
