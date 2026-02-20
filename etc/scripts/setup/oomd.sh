#!/bin/sh
grubby --update-kernel=ALL --args="psi=1"
dnf install -y systemd-oomd
systemctl enable --now systemd-oomd
