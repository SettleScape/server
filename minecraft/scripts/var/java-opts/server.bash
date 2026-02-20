#!/bin/bash
## Configures the JVM.

## Aikar's server options:
## * https://docs.papermc.io/paper/aikars-flags
## * https://aikar.co/2018/07/02/tuning-the-jvm-g1gc-garbage-collector-flags-for-minecraft
##
## BruceTheMoose's server options:
## * https://github.com/Mukul1127/Minecraft-Performance-Flags-Benchmarks
##
## Overview of transparent huge pages:
## * https://alexandrnikitin.github.io/blog/transparent-hugepages-measuring-the-performance-impact

## My personal collection of Java Opts:
declare -a SERVER_JAVA_OPTS=(
    '-XX:+UnlockExperimentalVMOptions'
    '-XX:+UnlockDiagnosticVMOptions'

    ## Memory Settings
    '-Xms1536M'
    '-Xmx1536M'
    '-XX:+AlwaysPreTouch'
    '-XX:+UseTransparentHugePages'
    # '-XX:+UseLargePagesInMetaspace' ## Fails when I try it.
    '-XX:AllocatePrefetchStyle=3' #NOTE: Breaks ZGC and Shenandoah; fine for G1GC.
    '-XX:InitiatingHeapOccupancyPercent=10'

    ## Misc
    '-XX:+AlwaysActAsServerClassMachine'
    '-XX:+ParallelRefProcEnabled'
    '-XX:+PerfDisableSharedMem'
    '-XX:+UseVectorCmov'
    '-XX:+UseFastUnorderedTimeStamps'
    '-XX:+UseCriticalJavaThreadPriority'
    # '-XX:ThreadPriorityPolicy=1' ## Requires `sudo` on Linux.

    ## GC settings
    '-XX:+DisableExplicitGC'
    '-XX:GCTimeRatio=50' ## Compromise value;  needs tuning.
    '-XX:MaxGCPauseMillis=130'
    '-XX:MaxTenuringThreshold=1'
    '-XX:SurvivorRatio=32'
    '-XX:TargetSurvivorRatio=92'

    ## G1GC settings
    '-XX:+UseG1GC'
    '-XX:G1HeapRegionSize=16M'
    '-XX:G1HeapWastePercent=18'
    '-XX:G1MixedGCCountTarget=3'
    '-XX:G1MixedGCLiveThresholdPercent=90'
    '-XX:G1ReservePercent=20'
    '-XX:G1NewSizePercent=28'
    '-XX:G1MaxNewSizePercent=38'
    '-XX:G1RSetUpdatingPauseTimePercent=0'
    '-XX:G1SATBBufferEnqueueingThresholdPercent=30'
    '-XX:G1ConcMarkStepDurationMillis=5'
    '-XX:G1ConcRefinementServiceIntervalMillis=150'
    '-XX:G1ConcRSHotCardLimit=16'

    ## Code optimizations
    '-XX:-DontCompileHugeMethods'
    '-XX:MaxNodeLimit=240000'
    '-XX:NodeLimitFudgeFactor=8000'
    '-XX:+UseStringDeduplication' ## Only when memory-constrained
    ## Skip the below when low on memory:
    '-XX:NmethodSweepActivity=1'
    '-XX:ReservedCodeCacheSize=400M'
    '-XX:NonNMethodCodeHeapSize=12M'
    '-XX:ProfiledCodeHeapSize=194M'
    '-XX:NonProfiledCodeHeapSize=194M'

    ## GraalVM (irrelevant, as we aren't using GraalVM)
    '-XX:+EagerJVMCI'
    '-Dgraal.LoopRotation=true'
    '-Dgraal.TuneInlinerExploration=1'

    ## Reporting
    '-Dusing.aikars.flags=https://mcflags.emc.gs'
    '-Daikars.new.flags=true'
    "-Xlog:gc*,gc+heap=info:file=./gc-logs/$(date +'%Y-%m-%d_%H-%M-%S').log:time,uptime,level,tags"

    ## Security
    '-Dlog4j2.formatMsgNoLookups=true'
)

## Export to the environment
export JAVA_OPTS="${SERVER_JAVA_OPTS[@]}"
