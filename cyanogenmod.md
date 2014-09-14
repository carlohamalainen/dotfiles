# CyanogenMod on Samsung S3 using Debian Jessie

Notes on installing [CyanogenMod](http://www.cyanogenmod.org/) on a Samsung S3 (i9300) using a Debian Jessie host.

## Disclaimer

You can brick your phone. Take care.

## Debian prerequisites

    sudo apt-get install libudev1 libudev-dev                   \
                         libusb-1.0-0 libusb-1.0-0-dev          \
                         build-essential pkg-config zlib1g-dev  \
                         libusb-dev libqt4-dev qt4-qmake        \
                         autoconf libtool libusb-1.0-0-dev

## Heimdall

    git clone git://github.com/Benjamin-Dobell/Heimdall.git
    cd Heimdall/libpit
    ./autogen.sh
    ./configure
    make
    cd ../heimdall
    ./autogen.sh
    ./configure
    make
    sudo su -c 'make install'
    cd ../heimdall-frontend/
    qmake-qt4 heimdall-frontend.pro
    make
    sudo su -c 'make install'

After installing Heimdall, reset udev or reboot.

## Flash the clockwork recovery

Start with the phone off and disconnected.

1. Boot into download mode by holding down Home,  Volume Down, and Power.
2. Accept the disclaimer.
3. Insert the USB cable into the device.

Now flash the recovery clockwork image:

    sudo heimdall flash --RECOVERY recovery-clockwork-touch-6.0.3.1-i9300.img --no-reboot

## Boot into recovery mode

Unplug from USB and boot ClockworkMod recovery mode by holding Home, Volume Up, and Power.

You may need to format ```/sdcard```. I got errors like

    "Error mounting /sdcard/.android_secure!"

which were solved by formatting

```/data``` and ```/data/media``` (which I think was ```/sdcard```).

## Push CyanogenMod

I used the Android Developers Kit, ```adt-bundle-linux-x86_64-20130729.zip``` to get the ```adb``` command.

    sudo ./adt-bundle-linux-x86_64-20130729/sdk/platform-tools/adb push cm-10.2.0-i9300.zip /sdcard/

## Install F-Droid

On the phone, visit https://f-droid.org/ and download the APK. You have to enable unauthorised APKs.

## Install Lil' Debian

In the F-Droid app, search for
[Lil' Debian](https://f-droid.org/repository/browse/?fdfilter=debian&fdid=info.guardianproject.lildebi).

Open a terminal in Lil' Debian and install ```net-tools``` for ```ifconfig```:

    apt-get install net-tools

Logging in can be slow (over ssh) because the ssh daemon tries to do a reverse DNS. Turn this off:

    echo "UseDNS no" >> /etc/ssh/sshd_config
    /etc/init.d/ssh restart

# Encryption

I prefer to have a strong password for the device encryption but
a weaker one (a PIN perhaps) as the screen unlock. To achieve this,
encrypt the device with the weaker option (e.g. a PIN) and then change
the device encryption password with:

    vdc cryptfs changepw 'newpass'

# Further reading

http://wiki.cyanogenmod.org/w/Install_CM_for_i9300
