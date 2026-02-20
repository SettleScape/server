#!/bin/bash
## Configures the JVM.
## Please keep comments synchronized with the client options file.

## Be warned: The Internet is full of cool new Java options you can add to your Minecraft server.
## However, just because something worked well on one person's server 10 years ago is no guarantee that it will work well on yours today.
## (In particular: most guides are targeted at servers that allocate quite a lot of memory, or at working around design limitations in older versions of Java.)
## As well: Many of the guides circling around contain conflicting or even non-existent options! (Most of the non-existent ones used to exist on older versions.)
## You can run the following command to view the defaults and supported options of *your* JVM: `java -XX:+UnlockExperimentalVMOptions -XX:+UnlockDiagnosticVMOptions -XX:+PrintFlagsFinal -version`.
## Always do this before adding new things, to help ensure you don't specify defaults. It's best to just specify deltas, as that can help reduce how much time must be spent to isolate an issue caused by these options.
## Unfortunately, there does not appear to be a centralized place documentating what each of these options does. Accordingly, asking an AI is often among the best strategies.
## One may *think* that the options Mojang ships for the client may be a good starting place, but these are not tuned to be performant — they're apparently tuned to fit the lowest-common-denominator of garbage consumer hardware, all the rest be damned.
##
## PaperMC's suggested options: (derived from Aikar's famous flags)
## * https://docs.papermc.io/paper/aikars-flags
##
## Overview of transparent huge pages:
## * https://github.com/Obydux/Minecraft-startup-flags#enabling-transparent-huge-pages-thp-on-linux

## My personal collection of Java Opts:
declare -a SERVER_JAVA_OPTS=(
    '-XX:+UnlockExperimentalVMOptions'
    '-XX:+UnlockDiagnosticVMOptions'

    ## System identification
    '-XX:+AlwaysActAsServerClassMachine' ## Override default heuristics, just in case they're ever wrong.

    ## Memory initialization
    '-Xmx1536M' ## Set this to some reasonable amount below your system memory.
    '-Xms1536M' ## Always set to the same as -Xmx if you want max performance.
    '-XX:+AlwaysPreTouch' ## During initialization, touches everything in the heap. Good hygiene (especially with THP), but slows startup.

    ## Large pages
    '-XX:+UseTransparentHugePages' ## Can help a bit, but you need to set `transparent_hugepage.enabled=madvise`, `transparent_hugepage.shmem_enabled=advise`, `transparent_hugepage.defrag=defer+madvise`.
    # '-XX:+UseLargePages' ## Don't use this; you have to manually allocate a certain number of pages to this purpose, thus reducing RAM generally; and you're depending on Minecraft and the JVM being good at using those. Use THP instead.

    ## Memory vs CPU tradeoffs
    '-XX:+UseCompressedOops' ## Enabled automatically if heap <= 32G, but I think it's generally worth enabling always unless you are swimming in memory and constrained on CPU.
    '-XX:+UseStringDeduplication' ## Lowers memory consumption by expending CPU. Very system-dependent trade.

    ## Misc
    # '-XX:ThreadPriorityPolicy=1' ## Requires `sudo` on Linux, ergo not worth.
    # '-XX:+UseCompactObjectHeaders' ## Requires Java 25, but is basically a free win. #TODO: Enable once we are on Java 25.

    ## GC settings
    '-XX:+DisableExplicitGC' ## This is a defense against bad plugins. Without it, they can cause frequent and noticeable stuttering.
    '-XX:MaxGCPauseMillis=125' ## This is a target, not a guarantee. High values are best for performance, but they also cause worse stuttering during collection. Java 17's default is `200`; Minecraft 1.21.11's is `50`, equal to 1 game tick. Servers can afford to go higher than clients, here.

    ## G1GC settings
    # '-XX:G1HeapRegionSize=8M' ## Anything >= 50% of this is considered "humongous" and handled suboptimally. Apparently, you want this to be determined automatically (`round(heap / 2048)`) unless the automatic answer is above 8M. Minecraft 1.21.11 ships 32M, which is apparently frankly insane.

    ## Reporting
    "-Xlog:gc,gc+heap=info:file=./gc-logs/%p_%t.log:time,uptime,level,tags:filecount=4,filesize=5M" #NOTE: This `gc-logs` directory is referenced by `purge-old.bash` and `start-server.bash`.
    # "-Xlog:gc*,gc+heap=info,gc+age=trace,gc+humongous:file=./gc-logs/%p_%t.log:time,uptime,level,tags:filecount=4,filesize=20M" ## More-verbose option for testing, not for prod.

    ## Security
    '-Dlog4j2.formatMsgNoLookups=true' ## Included out of an abundance of caution since we are still running 1.17.1 and plugins for this version are liable include an unsafe version of log4j. Extremely unlikely, but not impossible.

    ## Warnings
    # '-XX:AllocatePrefetchStyle=X' ## Don't set this; let it be determined automatically. The best value depends on your CPU, and selecting the wrong one can break things.
    # '-XX:InitiatingHeapOccupancyPercent=X' ## Do not set this; modern Java adaptively adjusts it up-and-down as needed; see `G1UseAdaptiveIHOP`.
    # '-XX:GCTimeRatio=X' ## This fights `MaxGCPauseMillis`. It is better to set Millis and let Ratio be dynamic.
)

## Export to the environment
export JAVA_OPTS="${SERVER_JAVA_OPTS[@]}"
