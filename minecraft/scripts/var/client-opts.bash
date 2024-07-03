#!/bin/bash
## Configures the JVM.

## The server's custom options tweaked for use on clients, with special input from BruceTheMoose's guide.
declare -a CLIENT_JAVA_OPTS=(
    '-XX:+UnlockExperimentalVMOptions'
    '-XX:+UnlockDiagnosticVMOptions'

    ## Memory Settings
    '-Xms2048M'
    '-Xmx2048M'
    '-XX:+AlwaysPreTouch'
    '-XX:+UseTransparentHugePages'
    '-XX:+UseLargePagesInMetaspace'
    '-XX:AllocatePrefetchStyle=3' #NOTE: Breaks ZGC and Shenandoah; fine for G1GC.
    '-XX:InitiatingHeapOccupancyPercent=10'

    ## Misc
    '-XX:+NeverActAsServerClassMachine'
    '-XX:+ParallelRefProcEnabled'
    '-XX:+PerfDisableSharedMem'
    '-XX:+UseVectorCmov'
    '-XX:+UseFastUnorderedTimeStamps'
    '-XX:+UseCriticalJavaThreadPriority'
    # '-XX:ThreadPriorityPolicy=1' ## Requires `sudo` on Linux.

    ## GC settings
    '-XX:+DisableExplicitGC'
    '-XX:GCTimeRatio=50' ## Compromise value;  needs tuning.
    '-XX:MaxGCPauseMillis=37'
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
    '-XX:G1NewSizePercent=23'
    '-XX:G1MaxNewSizePercent=33'
    '-XX:G1RSetUpdatingPauseTimePercent=0'
    '-XX:G1SATBBufferEnqueueingThresholdPercent=30'
    '-XX:G1ConcMarkStepDurationMillis=5'
    '-XX:G1ConcRefinementServiceIntervalMillis=150'
    '-XX:G1ConcRSHotCardLimit=16'

    ## Code optimizations
    '-XX:-DontCompileHugeMethods'
    '-XX:MaxNodeLimit=240000'
    '-XX:NodeLimitFudgeFactor=8000'
    # '-XX:+UseStringDeduplication' ## Only when memory-constrained
    '-XX:NmethodSweepActivity=1'
    '-XX:ReservedCodeCacheSize=400M'
    '-XX:NonNMethodCodeHeapSize=12M'
    '-XX:ProfiledCodeHeapSize=194M'
    '-XX:NonProfiledCodeHeapSize=194M'

    ## GraalVM
    # '-XX:+EagerJVMCI'
    # '-Dgraal.LoopRotation=true'
    # '-Dgraal.TuneInlinerExploration=1'

    ## Security
    '-Dlog4j2.formatMsgNoLookups=true'
)
