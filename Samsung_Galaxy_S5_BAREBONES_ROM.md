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

    sudo adt-bundle-linux-x86_64-20140702/sdk/platform-tools/adb push cm-12.1-20150813-NIGHTLY-klte.zip cm-12.1-20150721-BAREBONES-klte.zip /sdcard/
    sudo adt-bundle-linux-x86_64-20140702/sdk/platform-tools/adb push gapps-5.1-2015-07-03-13-41.zip /sdcard/
    sudo adt-bundle-linux-x86_64-20140702/sdk/platform-tools/adb push CM_Fixed_Camera_for_CM_All_AOSP_roms_by_RohanAJoshi_V5.0.zip /sdcard/

Use interface to install ```cm-12.1-20150813-NIGHTLY-klte.zip``` and then reboot.

Use interface to install ```gapps-5.1-2015-07-03-13-41.zip``` and then reboot.

Use interface to install ```CM_Fixed_Camera_for_CM_All_AOSP_roms_by_RohanAJoshi_V5.0.zip``` and then reboot.

The CM_Fixed_Camera sorts out the "camera disconnected" errors that plague CyanogenMod.

## Md5sums

    0a950b76300eb520cfabdcb6b55e0a9d  twrp-2.8.7.0-klte.img
    18a7c5778f96c0823349d465f58a0a36  adt-bundle-linux-x86_64-20140702.zip

    f5557b52720b8ee84a3ac7d83cc30b19  cm-12.1-20150813-NIGHTLY-klte.zip
    7301dbab84fa44dafffdb74af06bc40b  gapps-5.1-arm-2015-07-17-13-29.zip
    fbf99c41c6bd8a970ccea859c1a05470  CM_Fixed_Camera_for_CM_All_AOSP_roms_by_RohanAJoshi_V5.0.zip

## Other things

Easily set different lock screen and cryptfs passwords: https://github.com/nelenkov/cryptfs-password-manager
