#!/bin/sh
## Sets up SettleScape on a server
## (Must be run as root.)

#TODO: Create minecraft user/group/home.
loginctl enable-linger minecraft ## Always keep a `minecraft` session open.

#TODO: Clone SettleScape repo, and copy files to `/etc/`.
