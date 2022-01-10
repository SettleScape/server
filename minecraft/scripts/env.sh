#!/bin/sh
## This script just exports variables needed by other scripts.

## User variables
export ENV_MC_HOME='/srv/minecraft'

## Minecraft variables
export ENV_SCREEN_NAME='SettleScape'
export ENV_SERVER_JAR='server.jar'
export ENV_SERVER_ROOT='..'
export ENV_VERSION='1.16.5'

## Java variables
export ENV_JAVA_VERSION='16'
export ENV_JAVA_DIR="$ENV_SERVER_ROOT/java"

## Other
export ENV_PAPERUPD_BIN="$HOME/.local/bin/paper-autoupdater"