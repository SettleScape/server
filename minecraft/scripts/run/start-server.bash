#!/bin/bash
function documentation {
    echo 'Starts up the SettleScape Minecraft server.'
    echo '  -d  Run as a daemon'
    echo '  -i  Run interactively'
    echo '  -h  Print this helptext'
}

## Check input
case "$1" in
    '-d') DAEMON=1                ;;
    '-i') INTERACTIVE=1           ;;
    '-h') documentation && exit 0 ;;
       *) documentation && exit 1 ;;
esac

## Preliminaries
set -e
source '../var/env.sh'
cd "$ENV_SERVER_ROOT"

## Workarounds
set +e
rm 'plugins/EisenRadar/lang/en_us.lang'
rm 'plugins/EisenRadar/lang/de_de.lang'
set -e

## Figure out which Java to use.
## Do not use Java SE (Oracle's version) versions 11-16, as those require a hefty fee to use in production.
## Java SE should otherwise be preferred, as unlike OpenJDK, it continues to update old versions after the release of a new one.
declare -i I=0
unset JAVA_HOME
until [[ -f "$JAVA_HOME/java" ]]; do
    case $I in
    0) JAVA_HOME="$ENV_JAVA_DIR/bin" ;;
    1) echo "No Java found in '$ENV_JAVA_DIR'.  Please download Java v$ENV_JAVA_VERSION and place it at that path, or SettleScape may not run correctly." >&2 ;;
    ## If the custom Java path is missing, try looking for common system paths.
    2) JAVA_HOME="/lib/jvm/java-${ENV_JAVA_VERSION}-jdk/jre/bin" ;;
    3) JAVA_HOME="/lib/jvm/java-${ENV_JAVA_VERSION}-openjdk/jre/bin" ;;
    4) JAVA_HOME="/lib/jvm/jre-${ENV_JAVA_VERSION}-openjdk/bin" ;;
    ## If none of the above worked, try using the system's default java.
    *) JAVA_HOME=`which java | sed -r 's/\/java$//'` ;;
    esac
    I=`expr $I + 1`
done
export JAVA_HOME JRE_HOME="$JAVA_HOME"
# echo "$JAVA_HOME" && exit 1

## Get Java opts
source "$ENV_SERVER_ROOT/scripts/var/java-opts.bash"
# echo "$JAVA_OPTS" && exit 1

## Start the server
declare -a CMD=(
    -mS "$ENV_SCREEN_NAME"
    "$JAVA_HOME/java" $JAVA_OPTS -jar
    "$ENV_SERVER_JAR" --nogui #--forceUpgrade
)
if [[ ! -z $DAEMON ]]
then exec screen -D "${CMD[@]}"
else      screen -d "${CMD[@]}"
fi
#NOTE: Type `screen -r 'SettleScape'` to attach to the SettleScape screen.
#NOTE: Press Ctrl+A, Ctrl+D to detatch from the SettleScape screen.
#NOTE: Type `screen -S 'SettleScape' -X stuff "$COMMAND\n"` to send a command to the SettleScape screen.
if [[ ! -z $INTERACTIVE ]]
then exec screen -r "$ENV_SCREEN_NAME"
else exit 0
fi
