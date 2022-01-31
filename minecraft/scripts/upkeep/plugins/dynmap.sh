#!/bin/sh
## Maintenance commands for the Dynmap plugin.
. '../../var/env.sh'

echo 'Fixing splotchy maps...'
eval "$ENV_MC_CMD 'dynmap fullrender world \n'"
eval "$ENV_MC_CMD 'dynmap fullrender world_nether \n'"
eval "$ENV_MC_CMD 'dynmap fullrender world_the_end \n'"

## Done
exit 0
