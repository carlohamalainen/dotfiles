# Debian Wheezy on Lenovo Carbon X1 ultrabook

## Wifi firmware

Put a copy of the iwlwifi package on a USB stick
so that the installation program can get onto the
network: [http://packages.debian.org/wheezy/firmware-iwlwifi](http://packages.debian.org/wheezy/firmware-iwlwifi)

## BIOS boot options

Do a normal install using the amd64 DVD-1 ISO image, copied
to a USB stick using dd. Set the boot methods in the BIOS
to "legacy only". Beware that changing this option can break
an existing installation!

## Shell aliases
    # FIXME make private dotfiles repo in ~/work/dotfiles-private

    echo 'source $HOME/work/bin/bash-aliases-x1' >> $HOME/.bashrc

## Sources

Edit /etc/apt/sources.list as follows:

    deb http://ftp.se.debian.org/debian stable main contrib non-free
    deb http://ftp.debian.org/debian/ wheezy-updates main contrib non-free
    deb http://security.debian.org/ wheezy/updates main contrib non-free
    deb http://download.virtualbox.org/virtualbox/debian wheezy contrib
    deb http://www.deb-multimedia.org wheezy main non-free
    # deb http://repo.mate-desktop.org/debian wheezy main
    deb http://repo.mate-desktop.org/archive/1.8/debian/ wheezy main

    deb-src http://ftp.se.debian.org/debian stable main contrib non-free
    deb-src http://ftp.debian.org/debian/ wheezy-updates main contrib non-free

Update:

    sudo apt-get update
    sudo apt-get dist-upgrade

## VirtualBox

    wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | sudo apt-key add -
    sudo apt-get update
    sudo apt-get install virtualbox-4.3

    sudo adduser carlo vboxusers # log out and log back in

## Useful packages

    sudo apt-get update

    sudo apt-get install unison2.32.52-gtk meld vim-gtk build-essential git colordiff          \
                         ghc rsync sshfs xinput ipython python-nose python-networkx            \
                         python-setuptools python-numpy python-scipy graphviz ecryptfs-utils   \
                         cryptsetup pavucontrol screen durep baobab keepassx xinput htop       \
                         transmission-gtk gnupg vlc mplayer gstreamer0.10-plugins-base         \
                         gstreamer0.10-plugins-good gstreamer0.10-fluendo-mp3                  \
                         gstreamer0.10-ffmpeg calibre conky-all geeqie libjpeg-progs           \
                         tcsh inkscape mpop flac moreutils xchat-gnome tcl-tclreadline         \
                         genisoimage gitk rdiff-backup unrar ffmpeg wmctrl exiftags            \
                         iotop mencoder audacity pdftk                            \
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
                         texlive-latex-extra texlive-math-extra libav-tools normalize-audio




    sudo apt-get install ghc ghc-doc ghc-haddock ghc-prof haskell-doc haskell-platform \
                         haskell-platform-doc libghc-mtl-prof libghc-primitive-prof \
                         libghc-random-prof

    sudo apt-get install deb-multimedia-keyring
    sudo apt-get update
    sudo apt-get install avidemux mpeg2dec sox

    sudo apt-get install apt-file
    sudo apt-file update

    # Google chrome, manual download.
    sudo dpkg -i Downloads/google-chrome-stable_current_amd64.deb

## Source nice shell stuff

Add to .bashrc:

    . $HOME/work/github/dotfiles/.bashrc-extra
    . $HOME/work/private-dotfiles/bash-extra

## Encrypt home directory

If not using an encrypted LVM, run this as root (do not sudo):

    ecryptfs-migrate-home -u carlo


## Skype

Manualy download, then:

    sudo dpkg --add-architecture i386
    sudo apt-get update
    sudo dpkg -i skype-debian_4.2.0.11-1_i386.deb
    sudo apt-get -f install
    sudo apt-get install libpulse0:i386

To configure the headset, first start skype and pavucontrol:

    pavucontrol &
    skype &

Start a test call in Skype, change the recording input and output of
the Skype application (in pavucontrol) to the USB headset.

## Thunderbird binary tarball

To avoid errors about the xul library on Debian wheezy:

    sudo apt-get install ia32-libs-gtk

On Debian testing there are these errors:

    XPCOMGlueLoad error for file /home/carlo/opt/thunderbird-24.1.0/libxul.so:
    libgtk-x11-2.0.so.0: cannot open shared object file: No such file or directory

    XPCOMGlueLoad error for file /home/carlo/opt/thunderbird-24.1.0/libxul.so:
    libdbus-glib-1.so.2: cannot open shared object file: No such file or directory
    Couldn't load XPCOM.

so fix with:

    sudo apt-get install libdbus-glib-1-2:i386 libgtk2.0-0:i386

Run from my own binary tarball:

    ~/opt/thunderbird-24.1.0/thunderbird

Something is wrong with my Thunderbird profile as it tries to run firefox no matter what:

    $ grep firefox .thunderbird/l3fwjt8m.default/*js
    user_pref("network.protocol-handler.app.ftp", "/opt/firefox/firefox");
    user_pref("network.protocol-handler.app.http", "/opt/firefox/firefox");
    user_pref("network.protocol-handler.app.https", "/opt/firefox/firefox");

so here is an ugly work-around:

    sudo mkdir -p /opt/firefox
    sudo ln -s /usr/bin/google-chrome /opt/firefox/firefox

## Dropbox

    sudo dpkg -i d/dropbox_1.6.0_amd64.deb


## Newer kernel

Webcam may not work by default, so just build a newer kernel with
the uvc video things turned on:

    sudo apt-get install libncurses5 libncurses5-dev kernel-package
    cd ~/opt
    wget -c https://www.kernel.org/pub/linux/kernel/v3.x/linux-3.13.7.tar.xz
    cd /usr/src
    sudo su -
    tar Jxf /home/carlo/opt/linux-3.13.7.tar.xz
    cd linux-3.13.7
    make mrproper
    make clean
    wget https://raw.github.com/carlohamalainen/dotfiles/master/config-3.13.7-for-x1-carbon -O .config
    make oldconfig
    make-kpkg --rootcmd fakeroot --config menuconfig --initrd --us --uc -j 4 kernel_image
    cd ..
    dpkg -i linux-image-3.13.7_3.13.7-10.00.Custom_amd64.deb

Reboot, check that the built-in webcam works.

## Python bits

    wget https://raw.github.com/pypa/pip/master/contrib/get-pip.py
    sudo python get-pip.py
    sudo pip install youtube-dl
    sudo pip install pyflakes
    sudo pip install markdown
    sudo pip install jinja2 tornado # for latest ipython

## MATE desktop

    wget -qO - http://mirror1.mate-desktop.org/debian/mate-archive-keyring.gpg | sudo apt-key add -
    sudo apt-get update
    sudo apt-get install mate-desktop-environment-extra


# Haskell

Sometimes necessary to blow away cabal and ghc directories if changing overall versions:

    rm -fr .cabal .ghc # if necessary

## Build GHC 7.6.3 and Haskell Platform 2013

Download source from [http://www.haskell.org/ghc/download_ghc_7_6_3](http://www.haskell.org/ghc/download_ghc_7_6_3).

    sudo apt-get install ghc libncurses5 libncurses5-dev    \
                         xsltproc docbook-xsl hscolour      \
                         libgl1-mesa-dev                    \
                         libglc-dev                         \
                         freeglut3-dev                      \
                         libedit-dev                        \
                         libglw1-mesa libglw1-mesa-dev      \
                         happy alex

    cd ~/opt
    rm -fr ghc-7.6.3_build/*
    cd ghc-7.6.3
    make clean
    ./configure --prefix=$HOME/opt/ghc-7.6.3_build &> configure.log

Check configure.log to see if the HTML documentation will be built.

    make && make install
    echo 'export PATH=$HOME/opt/ghc-7.6.3_build/bin:$PATH' >> $HOME/.bashrc
    cd ..

Get a new shell or set the $PATH manually, make sure that the new GHC binary is the default:

    $ which ghc
    /home/carlo/opt/ghc-7.6.3_build/bin/ghc

Download the Haskell Platform from [http://www.haskell.org/platform/linux.html](http://www.haskell.org/platform/linux.html).

    cd ~/opt
    tar zxf haskell-platform-2013.2.0.0.tar.gz
    cd haskell-platform-2013.2.0.0
    ./configure --prefix=$HOME/opt/haskell-platform-2013.2.0.0_build/
    make && make install
    echo 'export PATH=$HOME/opt/haskell-platform-2013.2.0.0_build/bin:$PATH' >> $HOME/.bashrc
    cd ~

Get a new shell or set the $PATH manually.

## Cabal

Install a newer cabal binary:

    echo 'export PATH=$HOME/.cabal/bin:$PATH' >> ~/.bashrc

    cabal update

Some of the cabal defaults are [inappropriate](http://www.vex.net/~trebla/haskell/cabal-cabal.xhtml).

    sed -i 's/-- documentation: False/documentation: True/g'         ~/.cabal/config
    sed -i 's/-- library-profiling: False/library-profiling: True/g' ~/.cabal/config

    sed -i 's/-- jobs:/jobs: $ncpus/g' ~/.cabal/config

Now install the latest cabal:

    cabal install --haddock-hyperlink-source cabal-install
    cabal update


When running cabal install, *always* add the --haddock-hyperlink-source option:

    cabal install --haddock-hyperlink-source

Apparently this is a known issue, has been open for two years: [https://github.com/haskell/cabal/issues/931](https://github.com/haskell/cabal/issues/931).
I guess everyone else is using online documentation only? Handy:

    alias ci='cabal install --haddock-hyperlink-source'

## My Haskell stuff

### Checker

    cd ~/work/github/checker
    ci
    cd

### Camera scripts

    cd ~/work/github/camera-scripts
    ci
    cd

## Haskell other

Need ```ghci-ng``` to get haskell-mode to work:

    ci ghci-ng

## Haskell and Vim integration

See [https://github.com/carlohamalainen/dotfiles/blob/master/.vimrc](vimrc) for details on making all these plugins work.

### Tools

    ci hoogle ghc-mod hdevtools
    hoogle data

### Pathogen (for ease of installing Vim modules):

    mkdir -p ~/.vim/autoload ~/.vim/bundle;
    curl -Sso ~/.vim/autoload/pathogen.vim https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim

Ensure that these lines are in ~/.vimrc:

    execute pathogen#infect()
    syntax on
    filetype plugin indent on

### Syntastic

    cd ~/.vim/bundle
    git clone https://github.com/scrooloose/syntastic.git
    cd ~

### vimproc

Prerequisite for ghc-mod:

    git clone https://github.com/Shougo/vimproc.vim.git ~/.vim/bundle/vimproc.vim
    cd ~/.vim/bundle/vimproc.vim
    make
    cd

### ghcmod-vim

Install ghcmod-vim:

    cd ~/.vim/bundle/
    git clone https://github.com/eagletmt/ghcmod-vim.git
    cd

Add a symlink so that it works with .lhs files as well:

    cd ~/.vim/bundle/ghcmod-vim/after/ftplugin
    ln -s haskell/ lhaskell
    cd

## TODO

* https://github.com/ujihisa/neco-ghc
* http://majutsushi.github.com/tagbar  combined with https://github.com/bitc/lushtags
* https://github.com/Shougo/neocomplcache.vim

## MINC/Nipype

### volgenmodel...

    sudo apt-get install octave

### Minc toolkit

    sudo apt-get install cmake cmake-curses-gui
    sudo apt-get install \
                 build-essential g++ \
                 cmake cmake-curses-gui \
                 bison flex \
                 freeglut3 freeglut3-dev \
                 libxi6 libxi-dev libxmu6 libxmu-dev libxmu-headers

    git clone --recursive git://github.com/BIC-MNI/minc-toolkit.git minc-toolkit
    cd minc-toolkit
    rm -fr build
    mkdir build
    cd build

    ccmake ..  # hit 'c'
               # go down to MT_BUILD_SHARED_LIBS, hit enter to turn 'ON'
               # hit 'c'
               # hit 'g'
               #
    make &> make.log   # check the log!
    sudo make install




# TODO - the rest

    # XMonad
    sudo apt-get install libxrandr-dev trayer
    cabal update
    cabal install xmonad xmonad-contrib xmonad-extras xmonad-utils

    # Edit /usr/share/xsessions/xmonadcarlo.desktop

    [Desktop Entry]
    Encoding=UTF-8
    Name=xmonadcarlo
    Comment=This session starts xmonad
    Exec=/home/carlo/.cabal/bin/xmonad
    Type=Application

    # As normal user:
    xmonad --recompile


    #####################



    ## pyminc
    # git clone FIXME
    cd pyminc
    sudo python setup.py install

    ## nipype
    sudo pip install nibabel
    sudo pip install traits traitsui
    cd nipype
    sudo rm -fr build && sudo python setup.py install

