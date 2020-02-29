#!/usr/bin/env sh
cd plugins
for PLUGIN in "$@"; do
    scp "$PLUGIN.jar" 'minecraft@settlescape:/srv/minecraft/settlescape/plugins'
done
cd ..
exit 0
