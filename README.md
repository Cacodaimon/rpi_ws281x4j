# A Java JNI wrapper for /jgarff/rpi_ws281x

A simple Java library based on https://github.com/jgarff/rpi_ws281x .

## Build

The `build.sh` script checks out the code from https://github.com/jgarff/rpi_ws281x ,
looks for some Java header files on the raspberry, creates the JNI header file, cherry picks the c and header files from rpi_ws281x and mixes them all together.
After compiling and linking a simple JAR gets packed.

Tested with Raspbian stretch lite on a Raspberry PI 3.

Use the `build-on-remote-pi.sh` script to build the library from your development pc on your Raspberry PI. 
The JAR and the shared library gets copied on your dev PC after a successfully build.

## Usage

Here is a simple Kotlin example drawing two pixel using the wrapper.

```kotlin
WS2811.init(WS2811Channel(
            10, // gpioPin
            256, //ledCount
            StripType.WS2811_STRIP_GBR,
            false, // invert
            255 // brightness
    ))
    

WS2811.setPixel(0, Color.GREEN)

val r = 64
val g = 128
val b = 192

WS2811.setPixel(1, Color(r, g, b))
WS2811.render()
```

The wrapper aims to be just a wrapper and does not include any kind of convenience like line drawing or font rendering. 

