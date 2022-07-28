#!/bin/sh
## Maintenance commands for the CoreProtect plugin.
. '../../var/env.sh'

echo 'Cleaning CoreProtect database...'
eval "$ENV_MC_CMD 'co purge t:15d \n'"
## (Head moderator says 2 weeks is a good statute of limitations.)

## Done
exit 0
