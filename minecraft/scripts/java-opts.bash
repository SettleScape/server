#!/bin/bash
## Configures the JVM.

## Official 1.14.4 client options.
declare -a VANILLA_JAVA_OPTS=(
    '-Xmx2G'
    '-XX:+UnlockExperimentalVMOptions'
    '-XX:+UseG1GC'
    '-XX:G1NewSizePercent=20'
    '-XX:G1ReservePercent=20'
    '-XX:MaxGCPauseMillis=50'
    '-XX:G1HeapRegionSize=32M'
)

## Aikar's tuned server options. (updated 2020)
## https://aikar.co/2018/07/02/tuning-the-jvm-g1gc-garbage-collector-flags-for-minecraft
declare -a AIKARS_JAVA_OPTS=(
    '-Xms10G'
    '-Xmx10G'
    '-XX:+UseG1GC'
    '-XX:+ParallelRefProcEnabled'
    '-XX:MaxGCPauseMillis=200'
    '-XX:+UnlockExperimentalVMOptions'
    '-XX:+DisableExplicitGC'
    '-XX:+AlwaysPreTouch'
    '-XX:G1NewSizePercent=30'
    '-XX:G1MaxNewSizePercent=40'
    '-XX:G1HeapRegionSize=8M'
    '-XX:G1ReservePercent=20'
    '-XX:G1HeapWastePercent=5'
    '-XX:G1MixedGCCountTarget=4'
    '-XX:InitiatingHeapOccupancyPercent=15'
    '-XX:G1MixedGCLiveThresholdPercent=90'
    '-XX:G1RSetUpdatingPauseTimePercent=5'
    '-XX:SurvivorRatio=32'
    '-XX:+PerfDisableSharedMem'
    '-XX:MaxTenuringThreshold=1'
    '-Dusing.aikars.flags=https://mcflags.emc.gs'
    '-Daikars.new.flags=true'
)

## Mixes the above options, and adds some custom tweaks.
declare -a CUSTOM_JAVA_OPTS=(
    '-Xms1536M'
    '-Xmx1536M'

    '-XX:+UnlockExperimentalVMOptions'
    '-XX:+AlwaysPreTouch'
    '-XX:+UseLargePagesInMetaspace'
    '-XX:+ParallelRefProcEnabled'
    '-XX:+PerfDisableSharedMem'
    '-XX:+DisableExplicitGC'
    '-XX:+UseG1GC'

    '-XX:G1HeapRegionSize=8M'
    '-XX:G1HeapWastePercent=4'
    '-XX:G1MixedGCCountTarget=4'
    '-XX:G1MixedGCLiveThresholdPercent=92'
    '-XX:G1ReservePercent=21'
    '-XX:G1NewSizePercent=33'
    '-XX:G1MaxNewSizePercent=42'
    '-XX:G1RSetUpdatingPauseTimePercent=4'

    '-XX:InitiatingHeapOccupancyPercent=17'
    '-XX:MaxGCPauseMillis=200'
    '-XX:MaxTenuringThreshold=1'
    '-XX:SurvivorRatio=33'
    '-XX:TargetSurvivorRatio=92'

    '-Dusing.aikars.flags=https://mcflags.emc.gs'
    '-Daikars.new.flags=true'
)

export JAVA_OPTS="${CUSTOM_JAVA_OPTS[@]}"
