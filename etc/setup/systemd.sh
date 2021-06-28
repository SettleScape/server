#!/bin/sh
sudo loginctl enable-linger minecraft
sudo --su minecraft mkdir -p /srv/minecraft/.config/systemd/user
sudo cp -a /srv/minecraft/settlescape/etc/systemd/system/settlescape.service /srv/minecraft/.config/systemd/user/
sudo --su minecraft systemctl --user enable settlescape.service
