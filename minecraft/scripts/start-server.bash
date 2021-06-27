#!/bin/bash
source './env.sh'

## Helptext
function helptext {
    echo 'Starts up the SettleScape Minecraft server.'
    echo '  -d  Run as a daemon'
    echo '  -i  Run interactively'
    echo '  -h  Print this helptext'
}

## Check input
case "$1" in
    '-d') DAEMON=1           ;;
    '-i') INTERACTIVE=1      ;;
    '-h') helptext && exit 0 ;;
       *) helptext && exit 1 ;;
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

## Official 1.14.4 client options.
# VANILLA_OPTS=$(echo                    \
#     '-Xmx2G'                           \
#     '-XX:+UnlockExperimentalVMOptions' \
#     '-XX:+UseG1GC'                     \
#     '-XX:G1NewSizePercent=20'          \
#     '-XX:G1ReservePercent=20'          \
#     '-XX:MaxGCPauseMillis=50'          \
#     '-XX:G1HeapRegionSize=32M'         \
# | xargs)

## Aikar's tuned server options. (updated 2020)
## https://aikar.co/2018/07/02/tuning-the-jvm-g1gc-garbage-collector-flags-for-minecraft
# AIKAR_OPTS=$(echo                                 \
#     '-Xms10G'                                     \
#     '-Xmx10G'                                     \
#     '-XX:+UseG1GC'                                \
#     '-XX:+ParallelRefProcEnabled'                 \
#     '-XX:MaxGCPauseMillis=200'                    \
#     '-XX:+UnlockExperimentalVMOptions'            \
#     '-XX:+DisableExplicitGC'                      \
#     '-XX:+AlwaysPreTouch'                         \
#     '-XX:G1NewSizePercent=30'                     \
#     '-XX:G1MaxNewSizePercent=40'                  \
#     '-XX:G1HeapRegionSize=8M'                     \
#     '-XX:G1ReservePercent=20'                     \
#     '-XX:G1HeapWastePercent=5'                    \
#     '-XX:G1MixedGCCountTarget=4'                  \
#     '-XX:InitiatingHeapOccupancyPercent=15'       \
#     '-XX:G1MixedGCLiveThresholdPercent=90'        \
#     '-XX:G1RSetUpdatingPauseTimePercent=5'        \
#     '-XX:SurvivorRatio=32'                        \
#     '-XX:+PerfDisableSharedMem'                   \
#     '-XX:MaxTenuringThreshold=1'                  \
#     '-Dusing.aikars.flags=https://mcflags.emc.gs' \
#     '-Daikars.new.flags=true'                     \
# | xargs)

## Mixes the above options, and adds some custom tweaks.
JAVA_OPTS=$(echo \
    '-Xms2G'     \
    '-Xmx2G'     \
    \
    '-XX:+UnlockExperimentalVMOptions' \
    '-XX:+AlwaysPreTouch'              \
    '-XX:+UseLargePagesInMetaspace'    \
    '-XX:+ParallelRefProcEnabled'      \
    '-XX:+PerfDisableSharedMem'        \
    '-XX:+DisableExplicitGC'           \
    '-XX:+UseG1GC'                     \
    \
    '-XX:G1HeapRegionSize=8M'              \
    '-XX:G1HeapWastePercent=4'             \
    '-XX:G1MixedGCCountTarget=4'           \
    '-XX:G1MixedGCLiveThresholdPercent=92' \
    '-XX:G1ReservePercent=21'              \
    '-XX:G1NewSizePercent=33'              \
    '-XX:G1MaxNewSizePercent=42'           \
    '-XX:G1RSetUpdatingPauseTimePercent=4' \
    \
    '-XX:InitiatingHeapOccupancyPercent=17' \
    '-XX:MaxGCPauseMillis=200'              \
    '-XX:MaxTenuringThreshold=1'            \
    '-XX:SurvivorRatio=33'                  \
    '-XX:TargetSurvivorRatio=92'            \
    \
    '-Dusing.aikars.flags=https://mcflags.emc.gs' \
    '-Daikars.new.flags=true'                     \
| xargs)
# echo $JAVA_OPTS && exit

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
