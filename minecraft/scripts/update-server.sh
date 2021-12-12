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
        mv spigot*.jar "$ENV_SERVER_JAR"
    ;;

    'paper')
#       declare -i API_VERSION=2
#       case API_VERSION in
#           1)  ## Removed because the Paper devs are retarded.
#               curl -o "$ENV_SERVER_JAR" "https://papermc.io/api/v1/paper/${ENV_VERSION}/latest/download"
#           ;;
#           2)  ## Requires running `build-updater.sh` at least once.
                ~/.local/bin/go-paper-autoupdate-linux-amd64 'paper' "$ENV_VERSION"
                mv "paper-${ENV_VERSION}.jar" "$ENV_SERVER_JAR"
#           ;;
#       esac
    ;;
esac

## Cleanup
cd "$CWD"
exit 0
