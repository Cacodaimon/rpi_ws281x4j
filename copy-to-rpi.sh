#!/usr/bin/env bash

RASPBERRY_PI="pi@192.168.1.111"

rsync -va ./* "$RASPBERRY_PI":~/test/rpiws28114j --delete
ssh "$RASPBERRY_PI" -t "cd ~/test/rpiws28114j; bash build.sh"

scp "$RASPBERRY_PI":/home/pi/test/rpiws28114j/src/main/java/RpiWS281x4j.jar .