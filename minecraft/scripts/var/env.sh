#!/bin/sh
## This script just exports variables needed by other scripts.

## User variables
export ENV_MC_HOME='/srv/minecraft'

## Minecraft variables
export ENV_SCREEN_NAME='SettleScape'
export ENV_SERVER_JAR='server.jar'
export ENV_SERVER_ROOT="$ENV_MC_HOME/settlescape/minecraft"
export ENV_VERSION='1.17.1'

## Java variables
export ENV_JAVA_VERSION='17'
export ENV_JAVA_DIR="$ENV_SERVER_ROOT/../java"

## Other
export ENV_PAPERUPD_BIN="$ENV_SERVER_ROOT/paper-autoupdater"
export ENV_MC_CMD="screen -S "$ENV_SCREEN_NAME" -X stuff"
