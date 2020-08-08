#!/bin/sh
set -e
. './env.sh'

## Variables
TYPE='paper'
 CWD=$(pwd)

## Do the thing
cd "$ENV_SERVER_ROOT"
case "$TYPE" in

    'bukkit')
        #TODO
    ;;

    'spigot')

        ## Variables
        BUILDDIR='build'
        BUILDJAR='BuildTools.jar'

        ## Prepare build directory
        rm    -rf "$BUILDDIR" 2> /dev/null
        mkdir -p  "$BUILDDIR" 2> /dev/null
        cd        "$BUILDDIR"

        ## Perform the build
        curl -o "$BUILDJAR" 'https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar'
        java -jar "$BUILDJAR" --rev "$ENV_VERSION"

        ## Deploy the new JAR
        mv spigot*.jar "../$ENV_SERVER_JAR"
    ;;

    'paper')
        curl -o "$ENV_SERVER_JAR" "https://papermc.io/api/v1/paper/${ENV_VERSION}/latest/download"
    ;;
esac

## Cleanup
cd "$CWD"
exit 0
