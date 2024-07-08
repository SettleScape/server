#!/usr/bin/env bash
## Defragments all fragmented ext# HDD partitions on the system.
set -e

## Configurable variables:
DRY_RUN=1
FRAGMENTATION_THRESHOLD=10
LOGFILE='/var/log/defragmentation.log'
NO_LOG=1

## Logging function
function log {
    if [[ -n "$NO_LOG" ]]; then
        echo "$1"
    else
        echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOGFILE"
    fi
}
echo >>> "$LOGFILE"

## Find all filesystems that are ext# and on an HDD.
log 'Looking for hard-drive ext# partitions...'
declare -a EXT_HDD_DEVICES=()
LSBLK_ENTRIES=$(lsblk -pro 'NAME,ROTA,FSTYPE' 2>/dev/null | tail -n +2)
while IFS= read -r ENTRY; do

    FSTYPE=$(echo "$ENTRY" | awk '{print $3}')
    [[ -z "$FSTYPE" || "$FSTYPE" != ext* ]] && continue

    ROTA=$(echo "$ENTRY" | awk '{print $2}')
    [[ "$ROTA" -eq 0 ]] && continue

    DEVICE=$(echo "$ENTRY" | awk '{print $1}')
    EXT_HDD_DEVICES+=("$DEVICE")

done <<< "$LSBLK_ENTRIES"
unset LSBLK_ENTRIES
[[ ${#EXT_HDD_DEVICES[@]} -eq 0 ]] && log 'No hard-drive ext# partitions found!' && exit 0

## For each HDD, check the fragmentation level.  If it is above the threshold, save it for further operation.
log 'Checking for fragmentation...'
declare -a FRAGMENTED_EXT_HDD_DEVICES=()
for DEVICE in "${EXT_HDD_DEVICES[@]}"; do

    FRAG_PERCENT=$(e4defrag -c "$DEVICE" | grep -oP '\d+(?=% fragmented)' | head -n 1)
    if [ "$FRAG_PERCENT" -ge "$FRAGMENTATION_THRESHOLD" ]; then
        FRAGMENTED_EXT_HDD_DEVICES+=("$DEVICE")
    fi

done
unset EXT_HDD_DEVICES
[[ ${#FRAGMENTED_EXT_HDD_DEVICES[@]} -eq 0 ]] && log 'No hard-drive ext# partition is fragmented!' && exit 0

## Exit now if a dry run
if [[ -n "$DRY_RUN" ]]; then
    log "Dry run enabled. The following devices would be defragmented: ${FRAGMENTED_EXT_HDD_DEVICES[*]}"
    exit 0
fi

## For each fragmented HDD, defragment asynchronously.
log 'Defragmenting...'
for DEVICE in "${FRAGMENTED_EXT_HDD_DEVICES[@]}"; do
    e4defrag "$DEVICE" 2>> "$LOGFILE" &
done
wait
unset FRAGMENTED_EXT_HDD_DEVICES
log 'Defragmentation complete!'

## Done.
exit $?
