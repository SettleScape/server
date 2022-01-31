#!/bin/sh
. '.env'
CWD=$(pwd)
cd "$ENV_SERVER_ROOT"
git pull
cd "$CWD"
exit 0
