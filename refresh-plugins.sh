#!/usr/bin/env sh
## Automatically update some plugins.

## Configurable variables
PLUGIN_DIR='./plugins'

## Setup
echo 'Updating plugins...'
CWD="$(pwd)"
cd "$PLUGIN_DIR"

## Bukkit.org
curl -o 'CraftBook.jar'  'https://dev.bukkit.org/projects/craftbook/files/latest'  &
curl -o 'Vault.jar'      'https://dev.bukkit.org/projects/vault/files/latest'      &
curl -o 'WorldEdit.jar'  'https://dev.bukkit.org/projects/worldedit/files/latest'  &
curl -o 'WorldGuard.jar' 'https://dev.bukkit.org/projects/worldguard/files/latest' &

## Cleanup
wait
cd "$CWD"
echo 'Done.'
exit 0
