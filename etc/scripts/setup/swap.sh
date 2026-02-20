#!/bin/sh

## Enable zswap as a hot cache
grubby --update-kernel=ALL --args="zswap.enabled=1"
grubby --update-kernel=ALL --args="zswap.max_pool_percent=17"
grubby --update-kernel=ALL --args="zswap.zpool=zsmalloc"
grubby --update-kernel=ALL --args="zswap.compressor=lz4" ## Ignored on Alma 9.

## Enable zram swap as a cold cache
dnf install -y zram-generator
cp -a /srv/minecraft/settlescape/etc/systemd/zram-generator.conf.d /etc/systemd/
systemctl start dev-zram0.swap

## Enable on-disk swap as a last resort
fallocate -l 1G /zram0.writeback
losetup -fP /zram0.writeback
echo 'Add this to `/etc/fstab`: `/zram0.writeback none loop 0 0`'

## Configure sysctl
echo 'If your `sysctl.d` files do not already do so, you should have them configure `vm.swappiness=134` and `vm.page-cluster=0`. '
