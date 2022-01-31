#!/bin/bash
## This script requires the [[ double-brackets ]] of `bash` in order to run;
## so a conversion to POSIX `sh` is not straightforward.
set -e
source '.env'

## Handle paths
TWD="$ENV_SERVER_ROOT/plugins"
CWD=$(pwd)
[[ ! "$CWD" == "$TWD" ]] && cd "$TWD"

## Receive input
# declare -a INPUT=$@
[[ -z $INPUT ]] && INPUT=$(ls -A1 | grep '\.jar$')

## Validate 
declare -a PLUGINS=()
for PLUGIN in $INPUT; do
    [[ ! "$PLUGIN" == *'.jar' ]] && PLUGIN="${PLUGIN}.jar"
    PLUGINS+=("$PLUGIN")
    unset PLUGIN
done
unset INPUT

## Send specified plugins to the server
scp "${PLUGINS[@]}" "minecraft@settlescape.org:$TWD/"
unset PLUGINS

## Cleanup
cd "$CWD"
unset CWD TWD
exit 0
