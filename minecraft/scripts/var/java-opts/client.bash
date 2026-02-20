#!/bin/bash
## The server's custom JVM options tweaked for use on clients.
## Please keep comments synchronized with the server options file.

## Tweak them for clients
declare -a CLIENT_JAVA_OPTS=(
    '-XX:+UnlockExperimentalVMOptions'
    '-XX:+UnlockDiagnosticVMOptions'

    ## System identification
    '-XX:+NeverActAsServerClassMachine' ## Override default heuristics, just in case they're ever wrong.

    ## Memory initialization
    '-Xmx2G' ## Set this to some reasonable amount below your system memory.
    '-Xms2G' ## Always set to the same as -Xmx if you want max performance.
    # '-XX:+AlwaysPreTouch' ## During initialization, touches everything in the heap. Good hygiene (especially with THP), but slows startup.

    ## Large pages
    # '-XX:+UseTransparentHugePages' ## Can help a bit, but you need to set `transparent_hugepage.enabled=madvise`, `transparent_hugepage.shmem_enabled=advise`, `transparent_hugepage.defrag=defer+madvise`.
    # '-XX:+UseLargePages' ## Don't use this; you have to manually allocate a certain number of pages to this purpose, thus reducing RAM generally; and you're depending on Minecraft and the JVM being good at using those. Use THP instead.

    ## Memory vs CPU tradeoffs
    # '-XX:+UseCompressedOops' ## Enabled automatically if heap <= 32G, but I think it's generally worth enabling always unless you are swimming in memory and constrained on CPU.
    # '-XX:+UseStringDeduplication' ## Lowers memory consumption by expending CPU. Very system-dependent trade.

    ## Misc
    # '-XX:ThreadPriorityPolicy=1' ## Requires `sudo` on Linux, but can be worth trying on Windows.
    # '-XX:+UseCompactObjectHeaders' ## Requires Java 25, but is basically a free win. #TODO: Enable once you are on Java 25.

    ## GC settings
    '-XX:+DisableExplicitGC' ## This is a defense against bad plugins. Without it, they can cause frequent and noticeable stuttering.
    # '-XX:+ExplicitGCInvokesConcurrent' ## If you're not using plugins, use this instead of the above.
    '-XX:MaxGCPauseMillis=75' ## This is a target, not a guarantee. High values are best for performance, but they also cause worse stuttering during collection. Java 17's default is `200`; Minecraft 1.21.11's is `50`, equal to 1 game tick. Servers can afford to go higher than clients, here.

    ## G1GC settings
    # '-XX:+UseG1GC' ## Java 17 enables this by default, but Minecraft 1.21.11 explicitly sets it anyway.
    # '-XX:G1NewSizePercent=20' ## Minecraft 1.21.11 ships this value, but it is not optimal; just let Java do its thing.
    # '-XX:G1ReservePercent=20' ## Minecraft 1.21.11 ships this value, but it is not optimal; just let Java do its thing.
    # '-XX:G1HeapRegionSize=32M' ## Minecraft 1.21.11 ships this value, but it is not optimal; just let Java do its thing.

    ## Security
    '-Dlog4j2.formatMsgNoLookups=true' ## Included out of an abundance of caution since we are still running 1.17.1 and plugins for this version are liable include an unsafe version of log4j. Extremely unlikely, but not impossible.
)

## Export to the environment
export JAVA_OPTS="${CLIENT_JAVA_OPTS[@]}"

## Echo to concole
echo "$JAVA_OPTS"
