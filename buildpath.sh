#!/bin/bash

echo "Compile Java"
cd "$PWD/src/main/java/de/cacodaemon/rpiws28114j/"
javac *.java

echo "Generate C header file"
cd ../../../
javah -d ../c/ de.cacodaemon.rpiws28114j.WS2811

cd ../../../

if [ ! -d "./tmp" ]; then
  mkdir ./tmp
fi

if [ ! -d "./tmp/rpi_ws281x" ]; then
  echo "Clone rpi_ws281x.git"
  cd tmp
  git clone https://github.com/jgarff/rpi_ws281x.git
fi
pwd

echo "CP rpi_ws281x files to src/min/c"
cp tmp/rpi_ws281x/clk.* src/main/c/
cp tmp/rpi_ws281x/dma.* src/main/c/
cp tmp/rpi_ws281x/gpio.* src/main/c/
cp tmp/rpi_ws281x/mailbox.* src/main/c/
cp tmp/rpi_ws281x/pcm.* src/main/c/
cp tmp/rpi_ws281x/pwm.* src/main/c/
cp tmp/rpi_ws281x/rpihw.* src/main/c/
cp tmp/rpi_ws281x/ws2811.* src/main/c/

echo "Compile rpi_ws281x files"
cd src/main/c/
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
mv librpiws28114j.so ../java/de/cacodaemon/rpiws28114j/

echo "Run Test with 8x8"
cd ../java/de/cacodaemon/
javac Main.java rpiws28114j/*.java
cd ../../
sudo java -Djava.library.path=de/cacodaemon/rpiws28114j/ de.cacodaemon.Main
rm de/cacodaemon/Main.class

cd ""
jar cvf RpiWS281x4j.jar *.java