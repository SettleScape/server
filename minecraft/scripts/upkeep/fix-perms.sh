#!/bin/sh
## This script ensures that the `minecraft` folder is permissioned correctly.
. '.env'

## Go to the right directory
set -e; cd "$ENV_MC_HOME"; set +e

## Set owner and group
chown -Rc 'minecraft' '.'
chgrp -Rc 'minecraft' '.'

## Set rwx carefully (very slow)
#declare -a PATHS=($(find . ! -wholename "*/.git/*")) ## Generate list of paths to modify
#for EACH in "${PATHS[@]}"; do
#	chmod -c 'u+rw'      "$EACH"
#	chmod -c 'g+rw'      "$EACH"
#	chmod -c 'o-rwx'     "$EACH"
#done

## Set rwx quickly
chmod -Rc 'u+rw'  '.'
chmod -Rc 'g+rw'  '.'
chmod -Rc 'o-rwx' '.'

## Special permissions
chmod  -c 'og-w' '.'
chmod -Rc  'g-w' '.ssh'
chmod  -c  'g-r' '.ssh'
chmod  -c 'go-rwx'      $(find . -type f -name "*.key")
#TODO:  Treat folders named "rsa" the same as ".ssh"

## Done
exit 0
