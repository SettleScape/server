#!/bin/sh
. '../var/env.sh'

systemctl --user daemon-reload
systemctl --user start settlescape

sleep 1
exec screen -r "$ENV_SCREEN_NAME"
