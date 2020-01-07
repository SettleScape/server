#!/bin/sh
cd /srv/minecraft

echo 'Updating SettleScape...'
cd settlescape
sudo -u minecraft git pull
cd ..
