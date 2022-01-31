#!/bin/sh
. '../var/env.sh'

screen -S "$ENV_SCREEN_NAME" -X stuff 'stop \n'
exit 0
