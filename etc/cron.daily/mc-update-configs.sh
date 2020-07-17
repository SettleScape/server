#!/bin/sh
CWD=$(pwd)
cd /srv/minecraft
## Update SettleScape
cd settlescape
sudo -u minecraft git pull
## Update Paper
cd minecraft/scripts
sudo -u minecraft sh 'refresh-server.sh'
## Cleanup
cd "$CWD"
exit 0
