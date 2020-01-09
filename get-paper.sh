#!/usr/bin/env sh
set -e

## Variables
 OUTJAR='server.jar'
VERSION='1.14.4'

## Do the thing
curl -o "$OUTJAR" "https://papermc.io/api/v1/paper/${VERSION}/latest/download"
exit 0
