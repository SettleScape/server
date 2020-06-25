#!/usr/bin/env sh
set -e

## Variables
   TYPE='paper'
 OUTJAR='server/server.jar'
VERSION='1.15.2'

## Do the thing
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
        java -jar "$BUILDJAR" --rev "$VERSION"

        ## Deploy the new JAR
        mv spigot*.jar "../$OUTJAR"
    ;;

    'paper')
        curl -o "$OUTJAR" "https://papermc.io/api/v1/paper/${VERSION}/latest/download"
    ;;
esac

## Cleanup
exit 0
