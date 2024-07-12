Files that contain personal data
--------------------------------
This document records files' relative paths and what kinds of personal data is stored in them.

Current roadblocks to GDPR compliance:
* I currently have no way to edit SQLite databases while the server is running, nor indeed on the server itself -- I have to move the data to my personal computer, read or edit it there by hand, and re-upload to the server, causing significant downtime *and* the moving of data to a new location.

Not personal data, but should delete:
* `minecraft/plugins/AuctionHouse/auctions.bak`: Is from an old version of AuctionHouse.
* `minecraft/plugins/AuctionHouse/auctions.old`: Is from an old version of AuctionHouse.
* `minecraft/plugins/BeaconPlus2/`: Is an old version of BeaconPlus.

Files needing remediation:
* `minecraft/plugins/Essentials/usermap.bin`: Contains a bunch of usernames.  Is a binary format, so I can't modify it.  We need to find a way to disable the use of this file if we can, because we physically cannot make it GDPR-compliant.

Files containing personal information that are wiped on server start (so, at least once per day):
* `minecraft/plugins/dynmap/ids-by-ip.txt`: Is a relation of usernames to IPs.  We need to disable this file, or at least reset it daily.

Files containing personal data that are automatically deleted every 7 days by the `purge-old.bash` script:
* `minecraft/logs/*`: Can contain IPs, usernames, UUIDs, chat messages, and more.
* `minecraft/crash-reports/*`: What this contains varies over time, but it likely sometimes contains some personal information.
* `minecraft/plugins/AuctionHouse/logs/`: Contains usernames and transaction details.
* `minecraft/plugins/CommandLog/`: Contains usernames and can contain certain kinds of chat messages.
* `minecraft/plugins/mcMMO/backup/*`: Contains a backup of the flatfile database (if in use)
* `minecraft/plugins/Towny/backup/*`: Seem to be empty, but *should* contain backups of things that contain personal data.

Files that contain personal data long-term:
* `minecraft/plugins/CoreProtect/database.db`: Contains a mapping of usernames to UUIDs.
* `minecraft/plugins/dynmap/dynmap.db`: Contains a mapping of usernames to skins.
* `minecraft/plugins/dynmap/hiddenplayers.txt`: Is a list of usernames of people.  Players who are in this list will, I assume, not show up on the Dynmap.
* `minecraft/plugins/Essentials/userdata/*`: Is a directory containing all users who have ever connected to the server.  The files contain, among other things, the user's username.
* `minecraft/plugins/Essentials/usermap.csv`: Contains a mapping of usernames to UUIDs.
* `minecraft/plugins/EssentialsDiscordLink/accounts.json`: Maps UUIDs to Discord account IDs.
* `minecraft/plugins/Jobs/jobs.sqlite.db`: Contains a mapping of UUIDs to usernames.
* `minecraft/plugins/LuckPerms/yaml-storage/users`: Is a directory containing all users who have ever connected to the server.  The files contain, among other things, the user's username.
* `minecraft/plugins/mcMMO/flatfile/mcmmo.users`: Contains usernames of all users who have ever eaned mcMMO experience.
* `minecraft/plugins/ShopChest/shops.db`: Contains a mapping of usernames to UUIDs.
* `minecraft/plugins/Towny/data/residents`: Contains a mapping of usernames to UUIDs, a list of their friends, and optionally a user-defined "about" message.
* `minecraft/plugins/Towny/data/towns/**`: Contains usernames, a configurable MotD, a configurable culture name, and some user UUIDs.
* `minecraft/permissions.yml`: We don't use this file, but it can contain usernames.
* `minecraft/usercache.json`: Contains a mapping of usernames to UUIDs.
* `minecraft/wepif.yml`: We don't use this file, but it can contain usernames.
* `minecraft/whitelist.json`: Contains a mapping of usernames to UUIDs.

Files that might eventually contain personal data long-term:
* `minecraft/plugins/CraftBook/uuid-mappings.db`: Currently devoid of data.  I'm not sure it's actually used on our server.
* `minecraft/plugins/mcMMO/flatfile/parties.yml`: Currently devoid of data.  I tried creating a party, but nothing showed up in this file when I did so.
* `minecraft/plugins/mcMMO/flatfile/parties.yml.converted`: Currently devoid of data.  I'm unsure if this is even used.
* `minecraft/plugins/TownyHistories/ruins`: Will probably contain personal data if anything ever appears here.

Files that do not contain personal data, but do contain UUIDs:
* `minecraft/plugins/AuctionHouse/auctions.db`
* `minecraft/plugins/AuctionHouse/auctions.db.backup`
* `minecraft/plugins/BeaconPlus3/player_data/*`
* `minecraft/plugins/Essentials/uuids.bin`: In binary format -- I can't modify it.
* `minecraft/plugins/FAWE/sessions`
* `minecraft/plugins/OpenInv/config.yml`: Only contains the UUIDs of moderators and administrators, because only they can run the relevant commands.
* `minecraft/plugins/Towny/data/jails/**`
* `minecraft/plugins/FastAsyncWorldEdit/sessions`: Only contains the UUIDs of administrators, because only they can run the relevant commands.  (Honestly, probably other directories under the parend directory can contain UUIDs too;  but none of them have any data atm.)
* `minecraft/plugins/WorldGuard/worlds/*/regions.yml`: Can contain UUIDs, but only if I manually put them there.
* `minecraft/plugins/WorldGuard/report.txt`: Can contain UUIDs if a `regions.yml` file has them.
* `minecraft/worlds/*/advancements`
* `minecraft/worlds/*/stats`
* `minecraft/ops.json`: Always empty on our server, but is capable of containing the UUIDs of administrators.

Files that don't normally contain personal info but that *do* contain user-definable strings, and therefore *can* contain personal info if users deliberately put it there:
* `minecraft/plugins/Towny/data/nations/**`: Configurable MotD.
* `minecraft/plugins/Towny/data/plotgroups/**`: Configurable plot group names.
* `minecraft/plugins/Towny/data/townblocks/**`: Configurable plot names.  Can also contain user UUIDs.
* `minecraft/plugins/Towny/data/plotgroups.txt`: Configurable plot group names.

Files that contain unknown data:
* `minecraft/plugins/CraftBook/persistence.db`
* `minecraft/plugins/dynmap/dynmap.db-shm`
* `minecraft/plugins/dynmap/dynmap.db-wal`
* `minecraft/plugins/LuckPerms/luckperms-h2*.db`
* `minecraft/plugins/Towny/data/cooldowns.json`
* `minecraft/worlds/*/playerdata/`: Contains at least a UUID;  but reasonably contains more.  We have no way of knowing what the contents are or mean.

Files that contain block data (and therefore might contain signs, books, named/lored items, etc), which is not something we can feasibly audit:
* `minecraft/plugins/Towny/data/plot-block-data/**`
* `minecraft/worlds/**`: Most of the files in this directory are block data files.

Files that contain personal data which is necessary for the continued operation of the site and so cannot be deleted but which can be requested:
* `minecraft/banned-ips.json`: A list of banned IP addresses.  The most a user can request is it their IP address is in it, and the only way they can request that is by giving us their IP address.
* `minecraft/banned-players.json`: Contains a list of usernames, UUIDs, and ban reasons.
