#!/usr/bin/env sh
SERVER_JAR='./server.jar'

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

## Aikar's tuned server options.
## https://aikar.co/2018/07/02/tuning-the-jvm-g1gc-garbage-collector-flags-for-minecraft
# AIKAR_OPTS=$(echo                          \
#     '-Xms6G'                               \
#     '-Xmx6G'                               \
#     '-XX:+UnlockExperimentalVMOptions'     \
#     '-XX:+AlwaysPreTouch'                  \
#     '-XX:+ParallelRefProcEnabled'          \
#     '-XX:+DisableExplicitGC'               \
#     '-XX:+UseG1GC'                         \
#     '-XX:G1MixedGCLiveThresholdPercent=35' \
#     '-XX:G1NewSizePercent=50'              \
#     '-XX:G1MaxNewSizePercent=80'           \
#     '-XX:TargetSurvivorRatio=90'           \
#     '-XX:MaxGCPauseMillis=100'             \
#     '-Dusing.aikars.flags=mcflags.emc.gs'  \
# | xargs)

## Mixes the above options.
## The percentages in these flags have been changed from their original values to better-align with duodecimal percentages.
JAVA_OPTS=$(echo                           \
    '-Xmx2G'                               \
    '-XX:+UnlockExperimentalVMOptions'     \
    '-XX:+AlwaysPreTouch'                  \
    '-XX:+ParallelRefProcEnabled'          \
    '-XX:+DisableExplicitGC'               \
    '-XX:+UseG1GC'                         \
    '-XX:G1HeapRegionSize=32M'             \
    '-XX:G1ReservePercent=25'              \
    '-XX:G1NewSizePercent=33'              \
    '-XX:G1MaxNewSizePercent=75'           \
    '-XX:G1MixedGCLiveThresholdPercent=33' \
    '-XX:TargetSurvivorRatio=92'           \
    '-XX:MaxGCPauseMillis=50'              \
    '-Dusing.aikars.flags=mcflags.emc.gs'  \
| xargs)
# echo $JAVA_OPTS && exit

##BUG: TownyFlight's colors seem to get saved in a corrupted state on server restarts.  We need to reset the file before starting the server in order for it to display right.
git checkout plugins/TownyFlight/config.yml

## Start the server
exec screen -d -m -S "Minecraft Server" \
java $JAVA_OPTS -jar "$SERVER_JAR"
