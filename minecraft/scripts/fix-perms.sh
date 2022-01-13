#!/bin/sh
## This script ensures that the `minecraft` folder is permissioned correctly.
. './env.sh'

## Go to the right directory
set -e; cd "$ENV_MC_HOME"; set +e

## Generate list of paths to modify
declare -a PATHS=($(find . !-name ".git"))

## Set owner and group
chown -Rc 'minecraft' '.'
chgrp -Rc 'minecraft' '.'

## Set rwx
chmod  -c 'u+rw'      "${PATHS[@]}"
chmod  -c 'g+rw'      "${PATHS[@]}"
chmod  -c 'o-rwx'     "${PATHS[@]}"

## Special permissions
chmod  -c 'og-w' '.'
chmod -Rc  'g-w' '.ssh'
chmod  -c  'g-r' '.ssh'
chmod  -c 'go-rwx' $(find . -type f -name "*.key")

## Done
exit 0
