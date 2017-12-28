#!/bin/bash

SCRIPT_PATH="$PWD"

echo "Compile Java"
cd "$SCRIPT_PATH/src/main/java/de/cacodaemon/rpiws28114j/"
javac *.java

echo "Generate C header file"
cd "$SCRIPT_PATH/src/main/java/"
javah -d ../c/ de.cacodaemon.rpiws28114j.WS2811

if [ ! -d "$SCRIPT_PATH/tmp/" ]; then
  mkdir "$SCRIPT_PATH/tmp/"
fi

if [ ! -d "$SCRIPT_PATH/tmp/rpi_ws281x" ]; then
  echo "Clone jgarff/rpi_ws281x.git into tmp"
  cd "$SCRIPT_PATH/tmp/"
  git clone https://github.com/jgarff/rpi_ws281x.git
fi
pwd

echo "CP rpi_ws281x files to src/min/c"
cp "$SCRIPT_PATH"/tmp/rpi_ws281x/clk.* "$SCRIPT_PATH/src/main/c/"
cp "$SCRIPT_PATH"/tmp/rpi_ws281x/dma.* "$SCRIPT_PATH/src/main/c/"
cp "$SCRIPT_PATH"/tmp/rpi_ws281x/gpio.* "$SCRIPT_PATH/src/main/c/"
cp "$SCRIPT_PATH"/tmp/rpi_ws281x/mailbox.* "$SCRIPT_PATH/src/main/c/"
cp "$SCRIPT_PATH"/tmp/rpi_ws281x/pcm.* "$SCRIPT_PATH/src/main/c/"
cp "$SCRIPT_PATH"/tmp/rpi_ws281x/pwm.* "$SCRIPT_PATH/src/main/c/"
cp "$SCRIPT_PATH"/tmp/rpi_ws281x/rpihw.* "$SCRIPT_PATH/src/main/c/"
cp "$SCRIPT_PATH"/tmp/rpi_ws281x/ws2811.* "$SCRIPT_PATH/src/main/c/"

echo "Compile rpi_ws281x files"
cd "$SCRIPT_PATH/src/main/c/"
gcc dma.c -c
gcc mailbox.c -c
gcc pcm.c -c
gcc pwm.c -c
gcc rpihw.c -c
gcc ws2811.c -c

JNI_H_PATH=`sudo find / -name jni.h -readable -print 2>/dev/null | head -n 1`
JNI_H_PATH=`dirname $JNI_H_PATH`

JNI_MD_H_PATH=`sudo find / -name jni_md.h -readable -print 2>/dev/null | head -n 1`
JNI_MD_H_PATH=`dirname $JNI_MD_H_PATH`

echo "Assume jni.h is in \"$JNI_H_PATH\" and jni_md.h is in \"$JNI_MD_H_PATH\""

gcc -I $JNI_H_PATH -I $JNI_MD_H_PATH dma.o mailbox.o pcm.o pwm.o rpihw.o ws2811.o -shared -o librpiws28114j.so de_cacodaemon_rpiws28114j_WS2811.c
mv librpiws28114j.so "$SCRIPT_PATH/src/main/java/de/cacodaemon/rpiws28114j/"

echo "Run Test with 8x8"
cd "$SCRIPT_PATH/src/main/java/de/cacodaemon/"
javac Main.java rpiws28114j/*.java
cd "$SCRIPT_PATH/src/main/java/"
sudo java -Djava.library.path=de/cacodaemon/rpiws28114j/ de.cacodaemon.Main
rm "$SCRIPT_PATH/src/main/java/de/cacodaemon/Main.class"

cd "$SCRIPT_PATH/src/main/java"
jar cvf RpiWS281x4j.jar ./