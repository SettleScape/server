#!/bin/sh
set -e
. '.env'

## Variables
CWD=$(pwd)

## Do the thing
cd "$ENV_SERVER_ROOT"
rm -rf "$ENV_JAVA_DIR"
mkdir -p "$ENV_JAVA_DIR"
case "$ENV_JAVA_VERSION" in

    17)
        OUT="java${ENV_JAVA_VERSION}.tar.gz"
        curl "https://download.oracle.com/java/${ENV_JAVA_VERSION}/latest/jdk-${ENV_JAVA_VERSION}_linux-x64_bin.tar.gz" > "$OUT"
        tar -xf "$OUT" -C "$ENV_JAVA_DIR"
        mv "$ENV_JAVA_DIR"/*/* "$ENV_JAVA_DIR"/
        rm "$OUT"
    ;;

    *)
        echo "Automatic updates unsupported for Java v${ENV_JAVA_VERSION}."
    ;;

esac

## Cleanup
cd "$CWD"
exit 0
