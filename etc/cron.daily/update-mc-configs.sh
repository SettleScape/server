#!/bin/sh
CWD=$(pwd)
cd /srv/minecraft
## Update SettleScape
cd settlescape
sudo -u minecraft git pull
## Update Paper
cd minecraft/scripts
sudo -u minecraft sh 'update-minecraft.sh'
## Update Java
sudo -u minecraft sh 'update-java.sh'
## Cleanup
cd "$CWD"
exit 0
