#!/bin/sh
cp -a /srv/minecraft/settlescape/etc/systemd/journald.conf.d /etc/systemd/
systemctl enable --now logrotate.timer
echo 'Edit `/etc/logrotate.conf` and enable compression.'
echo 'Edit `/etc/logrotate.d/btmp` and set `rotate` to `1`.'
