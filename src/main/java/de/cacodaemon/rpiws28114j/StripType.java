package de.cacodaemon.rpiws28114j;

/**
 * The RGB Strip Type to use.
 * See ws2811.h for more details.
 */
public enum StripType {
    WS2811_STRIP_RGB(0x00100800),
    WS2811_STRIP_RBG(0x00100008),
    WS2811_STRIP_GRB(0x00081000),
    WS2811_STRIP_GBR(0x00080010),
    WS2811_STRIP_BRG(0x00001008),
    WS2811_STRIP_BGR(0x00000810);

    private final int value;

    private StripType(int value) {
        this.value = value;
    }

    public int getValue() {
        return value;
    }
}