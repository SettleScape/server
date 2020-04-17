#!/usr/bin/env bash
set -e

## Send specified plugins to the server
CWD=$(pwd)
[[ ! "$CWD" == *'/plugins' ]] && cd plugins
for PLUGIN in "$@"; do
    [[ ! "$PLUGIN" == *'.jar' ]] && PLUGIN="${PLUGIN}.jar"
    scp "$PLUGIN" 'minecraft@settlescape:/srv/minecraft/settlescape/plugins'
done

## Cleanup
cd "$CWD"
exit 0
