#!/bin/sh

## Enable zswap as a hot cache
grubby --update-kernel=ALL --args="zswap.enabled=1"
grubby --update-kernel=ALL --args="zswap.max_pool_percent=17"
grubby --update-kernel=ALL --args="zswap.zpool=z3fold" ## Ignored on Alma 9.
grubby --update-kernel=ALL --args="zswap.compressor=lz4" ## Ignored on Alma 9.

## Enable zram swap as a cold cache
dnf install -y zram-generator
systemctl start dev-zram0.swap

echo 'If your `sysctl.d` files do not already do so, you should have them configure `vm.swappiness=134` and `vm.page-cluster=0`. '
