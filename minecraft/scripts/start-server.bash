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

## Figure out which Java to use.
## Do not use Java SE (Oracle's version) versions 11-16, as those require a hefty fee to use in production.
## Java SE should otherwise be preferred, as unlike OpenJDK, it continues to update old versions after the release of a new one. 
declare -i I=0
until [[ -f "$JAVA" ]]; do
    case $I in
    0) JAVA="$ENV_JAVA_PATH"                                         ;;
    1) echo "No Java found at '$JAVA'.  Please download Java v$ENV_JAVA_VERSION and place it at that path, or SettleScape may not run correctly." >&2 ;;
    2) JAVA="/lib/jvm/java-${ENV_JAVA_VERSION}-jdk/jre/bin/java"     ;;
    3) JAVA="/lib/jvm/java-${ENV_JAVA_VERSION}-openjdk/jre/bin/java" ;;
    4) JAVA="/lib/jvm/jre-${ENV_JAVA_VERSION}-openjdk/bin/java"      ;;
    ## If none of the above worked, try using the system's default java.
    *) JAVA=`which java` ;;
    esac
    I=`expr $I + 1`
done
export JAVA_HOME="$JAVA/bin"
export JRE_HOME="$JAVA_HOME"
# echo "$JAVA" && exit 1

## Get variables
source './env.sh'
source './java-opts.bash'
# echo "$JAVA_OPTS" && exit 1

## Start the server
cd "$ENV_SERVER_ROOT"
declare -a CMD=(
    -mS "$ENV_SCREEN_NAME"
    "$JAVA" $JAVA_OPTS -jar
    "./$ENV_SERVER_JAR" --nogui #--forceUpgrade
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
