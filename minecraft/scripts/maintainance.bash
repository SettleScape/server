#!/bin/sh
## This script sends certain commands to a running Minecraft `screen` instance.
## It is used to perform daily maintenance tasks from within Minecraft itself.
source './env.sh'

## Configure the stuff command
STUFF="screen -S "$ENV_SCREEN_NAME" -X stuff"

echo 'Cleaning CoreProtect database...'
eval "$STUFF 'co purge t:15d \n'" && sleep 5
## (Head moderator says 2 weeks is a good statute of limitations.)

echo 'Fixing splotchy maps...'
eval "$STUFF 'dynmap fullrender world \n'"         && sleep 1
eval "$STUFF 'dynmap fullrender world_nether \n'"  && sleep 1
eval "$STUFF 'dynmap fullrender world_the_end \n'" && sleep 1

## Done
echo 'Done.'
exit 0
