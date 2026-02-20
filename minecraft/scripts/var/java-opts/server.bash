#!/bin/bash
## Configures the JVM.

## PaperMC's suggested options:
## * https://docs.papermc.io/paper/aikars-flags
##
## Aikar's server options: (Superceded by PaperMC's guide)
## * https://docs.papermc.io/paper/aikars-flags
## * https://aikar.co/2018/07/02/tuning-the-jvm-g1gc-garbage-collector-flags-for-minecraft
##
## BruceTheMoose's server options: (Superceded by PaperMC's guide)
## * https://github.com/Mukul1127/Minecraft-Performance-Flags-Benchmarks
##
## JewishLewish's flags:
## * https://github.com/JewishLewish/minecraft-aikar-flags-optimization/blob/main/README.md
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
    '-XX:+UseTransparentHugePages' ## Our `enabled` is set to `madvise` and our `defrag` is set to `defer+madvise`.
    '-XX:+UseLargePages'
    '-XX:AllocatePrefetchStyle=3' #NOTE: Breaks ZGC and Shenandoah; fine for G1GC.
    '-XX:InitiatingHeapOccupancyPercent=15'
    '-XX:+UseStringDeduplication' ## Trades higher CPU use for reduced memory consumption. We're unfortunately low on both.

    ## Misc
    '-XX:+AlwaysActAsServerClassMachine'
    '-XX:+ParallelRefProcEnabled'
    '-XX:+PerfDisableSharedMem'
    # '-XX:ThreadPriorityPolicy=1' ## Requires `sudo` on Linux, ergo not worth.
    '-XX:+UseAdaptiveSizePolicy'
    '-XX:+UseCompressedOops'
    '-XX:+UseCriticalJavaThreadPriority'
    '-XX:+UseFastAccessorMethods'
    '-XX:+UseFastUnorderedTimeStamps'
    '-XX:+UseTLAB'
    '-XX:+UseVectorCmov'

    ## GC settings
    '-XX:+DisableExplicitGC'
    # '-XX:GCTimeRatio=50' ## This fights `MaxGCPauseMillis`. It is better to set Millis and let Ratio be dynamic.
    '-XX:MaxGCPauseMillis=100' ## This is a target, not a guarantee. High values are the best for performance, but they also cause worse stuttering during collection. PaperMC suggests 200 (which they got from Aikar), but that is a noticeable amount of stutter; 100 is less-likely to be noticed.
    '-XX:MaxTenuringThreshold=1'
    '-XX:SurvivorRatio=33'
    '-XX:TargetSurvivorRatio=92'
    '-XX:+UseParNewGC'
    '-XX:+UseConcMarkSweepGC'

    ## G1GC settings
    '-XX:+UseG1GC'
    '-XX:G1HeapRegionSize=8M'
    '-XX:G1HeapWastePercent=5'
    '-XX:G1MixedGCCountTarget=4'
    '-XX:G1MixedGCLiveThresholdPercent=90'
    '-XX:G1ReservePercent=20'
    '-XX:G1NewSizePercent=30'
    '-XX:G1MaxNewSizePercent=40'
    '-XX:G1RSetUpdatingPauseTimePercent=5'
    '-XX:G1SATBBufferEnqueueingThresholdPercent=30'
    '-XX:G1ConcMarkStepDurationMillis=5'
    '-XX:G1ConcRefinementServiceIntervalMillis=150'
    '-XX:G1ConcRSHotCardLimit=16'

    ## Reporting
    '-Dusing.aikars.flags=https://mcflags.emc.gs'
    '-Daikars.new.flags=true'
    "-Xlog:gc*,gc+heap=info:file=./gc-logs/$(date +'%Y-%m-%d_%H-%M-%S').log:time,uptime,level,tags:filecount=1,filesize=1M"

    ## Security
    '-Dlog4j2.formatMsgNoLookups=true'
    '-Djdk.tls.ephemeralDHKeySize=2048'
)

## Export to the environment
export JAVA_OPTS="${SERVER_JAVA_OPTS[@]}"
