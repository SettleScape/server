#!/bin/bash
## This script removes old files to save space.
source '../var/env.sh'
CWD="$(pwd)"

## Variables.
declare -a DIRS=(
    '.'
    'logs' 
    'crash-reports' 
    'plugins/AuctionHouse/logs' 
    'plugins/CommandLog' 
    'plugins/mcMMO/backup' 
    'plugins/Towny/backup' 
)
declare -a EXTS=(
    '.log'
    '.log.gz' 
    '.txt' 
    '.log' 
    '.txt' 
    '.zip' 
    '.tar.gz' 
)

## Do the thing.
cd "$ENV_SERVER_ROOT"
declare -i I=0
while [[ I -lt ${#DIRS[@]} && I -lt ${#EXTS[@]} ]]; do
    if [[ -d "${DIRS[I]}" ]]; then

        ## Go to the target directory and print a summary of what files will be deleted.
        cd "${DIRS[I]}"
        printf "\n\033[1m$(pwd)/*${EXTS[I]}\033[0m\n"

        ## Delete files older than 7 days.
        find . -type f -mtime +7 |\
        grep "\\${EXTS[I]}$" |\
        xargs rm -fv

        ## Done.
        cd "$ENV_SERVER_ROOT"
    fi
    I=$I+1
done

## Done
cd "$CWD"
exit 0
