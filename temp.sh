cd /home/pi/rpi_ws281x_j/src/main/java/de/cacodaemon/caclock/rpiws281x/
javac *.java
cd /home/pi/rpi_ws281x_j/src/main/java
javah -d ../c/ de.cacodaemon.caclock.rpiws281x.WS2811
cd /home/pi/rpi_ws281x_j/src/main/c
gcc dma.c -c
gcc mailbox.c -c
gcc pcm.c -c
gcc pwm.c -c
gcc rpihw.c -c
gcc ws2811.c -c
gcc -I /usr/lib/jvm/jdk-8-oracle-arm32-vfp-hflt/include/ -I /usr/lib/jvm/jdk-8-oracle-arm32-vfp-hflt/include/linux/ dma.o mailbox.o pcm.o pwm.o rpihw.o ws2811.o -shared -o librpiws28114j.so de_cacodaemon_caclock_rpiws281x_WS2811.c
mv librpiws28114j.so /home/pi/rpi_ws281x_j/src/main/java/de/cacodaemon/caclock/rpiws281x/
cd /home/pi/rpi_ws281x_j/src/main/java
sudo java -Djava.library.path=de/cacodaemon/caclock/rpiws281x/ de.cacodaemon.caclock.rpiws281x.Main
/home/pi/rpi_ws281x_j
jar cvf RpiWS281x4j.jar src


cd /home/pi/rpi_ws281x_j/src/main/java/de/cacodaemon/caclock/rpiws281x/
javac *.java
cd /home/pi/rpi_ws281x_j/src/main/java
sudo java -Djava.library.path=de/cacodaemon/caclock/rpiws281x/ de.cacodaemon.caclock.rpiws281x.Main