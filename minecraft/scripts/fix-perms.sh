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
chmod -Rc 'g-rw' '.ssh'

## Done 
exit 0
