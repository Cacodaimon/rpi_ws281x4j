package de.cacodaemon;

import de.cacodaemon.rpiws28114j.Color;
import de.cacodaemon.rpiws28114j.StripType;
import de.cacodaemon.rpiws28114j.WS2811;
import de.cacodaemon.rpiws28114j.WS2811Channel;

public class Main {

    public static void main(String[] args) throws InterruptedException {
        WS2811.init(new WS2811Channel(10, 8 * 8, StripType.WS2811_STRIP_RBG, false, 8));

        for (int i = -8; i < 8; i++) {
            for (int j = 0; j < 64; j++) {
                WS2811.setPixel(j, Color.BLACK);
            }

            WS2811.setPixel(
                    9 + i,
                    Color.fromRandom(),
                    Color.fromRandom(),
                    Color.fromRandom(),
                    Color.fromRandom(),
                    Color.fromRandom(),
                    Color.fromRandom()
            );

            WS2811.setPixel(
                    17 + i,
                    Color.fromRandom(),
                    Color.fromRandom(),
                    Color.fromRandom(),
                    Color.fromRandom(),
                    Color.fromRandom(),
                    Color.fromRandom()
            );

            WS2811.setPixel(
                    27 + i,
                    Color.fromRandom(),
                    Color.fromRandom()
            );

            WS2811.setPixel(
                    35 + i,
                    Color.fromRandom(),
                    Color.fromRandom()
            );

            WS2811.setPixel(
                    43 + i,
                    Color.fromRandom(),
                    Color.fromRandom()
            );

            WS2811.setPixel(
                    51 + i,
                    Color.fromRandom(),
                    Color.fromRandom()
            );

            WS2811.render();
            Thread.sleep(200);
        }

        WS2811.close();
    }
}
