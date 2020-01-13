#!/bin/sh
cd /srv/minecraft

echo 'Updating SettleScape...'
cd settlescape
sudo -u minecraft git pull
sudo -u minecraft sh 'refresh-server.sh' &
sudo -u minecraft sh 'refresh-plugins.sh' &
wait
cd ..
