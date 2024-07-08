#!/usr/bin/env bash
## Defragments all HDD partitions on the system
set -e

## Configurable variables:
FRAGMENTATION_THRESHOLD=10
LOGFILE='/var/log/defragmentation.log'

## Find all filesystems that are mounted and on an HDD.
declare -a MOUNTED_HDD_DEVICES=()
LSBLK_ENTRIES=$(lsblk -pro 'NAME,ROTA,MOUNTPOINT' 2>/dev/null | tail -n +2)
while IFS= read -r ENTRY; do

    MOUNTPOINT=$(echo "$ENTRY" | awk '{print $3}')
    [[ -z "$MOUNTPOINT" ]] && continue

    ROTA=$(echo "$ENTRY" | awk '{print $2}')
    [[ "$ROTA" -eq 0 ]] && continue

    DEVICE=$(echo "$ENTRY" | awk '{print $1}')
    MOUNTED_HDD_DEVICES+=("$DEVICE")

done <<< "$LSBLK_ENTRIES"
unset LSBLK_ENTRIES

## For each HDD, check the fragmentation level.  If it is above the threshold, save it for further operation.
declare -a FRAGMENTED_MOUNTED_HDD_DEVICES=()
for DEVICE in "${MOUNTED_HDD_DEVICES[@]}"; do

    FRAG_PERCENT=$(e4defrag -c "$DEVICE" | grep -oP '\d+(?=% fragmented)' | head -n 1)
    if [ "$FRAG_PERCENT" -ge "$FRAGMENTATION_THRESHOLD" ]; then
        FRAGMENTED_MOUNTED_HDD_DEVICES+=("$DEVICE")
    fi

done
unset MOUNTED_HDD_DEVICES

## For each fragmented HDD, defragment asynchronously.
for DEVICE in "${FRAGMENTED_MOUNTED_HDD_DEVICES[@]}"; do
    e4defrag "$DEVICE" 2>> "$LOGFILE" &
done
wait
unset FRAGMENTED_MOUNTED_HDD_DEVICES

## Done.
exit $?
