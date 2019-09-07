#!/usr/bin/env sh
JAVA_OPTS='-Xms1G -Xmx1G -XX:+UseConcMarkSweepGC'
SERVER_JAR='./server.jar'

#screen -d -m -S "Minecraft Server" \
java $JAVA_OPTS -jar "$SERVER_JAR"
