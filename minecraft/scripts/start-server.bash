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
declare -i I=4
until [[ -f "$JAVA" ]]; do
    case $I in
    ## Java 8 is an LTS release.
    1) JAVA='/lib/jvm/java-8-jdk/jre/bin/java'     ;;
    2) JAVA='/lib/jvm/java-8-openjdk/jre/bin/java' ;;
    3) JAVA='/lib/jvm/jre-8-openjdk/bin/java'      ;;
    ## Java 11 is an LTS release.
    4) JAVA='/lib/jvm/java-11-jdk/bin/java'     ;;
    5) JAVA='/lib/jvm/java-11-openjdk/bin/java' ;;
    6) JAVA='/lib/jvm/jre-11-openjdk/bin/java'  ;;
    ## Java 17 is an LTS release.
    7) JAVA='/lib/jvm/java-17-jdk/bin/java'     ;;
    8) JAVA='/lib/jvm/java-17-openjdk/bin/java' ;;
    9) JAVA='/lib/jvm/jre-17-openjdk/bin/java'  ;;
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
