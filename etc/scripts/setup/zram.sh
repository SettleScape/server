#!/bin/sh
dnf install -y zram-generator
systemctl start dev-zram0.swap
