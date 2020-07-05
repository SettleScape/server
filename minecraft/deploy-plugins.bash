#!/bin/bash
## This script requires the [[ double-brackets ]] of `bash` in order to run;
## so a conversion to POSIX `sh` is not straightforward.
set -e

## Handle paths
CWD=$(pwd)
TWD='plugins'
[[ ! "$CWD" == *"/$TWD" ]] && cd "./$TWD"

## Handle input
# INPUT=$@
[[ -z $INPUT ]] && INPUT=$(ls -A1 | grep '\.jar$')

## Send specified plugins to the server
for PLUGIN in $INPUT; do
    [[ ! "$PLUGIN" == *'.jar' ]] && PLUGIN="${PLUGIN}.jar"
    scp "$PLUGIN" "minecraft@settlescape:/srv/minecraft/settlescape/minecraft/$TWD"
done

## Cleanup
cd "$CWD"
exit 0
