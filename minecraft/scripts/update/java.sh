#!/bin/sh
set -e
. '../var/env.sh'

## Variables
CWD=$(pwd)

## Do the thing
cd "$ENV_SERVER_ROOT"
rm -rf "$ENV_JAVA_DIR"
mkdir -p "$ENV_JAVA_DIR"
OUT="java${ENV_JAVA_VERSION}.tar.gz"
UPSTREAM='coretto'
case "$UPSTREAM" in
    'coretto') curl "https://corretto.aws/downloads/latest/amazon-corretto-${ENV_JAVA_VERSION}-x64-linux-jdk.tar.gz" > "$OUT" ;;
    'graal')   curl "https://download.oracle.com/graalvm/${ENV_JAVA_VERSION}/latest/graalvm-jdk-${ENV_JAVA_VERSION}_linux-x64_bin.tar.gz" > "$OUT" ;;
    'oracle')  curl "https://download.oracle.com/java/${ENV_JAVA_VERSION}/latest/jdk-${ENV_JAVA_VERSION}_linux-x64_bin.tar.gz" > "$OUT" ;;
esac
tar -xf "$OUT" -C "$ENV_JAVA_DIR"
mv "$ENV_JAVA_DIR"/*/* "$ENV_JAVA_DIR"/
rm "$OUT"

## Cleanup
cd "$CWD"
exit 0
