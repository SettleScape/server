#!/bin/sh
set -e
. './env.sh'

## Variables
WHERE='../build'
REPO='go-paper-autoupdate'
 CWD=$(pwd)
BUILD_SCRIPT='build.bash'

## Do the thing
mkdir -p "$WHERE"
cd "$WHERE"
set +e; rm -rf "$REPO"; set -e
git clone "https://github.com/dada513/${REPO}.git"
cd "$REPO"
chmod +x "$BUILD_SCRIPT"
./"$BUILD_SCRIPT"
mv 'out/go-paper-autoupdate-linux-amd64' ~/.local/bin/
cd ..
rm -rf "$REPO"


## Cleanup
cd "$CWD"
exit 0
