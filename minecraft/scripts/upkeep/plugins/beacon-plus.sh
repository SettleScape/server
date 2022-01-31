#!/bin/sh
## Maintenance commands for the CoreProtect plugin.
. '../../var/env.sh'

echo 'Cleaning Beacon+ data...'
eval "$ENV_MC_CMD bp purgeemptydata" #WARN: Can take a long time and choke server resources.

## Done
exit 0
