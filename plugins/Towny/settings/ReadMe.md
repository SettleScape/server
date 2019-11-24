# Towny Config

## Heads-ups

Towny's `config.yml` file's comments are effectively set-in-stone, and any changes you make to the comments will be lost (This includes new comments.).

## Mobs

This server's lore for where mobs come from, is that they don't *really* spawn out of thin air, but are instead ever-present, going underground to hide during the day.  This explanation is believeable in the wild, but not in a town, which is a relatively small area that you are actively developing.  In a town, having creepers randomly spawn and explode is nonsensical, immersion-breaking, and annoying.

Because of this, we'd like to have no mobs spawn in towns, at all -- not even friendly ones.  Instead, all mobs should have to walk into the town from outside.  Unfortunately, Towny does not support this such a scenario.  In Towny, when you prevent a mob from spawning in your town, you also make it so any mob that enters your town will despawn.  There is a workaround, however:  Setting the despawn timer extremely high, so that there basically is no despawn timer.  This allows mobs to *enter* the town without allowing mobs to spawn *in* the town.

However, because this still allows for Towny to eventually forcibly despawn mobs, we can't prevent beneficial mobs from spawning, lest they all disappear later.  Exceptions to this beneficial mobs rule are any beneficial mobs that will always eventually despawn, such as the wandering trader and dolphins.

Other mobs that still need to be able to spawn in-town:

* Creatures that are only present in caves (of which there are likely quite many under your town, most of which will never be developed, and most of which connect to the outside world) such as bats and cave spiders

* Extra-dimensional or teleportative creatures (since these actually *can* sponaneously appear) such as endermen and endermites

* Elementals (since these can theoretically spontaneously assemble) such as slimes and magma cubes

* Small aquatic creatures (since any body of water can be fished in, which means any body of water must be able to contain sea creatures) such as cod and salmon

* Infestative creatures like silverfish (since they can move entirely within blocks, and appear and disappear really without warning)

* Mobs that you summon (since these actually do spontaneously appear) such as withers and enderdragons

Flying mobs are not exceptions, since excepting them would result in them spawning inside any protective domes the player might have built, which is something that wouldn't make sense.
