#!/bin/bash

# http://askubuntu.com/questions/247961/normalizing-video-volume-using-avconv

VIDEO_FILE=$1
VIDEO_FILE_FIXED=${VIDEO_FILE%.*}-fixed.${VIDEO_FILE##*.}
avconv -i $VIDEO_FILE -c:a pcm_s16le -vn audio.wav
normalize-audio audio.wav
avconv -i $VIDEO_FILE -i audio.wav -map 0:0 -map 1:0 -c:v copy -c:a libvo_aacenc \
       $VIDEO_FILE_FIXED

