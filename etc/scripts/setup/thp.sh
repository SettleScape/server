#!/bin/sh
cp -a /srv/minecraft/settlescape/etc/systemd/tmpfiles.d /etc/systemd/
systemd-tmpfiles --create
