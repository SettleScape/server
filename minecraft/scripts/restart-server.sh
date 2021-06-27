#!/bin/sh
./stop-server.sh && exec ./start-server.bash "$1"
