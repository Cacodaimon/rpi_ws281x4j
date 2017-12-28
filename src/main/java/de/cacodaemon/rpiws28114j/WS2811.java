package de.cacodaemon.rpiws28114j;

import static java.lang.String.format;

/**
 * Java Wrapper for the https://github.com/jgarff/rpi_ws281x/ Raspberry PI WS281x library.
 */
public final class WS2811 {

    private WS2811() {
    }

    static {
        System.loadLibrary("rpiws28114j");
    }

    private static int channelToUse;

    private static boolean initialized = false;

    /**
     * Init the LED stripes.
     *
     * @param ws2811Channel The channels to init.
     * @throws RuntimeException If WS2811 seems to be already initialized.
     */
    public static void init(WS2811Channel... ws2811Channel) {
        if (initialized) {
            throw new RuntimeException("WS2811 seems to be already initialized, call close() first.");
        }

        if (ws2811Channel.length > _getRpiPwmChannelCount()) {
            throw new RuntimeException(format("There is a maximum of %d channels.", _getRpiPwmChannelCount()));
        }

        for (int channelNumber = 0; channelNumber < ws2811Channel.length; channelNumber++) {
            WS2811Channel currentChannel = ws2811Channel[channelNumber];

            _addChannel(
                    channelNumber,
                    currentChannel.getGpioPinNumber(),
                    currentChannel.getLedCount(),
                    currentChannel.getStripType(),
                    currentChannel.getInvert() ? 1 : 0,
                    currentChannel.getBrightness()
            );
        }

        _init();
        initialized = true;
    }

    /**
     * Sets one or many pixes, beginning at numPixel.
     *
     * @param numPixel The index of the single pixel or the offset for multiple pixels.
     * @param color    The colors to set as RGB int.
     */
    public static void setPixel(int numPixel, int... color) {
        for (int i = 0; i < color.length; i++) {
            _setPixel(channelToUse, numPixel + i, color[i]);
        }
    }

    /**
     * Sets one or many pixes, beginning at numPixel.
     *
     * @param numPixel The index of the single pixel or the offset for multiple pixels.
     * @param color    The colors to set.
     */
    public static void setPixel(int numPixel, Color... color) {
        for (int i = 0; i < color.length; i++) {
            _setPixel(channelToUse, numPixel + i, color[i].getRGB());
        }
    }

    /**
     * Sets the channel to use.
     *
     * @param channelNumber The target channel.
     * @throws RuntimeException If the channel number is greater than the current channel count.
     */
    public static void setChannel(int channelNumber) {
        if (channelNumber > _getRpiPwmChannelCount()) {
            throw new RuntimeException(format("Channel number %d given, the current maximum channel number is %d!", channelNumber, _getRpiPwmChannelCount()));
        }

        channelToUse = channelNumber;
    }

    /**
     * Closes the WS2811 library.
     *
     * @throws RuntimeException If WS2811 seems not to be initialized.
     */
    public static void close() {
        if (!initialized) {
            throw new RuntimeException("WS2811 seems not be initialized, call init() first.");
        }

        _close();
    }

    /**
     * Renders the LED stripe.
     *
     * @throws RuntimeException If WS2811 seems not to be initialized.
     */
    public static void render() {
        if (!initialized) {
            throw new RuntimeException("WS2811 seems not be initialized, call init() first.");
        }

        _render();
    }

    private static native void _addChannel(int channelNumber, int gpioPinNumber, int ledCount, int stripType, int invert, int brightness);

    private static native void _init();

    private static native void _setPixel(int channelNumber, int numPixel, int color);

    private static native void _render();

    private static native void _close();

    private static native int _getRpiPwmChannelCount();
}