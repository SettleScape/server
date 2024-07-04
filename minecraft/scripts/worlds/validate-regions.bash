#!/usr/bin/env bash
## Identifies regions outside the world bounds.

declare -i MIN_X=-6
declare -i MAX_X=18
declare -i MIN_Z=-14
declare -i MAX_Z=10

shopt -s nullglob
for F in r.*.*.mca; do
    [[ "$F" =~ ^r\.(-?[0-9])+\.(-?[0-9])\.mca$ ]] || continue
    declare -i X=${BASH_REMATCH[1]}
    declare -i Z=${BASH_REMATCH[2]}
    (( X < MIN_X || X > MAX_X || Z < MIN_Z || Z > MAX_Z )) && echo "$F"
done | LC_COLLATE=C sort | xargs
exit 0
