#!/bin/bash

set -o nounset

# http://en.linuxreviews.org/HOWTO_Convert_audio_files

mplayer \
    -quiet \
    -vo null \
    -vc dummy \
    -ao pcm:waveheader:file="$2" $1

