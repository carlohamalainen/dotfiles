# Ubuntu 16.04 on Lenovo X1 Carbon (4th gen)

## Workspaces in Ubuntu 17

    gsettings set org.compiz.core:/org/compiz/profiles/unity/plugins/core/ hsize 9
    gsettings set org.compiz.core:/org/compiz/profiles/unity/plugins/core/ vsize 1

## 4.4 kernel

Install linux-image and linux-headers from http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.4.14-xenial

## Haskell

### GHC PPA

Add the PPA:

    sudo add-apt-repository ppa:hvr/ghc

Install the latest:

    sudo apt-get install ghc-8.0.1 ghc-8.0.1-prof ghc-8.0.1-dyn ghc-8.0.1-htmldocs

Add ```/opt/ghc/8.0.1/bin``` to ```$PATH```. Open a new terminal.

Newer cabal:

    cabal update
    cabal install cabal-install

Add ```$HOME/.cabal/bin``` to front of ```$PATH```.

    sed -i 's/-- documentation: False/documentation: True/g'         ~/.cabal/config

### xmonad

    sudo apt-get install libxrandr-dev trayer feh            \
         libghc-xmonad-contrib-dev libghc-xmonad-contrib-doc \
         libghc-xmonad-dev libghc-xmonad-doc xmonad

### All the things

    sudo apt-get install unison-all-gtk meld vim-gtk build-essential git colordiff             \
                         ghc rsync sshfs xinput ipython python-nose python-networkx            \
                         python-setuptools python-numpy python-scipy graphviz ecryptfs-utils   \
                         cryptsetup pavucontrol screen durep baobab keepassx xinput htop       \
                         transmission-gtk gnupg2 vlc mplayer                                   \
                         calibre conky-all geeqie libjpeg-progs                                \
                         tcsh inkscape mpop flac moreutils tcl-tclreadline                     \
                         genisoimage gitk rdiff-backup unrar ffmpeg wmctrl exiftags            \
                         iotop audacity pdftk                                                  \
                         kino vorbis-tools ffmpeg2theora iftop pdf2djvu cpphs parted           \
                         libgetopt-tabular-perl libblas-dev libblas3                           \
                         liblapack-dev liblapack3 fort77 gfortran gfortran-multilib ack-grep   \
                         libdata-dump-perl libdata-printer-perl stress winpdb strace djview    \
                         libhdf5-serial-dev btrfs-tools emacs24 beep autoconf                  \
                         python-appindicator libappindicator3-1 libappindicator3-dev           \
                         gir1.2-appindicator3-0.1 llvm libgc-dev ocaml camlp5                  \
                         liblablgtk2-ocaml-dev liblablgtk2-gl-ocaml-dev                        \
                         liblablgtk-extras-ocaml-dev liblablgtksourceview2-ocaml-dev           \
                         liblablgtkmathview-ocaml-dev hevea texlive-fonts-recommended          \
                         texlive-latex-extra texlive-math-extra libav-tools normalize-audio    \
                         cmake network-manager-vpnc sqlitebrowser mediainfo pwgen              \
                         autossh gvncviewer blueman mailutils ssmtp                            \
                         mate-desktop mate-desktop-environment                                 \
                         mate-desktop-environment-core                                         \
                         mate-desktop-environment-extra                                        \
                         mate-desktop-environment-extras                                       \
                         xsel rsnapshot vim-gtk3                                               \
                         pcscd scdaemon gnupg2 gpgsm pcsc-tools yubikey-personalization-gui    \
                         yubikey-neo-manager yubikey-personalization scdaemon hashalot

    sudo apt-get install apt-file
    sudo apt-file update

### BlogLiterately

    sudo apt-get install libssl-dev libcrypto++-dev
    stack install BlogLiterately

Add ```$HOME/.local/bin/``` to the start of ```$PATH```.

## Owncloud icon missing

https://github.com/owncloud/client/issues/4693#issuecomment-214365805

    sudo apt purge appmenu-qt5

### Thunderbird derp

Don't know why, but my thunderbird profile tries to open URLs
with ```/opt/firefox/firefox``` so just workaround with:

    sudo mkdir /opt/firefox
    sudo ln -s /usr/bin/firefox /opt/firefox/firefox

### Python bits

    sudo apt-get install python-pip
    sudo pip install youtube-dl
    sudo pip install pyflakes
