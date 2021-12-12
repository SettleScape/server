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

## Figure out which Java to use.  (Proprietary Java preferred.)
declare -i I=1
until [[ -f "$JAVA" ]]; do
    case $I in
    1) JAVA="/lib/jvm/java-${ENV_JAVA_VERSION}-jdk/jre/bin/java"     ;;
    2) JAVA="/lib/jvm/java-${ENV_JAVA_VERSION}-openjdk/jre/bin/java" ;;
    3) JAVA="/lib/jvm/jre-${ENV_JAVA_VERSION}-openjdk/bin/java"      ;;
    ## If none of the above worked, try using the system's default java.
    *) JAVA=`which java` ;;
    esac
    I=`expr $I + 1`
done
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
