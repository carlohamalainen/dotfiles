# Ubuntu 15 on Lenovo E450 Thinkpad

## Hibernation

Hibernation is not enabled by default! http://askubuntu.com/questions/614662/how-to-enable-hibernation-in-15-04

Create the file ```/etc/polkit-1/localauthority/10-vendor.d/com.ubuntu.desktop.pkla``` with this contents:

    [Enable hibernate by default in upower]
    Identity=unix-user:*
    Action=org.freedesktop.upower.hibernate
    ResultActive=yes

    [Enable hibernate by default in logind]
    Identity=unix-user:*
    Action=org.freedesktop.login1.hibernate;org.freedesktop.login1.handle-hibernate-key;org.freedesktop.login1;org.freedesktop.login1.hibernate-multiple-sessions;org.freedesktop.login1.hibernate-ignore-inhibit
    ResultActive=yes

## Change video card

http://community.linuxmint.com/tutorial/view/1501

Quoting directly:

    sudo apt-get install fglrx fglrx-amdcccle fglrx-pxpress

    After restart you can see that Radeon card is active with this:

    inxi -G

    Now we need AMD Catalyst Center for switching graphic cards:

    sudo apt-get install fglrx-amdcccle

    sudo reboot

    After reboot start AMD Catalyst Center with this:

    sudo amdcccle

    And change graphic to Integrated to see if everything works.

    Always start amdccle with sudo when switching graphic cards.

## 4.2 kernel

The 3.19 kernel had issues with waking from suspend (garbled fonts) and sometimes unstable wifi...

https://bugs.launchpad.net/xserver-xorg-video-intel/+bug/1432194

https://bugs.launchpad.net/ubuntu/+source/xserver-xorg-video-intel/+bug/1452318

Upgrade to 4.2 kernel (seems to have fixed suspend and wifi issues):

Visited http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.2-unstable/
and installed these packages:

    linux-headers-4.2.0-040200_4.2.0-040200.201508301530_all.deb
    linux-headers-4.2.0-040200-generic_4.2.0-040200.201508301530_amd64.deb
    linux-image-4.2.0-040200-generic_4.2.0-040200.201508301530_amd64.deb

## Haskell

### GHC PPA

Add the PPA:

    sudo add-apt-repository ppa:hvr/ghc

Install the latest:

    sudo apt-get install ghc-7.10.2 ghc-7.10.2-prof ghc-7.10.2-dyn ghc-7.10.2-htmldocs

Add ```/opt/ghc/7.10.2/bin``` to ```$PATH```. Open a new terminal.

Newer cabal:

    cabal update
    cabal install cabal-install

Add ```$HOME/.cabal/bin``` to front of ```$PATH```.

    sed -i 's/-- documentation: False/documentation: True/g'         ~/.cabal/config

### Stack

Do this after installing GHC and cabal and so on.

Reference: https://github.com/commercialhaskell/stack/wiki/Downloads

Install:

    echo 'deb http://download.fpcomplete.com/ubuntu/vivid stable main'|sudo tee /etc/apt/sources.list.d/fpco.list
    sudo apt-get update && sudo apt-get install stack -y

### BlogLiterately

    sudo apt-get install libssl-dev libcrypto++-dev
    stack install BlogLiterately

Add ```$HOME/.local/bin/``` to the start of ```$PATH```.

### ghc-mod

    cd $HOME
    mkdir opt
    cd opt
    git clone https://github.com/kazu-yamamoto/ghc-mod
    cd ghc-mod
    stack build

Add ```$HOME/opt/ghc-mod/.stack-work/dist/x86_64-linux/Cabal-1.22.4.0/build/ghc-mod``` to the start of ```$PATH```.

Test it out:

    cd $HOME/tmp
    stack new blah
    cd blah
    stack build

Edit ```blah.cabal``` and add ```mtl``` and ```lens``` to the ```build-depends``` of ```executable blah-exe```, then re-run ```stack build```. This should be very quick because previous things caused ```lens``` to be built.

Open ```app/Main.hs``` in Vim and try ```:GhcModType``` on something.

### ghc-imported-from

TODO
