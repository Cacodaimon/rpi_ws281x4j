#!/usr/bin/env bash

if [ -z "$1" ]; then
    echo "Please provide the Raspberry PI location and username as first parameter."
    echo "For example: $0 pi@192.168.1.111"
    exit
fi

RASPBERRY_PI="$1"
BUILD_DIR="/tmp/rpibuild"

echo "Creating target dir in /tmp"
ssh "$RASPBERRY_PI" -t "mkdir $BUILD_DIR"

echo "Copy necessary files"
rsync -a ./* "$RASPBERRY_PI":$BUILD_DIR --delete --exclude *.jar --exclude copy-to-rpi.sh

echo "Run build.sh on Raspberry PI"
ssh "$RASPBERRY_PI" -t "cd $BUILD_DIR; bash build.sh"

echo "Copy RpiWS281x4j.jar back to development PC"
scp "$RASPBERRY_PI":$BUILD_DIR/src/main/java/RpiWS281x4j.jar .

echo "Extract librpiws28114j.so from jar"
unzip -p RpiWS281x4j.jar de/cacodaemon/rpiws281X4j/librpiws281X4j.so  > librpiws281X4j.so