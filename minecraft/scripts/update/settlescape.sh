#!/bin/sh
. '../var/env.sh'
CWD=$(pwd)
cd "$ENV_SERVER_ROOT"
git pull
cd "$CWD"
exit 0
