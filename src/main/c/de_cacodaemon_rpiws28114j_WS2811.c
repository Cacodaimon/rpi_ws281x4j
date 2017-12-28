#include <jni.h>
#include <stdio.h>
#include "de_cacodaemon_rpiws28114j_WS2811.h"

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <signal.h>
#include <stdarg.h>
#include <getopt.h>

#include "clk.h"
#include "gpio.h"
#include "dma.h"
#include "pwm.h"

#include "ws2811.h"


ws2811_t ledstring =
    {
        .freq = WS2811_TARGET_FREQ,
        .dmanum = 5,
        .channel =
        {
            [0] =
            {
                .gpionum = 0,
                .count = 0,
                .invert = 0,
                .brightness = 0,
                .strip_type = 0,
            },
            [1] =
            {
                .gpionum = 0,
                .count = 0,
                .invert = 0,
                .brightness = 0,
                .strip_type = 0,
            },
        },
    };

/*
 * Class:     de_cacodaemon_rpiws28114j_WS2811
 * Method:    _addChannel
 * Signature: (IIIIII)V
 */
JNIEXPORT void JNICALL Java_de_cacodaemon_rpiws28114j_WS2811__1addChannel
(JNIEnv *env, jobject thisObj, jint channelNumber, jint gpioPinNumber, jint ledCount, jint stripType, jint invert, jint brightness)
{
    ledstring.channel[(int)channelNumber].gpionum = (int)gpioPinNumber;
    ledstring.channel[(int)channelNumber].count = (int)ledCount;
    ledstring.channel[(int)channelNumber].invert = (int)invert;
    ledstring.channel[(int)channelNumber].brightness = (int)brightness;
    ledstring.channel[(int)channelNumber].strip_type = (int)stripType;
}

/*
 * Class:     de_cacodaemon_rpiws28114j_WS2811
 * Method:    _init
 * Signature: ()V
 */
JNIEXPORT void JNICALL Java_de_cacodaemon_rpiws28114j_WS2811__1init (JNIEnv *env, jobject thisObj)
{
    ws2811_return_t ret;
    if ((ret = ws2811_init(&ledstring)) != WS2811_SUCCESS)
    {
        char *className = "java/lang/RuntimeException";
        jclass Exception = (*env)->FindClass(env, className);
        (*env)->ThrowNew(env, Exception, ws2811_get_return_t_str(ret));
    }
}

/*
 * Class:     de_cacodaemon_rpiws28114j_WS2811
 * Method:    _setPixel
 * Signature: (III)V
 */
JNIEXPORT void JNICALL Java_de_cacodaemon_rpiws28114j_WS2811__1setPixel
  (JNIEnv *env, jobject thisObj, jint channelToUse, jint numPixel, jint color)
{
   ledstring.channel[(int)channelToUse].leds[numPixel] = (uint)color;
}

/*
 * Class:     de_cacodaemon_rpiws28114j_WS2811
 * Method:    _render
 * Signature: ()V
 */
JNIEXPORT void JNICALL Java_de_cacodaemon_rpiws28114j_WS2811__1render
  (JNIEnv *env, jobject thisObj)
{
    ws2811_return_t ret;
    if ((ret = ws2811_render(&ledstring)) != WS2811_SUCCESS)
    {
        char *className = "java/lang/RuntimeException";
        jclass Exception = (*env)->FindClass(env, className);
        (*env)->ThrowNew(env, Exception, ws2811_get_return_t_str(ret));
    }
}

/*
 * Class:     de_cacodaemon_rpiws28114j_WS2811
 * Method:    _close
 * Signature: ()V
 */
JNIEXPORT void JNICALL Java_de_cacodaemon_rpiws28114j_WS2811__1close
  (JNIEnv *env, jobject thisObj)
{
    ws2811_fini(&ledstring);
}

/*
 * Class:     de_cacodaemon_rpiws28114j_WS2811
 * Method:    _getRpiPwmChannelCount
 * Signature: ()I
 */
JNIEXPORT jint JNICALL Java_de_cacodaemon_rpiws28114j_WS2811__1getRpiPwmChannelCount
  (JNIEnv *env, jobject thisObj)
{
    return RPI_PWM_CHANNELS;
}