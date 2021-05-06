#!/bin/sh
## This script ensures that the `minecraft` folder is permissioned correctly.
. './env.sh'

## Go to the right directory
cd "$ENV_MC_HOME"

## Do the thing
chmod -Rc 'u+rw'      '.'
chown -Rc 'minecraft' '.'
chmod -Rc 'g+rw'      '.'
chgrp -Rc 'minecraft' '.'
chmod -Rc 'o-rwx'     '.'

## Special permissions
chmod  -c 'og-w' '.'
chmod -Rc  'g-w' '.ssh'
chmod  -c  'g-r' '.ssh'
#TODO: Exclude `.git` from all this somehow.

## Done
exit 0
