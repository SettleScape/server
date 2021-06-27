#!/bin/sh
./stop-server.sh && exec ./start-server.sh "$1"
