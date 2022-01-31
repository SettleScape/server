#!/bin/sh
## Builds a program that can be used to painlessly update PaperMC to the latest version.
set -e
. '../var/env.sh'

## Variables
WHERE='build'
REPO='go-paper-autoupdate'
 CWD=$(pwd)
BUILD_SCRIPT='build.bash'

## Do the thing
mkdir -p "$WHERE"
cd "$WHERE"
set +e; rm -rf "$REPO"; set -e
git clone "https://github.com/dada513/$REPO.git"
cd "$REPO"
chmod +x "$BUILD_SCRIPT"
./"$BUILD_SCRIPT"
set +e; mkdir -p $(echo "$ENV_PAPERUPD_BIN" | sed -r 's/\/[^/]+?$//'); set -e
mv 'out/paper-autoupdater.bin' "$ENV_PAPERUPD_BIN"
cd ..
rm -rf "$REPO"

## Cleanup
cd "$CWD"
rmdir "$WHERE"
exit 0
