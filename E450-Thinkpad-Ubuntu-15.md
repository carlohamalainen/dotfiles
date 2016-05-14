# Ubuntu 15.10 on Lenovo E450 Thinkpad

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

## 4.4 kernel

The 4.2 kernel didn't manage to suspend (went to 100% CPU).

Use the 4.5 kernel from http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.5-wily/

    linux-headers-4.5.0-040500_4.5.0-040500.201603140130_all.deb
    linux-headers-4.5.0-040500-generic_4.5.0-040500.201603140130_amd64.deb
    linux-image-4.5.0-040500-generic_4.5.0-040500.201603140130_amd64.deb

## Haskell

### GHC PPA

Add the PPA:

    sudo add-apt-repository ppa:hvr/ghc

Install the latest:

    sudo apt-get install ghc-7.10.3 ghc-7.10.3-prof ghc-7.10.3-dyn ghc-7.10.3-htmldocs

Add ```/opt/ghc/7.10.3/bin``` to ```$PATH```. Open a new terminal.

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

### All the things

    sudo apt-get install unison2.32.52-gtk meld vim-gtk build-essential git colordiff          \
                         ghc rsync sshfs xinput ipython python-nose python-networkx            \
                         python-setuptools python-numpy python-scipy graphviz ecryptfs-utils   \
                         cryptsetup pavucontrol screen durep baobab keepassx xinput htop       \
                         transmission-gtk gnupg2 vlc mplayer                                   \
                         calibre conky-all geeqie libjpeg-progs                                \
                         tcsh inkscape mpop flac moreutils xchat-gnome tcl-tclreadline         \
                         genisoimage gitk rdiff-backup unrar ffmpeg wmctrl exiftags            \
                         iotop audacity pdftk                                                  \
                         kino vorbis-tools ffmpeg2theora iftop pdf2djvu cpphs parted           \
                         libgetopt-tabular-perl libzmq-dev python-zmq libblas-dev libblas3     \
                         liblapack-dev liblapack3 fort77 gfortran gfortran-multilib ack-grep   \
                         libdata-dump-perl libdata-printer-perl stress winpdb strace djview    \
                         libhdf5-serial-dev btrfs-tools emacs24 beep openjdk-7-jdk autoconf    \
                         python-appindicator libappindicator3-1 libappindicator3-dev           \
                         gir1.2-appindicator3-0.1 llvm libgc-dev ocaml camlp5                  \
                         liblablgtk2-ocaml-dev liblablgtk2-gl-ocaml-dev                        \
                         liblablgtk-extras-ocaml-dev liblablgtksourceview2-ocaml-dev           \
                         liblablgtkmathview-ocaml-dev hevea texlive-fonts-recommended          \
                         texlive-latex-extra texlive-math-extra libav-tools normalize-audio    \
                         cmake network-manager-vpnc sqlitebrowser mediainfo pwgen              \
                         owncloud-client autossh gvncviewer blueman mailutils ssmtp

    sudo apt-get install apt-file
    sudo apt-file update

## Owncloud icon missing

https://github.com/owncloud/client/issues/4693#issuecomment-214365805

    sudo apt purge appmenu-qt5

### Skype

Manualy download, then:

    sudo dpkg --add-architecture i386
    sudo apt-get update
    sudo dpkg -i skype-ubuntu-precise_4.3.0.37-1_i386.deb
    sudo apt-get -f install
    sudo apt-get install libpulse0:i386

To configure the headset, first start skype and pavucontrol:

    pavucontrol &
    skype &

### Thunderbird derp

Don't know why, but my thunderbird profile tries to open URLs
with ```/opt/firefox/firefox``` so just workaround with:

    sudo mkdir /opt/firefox
    sudo ln -s /usr/bin/firefox /opt/firefox/firefox

### Python bits

    sudo apt-get install python-pip
    sudo pip install youtube-dl
    sudo pip install pyflakes


### ghc-imported-from

TODO

# BLAH

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



