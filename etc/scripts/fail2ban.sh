#!/bin/sh
dnf install -y fail2ban
cp -a /srv/minecraft/settlescape/etc/fail2ban /etc/
systemctl enable --now fail2ban
