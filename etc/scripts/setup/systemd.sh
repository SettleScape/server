#!/bin/sh

sudo loginctl enable-linger minecraft
sudo --su minecraft mkdir -p /srv/minecraft/.config/systemd/user
sudo ln -s /srv/minecraft/settlescape/etc/systemd/system/settlescape.service /srv/minecraft/.config/systemd/user/
sudo --su minecraft systemctl --user enable settlescape.service

sudo dnf install -y dnf-automatic
sudo cp -a /srv/minecraft/settlescape/etc/systemd/system/dnf-automatic.timer.d /etc/systemd/system/
sudo daemon-reload
sudo systemctl enable dnf-automatic.timer
