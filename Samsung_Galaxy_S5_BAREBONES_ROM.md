# New ROM for the Samsung Galaxy S5

The default ROM is bloated. Lots of crap.

I tried Cyanogenmod, in particular ```cm-12.1-20150722-NIGHTLY-klte.zip``` but the camera kept disconnecting.

If you stuff this up you will brick your phone. Be careful.

## Barebones ROM

Had a look at http://forum.xda-developers.com/galaxy-s5#romList
and chose the most popular ROM, XtreStoLite: http://forum.xda-developers.com/showthread.php?t=2732110

## Prerequisites

On Ubuntu 15, I built Heimdall from source, up to this commit:

    commit d0526a3b74a003dfc6f805682693be9173ffcd88
    Author: Benjamin Dobell <benjamin.dobell+git@glassechidna.com.au>
    Date:   Sat Mar 21 14:53:43 2015 +1100

## Flash recovery ROM

Boot to recovery mode:

* Boot the Galaxy S5 into download mode: Volume Down and Home and Power.
* Insert the USB cable into the device.

Flash using Heimdall:

    sudo ./Heimdall/build/bin/heimdall flash --RECOVERY twrp-2.8.7.0-klte.img --no-reboot

## Install XtreStoLite and Google Apps

Boot to recovery ROM:

* Turn off device.
* Hold Volume Up, Home and Power. When the blue text appears, release the buttons.

Use twrp's interface to do a factory reset (wipe).


Push to the device:

    $ sudo adt-bundle-linux-x86_64-20140702/sdk/platform-tools/adb push cm-12.1-20150721-BAREBONES-klte.zip /sdcard/
    11665 KB/s (210481748 bytes in 17.620s)

    $ sudo adt-bundle-linux-x86_64-20140702/sdk/platform-tools/adb push gapps-5.1-2015-07-03-13-41.zip /sdcard/
    731 KB/s (29987 bytes in 0.040s)

Use interface to install cm-12.1-20150721-BAREBONES-klte.zip and then reboot.

Use interface to install gapps-5.1-2015-07-03-13-41.zip and then reboot.

## Md5sums

    0a950b76300eb520cfabdcb6b55e0a9d  twrp-2.8.7.0-klte.img
    18a7c5778f96c0823349d465f58a0a36  adt-bundle-linux-x86_64-20140702.zip
    0a2bc5bd6c1523bce76da82cd72b723b  cm-12.1-20150721-BAREBONES-klte.zip
    7301dbab84fa44dafffdb74af06bc40b  gapps-5.1-arm-2015-07-17-13-29.zip


