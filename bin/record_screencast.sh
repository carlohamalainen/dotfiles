#!/bin/bash

if [ $# -gt 0 ]; then
    file=$1
    ffmpeg -f alsa -i default  -f x11grab -show_region 1 -s cif -r 25 -s 1280x720 -i :0.0+100,100 -acodec pcm_s16le -vcodec libx264 -preset ultrafast -crf 0 -threads 0 $file
else
    echo
    echo "Handy wmctrl command to resize and relocate the terminal windows:"
    echo
    echo "wmctrl -l | grep Terminal | cut -f 1 -d ' ' | xargs -n 1 wmctrl -e 0,100,100,1280,720 -i -r"
    echo
fi
