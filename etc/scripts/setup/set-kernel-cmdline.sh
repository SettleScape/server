#!/bin/sh
## This script configures the kernel commandline.
## (It must be run as root.)
grubby --update-kernel=ALL --args="zswap.enabled=1"
grubby --update-kernel=ALL --args="zswap.max_pool_percent=5" ## 5% is the highest percent that guarantees at least 1GiB of RAM is available for the system after Minecraft (2.652271GiB * 0.05 == 2.51965745GiB, 2.51965745GiB - 1.5GiB == 1.01965745GiB)
grubby --update-kernel=ALL --args="zswap.zpool=z3fold" ## Ignored on RHEL 9.
grubby --update-kernel=ALL --args="zswap.compressor=lz4" ## Ignored on RHEL 9.
