#!/bin/sh
## This script configures the kernel commandline.
## (It must be run as root.)
grubby --update-kernel=ALL --args="zswap.enabled=1"
grubby --update-kernel=ALL --args="zswap.max_pool_percent=17"
grubby --update-kernel=ALL --args="zswap.zpool=z3fold" ## Ignored on Alma 9.
grubby --update-kernel=ALL --args="zswap.compressor=lz4" ## Ignored on Alma 9.
