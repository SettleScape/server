#!/usr/bin/env sh
set -e

## Variables
BUILDDIR='build'
BUILDJAR='BuildTools.jar'
  OUTJAR='../server.jar'
 VERSION='1.14.4'

## Prepare build directory
rm    -rf "$BUILDDIR" 2> /dev/null
mkdir -p  "$BUILDDIR" 2> /dev/null
cd        "$BUILDDIR"

## Perform the build
curl -o "$BUILDJAR" 'https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar'
java -jar "$BUILDJAR" --rev "$VERSION"

## Deploy the new JAR
mv spigot*.jar "$OUTJAR"
exit 0
