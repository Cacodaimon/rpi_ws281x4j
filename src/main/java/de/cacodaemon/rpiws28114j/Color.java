package de.cacodaemon.rpiws28114j;

import java.util.Random;

import static java.lang.Math.max;
import static java.lang.Math.min;

/**
 * Defines and RGB color.
 */
public class Color {

    public static final Color RED = new Color(255, 0, 0);

    public static final Color GREEN = new Color(0, 255, 0);

    public static final Color BLUE = new Color(0, 0, 255);

    public static final Color BLACK = new Color(0, 0, 0);

    public static final Color WHITE = new Color(255, 255, 255);

    private static final int MAXIMUM_24_BIT_UNSIGNED_INT = 16777216;

    private final int rgb;

    /**
     * Creates a new color from rgb color components.
     *
     * @param red The red component, has got a maximum of 255 and a minimum of 0.
     * @param green The green component, has got a maximum of 255 and a minimum of 0.
     * @param blue The blue component, has got a maximum of 255 and a minimum of 0.
     */
    public Color(int red, int green, int blue) {
        this.rgb = (max(min(red, 255), 0) << 16) | (max(min(green, 255), 0) << 8) | max(min(blue, 255), 0);
    }

    /**
     * Creates a new color .
     *
     * @param rgb The whole color, has got a maximum of 16777216 and a minimum of 0.
     */
    public Color(int rgb) {
        this.rgb = (max(min(rgb, MAXIMUM_24_BIT_UNSIGNED_INT), 0));
    }

    public int getRGB() {
        return rgb;
    }

    /**
     * Creates a random color.
     *
     * @return A random color.
     */
    public static Color fromRandom() {
        return new Color(new Random().nextInt(MAXIMUM_24_BIT_UNSIGNED_INT));
    }
}