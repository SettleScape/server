#!/usr/bin/env sh
JAVA_OPTS='-Xms1G -Xmx1G -XX:+UseConcMarkSweepGC'
SERVER_JAR='./server.jar'

exec screen -d -m -S "Minecraft Server" \
java $JAVA_OPTS -jar "$SERVER_JAR"
#script /dev/null #FIXME: This shouldn't be necessary to use `screen -r`.
