#!/bin/sh
## Maintenance commands for the wborder plugin.
. '../../var/env.sh'

echo 'Removing chunks outside of world border...'
eval "$ENV_MC_CMD 'wborder world trim 60 0 \n'"
eval "$ENV_MC_CMD 'wborder world_nether trim 60 0 \n'"
eval "$ENV_MC_CMD 'wborder world_the_end trim 60 0 \n'"

## Done
exit 0
