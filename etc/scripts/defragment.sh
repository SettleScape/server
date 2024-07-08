#!/usr/bin/env bash
## Defragments all HDD partitions on the system
set -e

## Configurable variables:
FRAGMENTATION_THRESHOLD=10

## Find all filesystems that are mounted and on an HDD.
declare -a MOUNTED_HDD_DEVICES=()
LSBLK_ENTRIES=$(lsblk -d -o 'name,mountpoint,rota' 2>/dev/null) #TODO: Remove the first line of the output
for ENTRY in "$LSBLK_ENTRIES"; do
    #TODO: Use awk to get the third field.  If 0, continue.
    #TODO: Use awk to get the second field.  If empty, continue.
    #TODO: Use awk to get the first field, and save it in MOUNTED_HDD_DEVICES.
done
unset LSBLK_ENTRIES

## For each HDD, check the fragmentation level.  If it is above the threshold, save it for further operation.
declare -a FRAGMENTED_MOUNTED_HDD_DEVICES=()
for DEVICE in "${MOUNTED_HDD_DEVICES[@]}"; do
    e4defrag -c "$DEVICE" #TODO: Isolate the fragmentation percentage from this output.  If it is equal to or above FRAGMENTATION_THRESHOLD, save the device in FRAGMENTED_MOUNTED_HDD_DEVICES.
done
unset MOUNTED_HDD_DEVICES

## For each fragmented HDD, defragment asynchronously.
for DEVICE in "${FRAGMENTED_MOUNTED_HDD_DEVICES[@]}"; do
    e4defrag "$DEVICE" #TODO: Save errors to a log file.
done
unset FRAGMENTED_MOUNTED_HDD_DEVICES

## Done.
exit $?
