package de.cacodaemon.rpiws28114j;

/**
 * A WS2811 channel definition.
 */
public class WS2811Channel {

    private final int gpioPinNumber;

    private final int ledCount;

    private final int stripType;

    private final boolean invert;

    private final int brightness;

    /**
     * Creates a new channel.
     * See ws2811.h for more details.
     *
     * @param gpioPinNumber The Raspberry PI pin number to use.
     * @param ledCount The number of leds.
     * @param stripType The led type used in the strip.
     * @param invert Inverts the output signal.
     * @param brightness The led brightness.
     */
    public WS2811Channel(int gpioPinNumber, int ledCount, StripType stripType, boolean invert, int brightness) {
        this.gpioPinNumber = gpioPinNumber;
        this.ledCount = ledCount;
        this.stripType = stripType.getValue();
        this.invert = invert;
        this.brightness = brightness;
    }

    public int getGpioPinNumber() {
        return gpioPinNumber;
    }

    public int getLedCount() {
        return ledCount;
    }

    public int getStripType() {
        return stripType;
    }

    public boolean getInvert() {
        return invert;
    }

    public int getBrightness() {
        return brightness;
    }
}
