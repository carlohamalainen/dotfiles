# New ROM for the Samsung Galaxy S5

The default ROM is bloated. Lots of crap.

I tried XtreStoLite but couldn't get encryption to work. Not sure why. Reverted to CyanogenMod.

If you stuff this up you will brick your phone. Be careful.

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

## Install CyanogenMod, Google Apps, Fixed Camera

Boot to recovery ROM:

* Turn off device.
* Hold Volume Up, Home and Power. When the blue text appears, release the buttons.

Use twrp's interface to do a factory reset (wipe).

Push to the device:

    sudo adt-bundle-linux-x86_64-20140702/sdk/platform-tools/adb push \
            cm-13.0-20160309-NIGHTLY-klte.zip /sdcard/

    sudo adt-bundle-linux-x86_64-20140702/sdk/platform-tools/adb push \
            FDroid.apk /sdcard/

    sudo adt-bundle-linux-x86_64-20140702/sdk/platform-tools/adb push \
            CM_Fixed_Camera_for_CM_All_AOSP_roms_by_RohanAJoshi_V5.0.zip /sdcard/

Use interface to install ```cm-*-klte.zip``` and then reboot.

Use interface to install ```CM_Fixed_Camera_for_CM_All_AOSP_roms_by_RohanAJoshi_V5.0.zip``` and then reboot.

The CM_Fixed_Camera sorts out the "camera disconnected" errors that plague CyanogenMod.

## Md5sums

    0a950b76300eb520cfabdcb6b55e0a9d  twrp-2.8.7.0-klte.img
    18a7c5778f96c0823349d465f58a0a36  adt-bundle-linux-x86_64-20140702.zip

    caf386eb2ecb7159015e5cba7d7bd8cc  FDroid.apk
    c0afc7de1a4217ec5f227de80e5623c1  cm-13.0-20160309-NIGHTLY-klte.zip
    fbf99c41c6bd8a970ccea859c1a05470  CM_Fixed_Camera_for_CM_All_AOSP_roms_by_RohanAJoshi_V5.0.zip

## Other things

Easily set different lock screen and cryptfs passwords: https://github.com/nelenkov/cryptfs-password-manager