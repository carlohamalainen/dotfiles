#!/usr/bin/python

## This script helps you to record pulseaudio streams
## Originally posted by durand on 2009-07-06 to the 
## Ubuntu forum: http://ubuntuforums.org/archive/index.php/t-986966.html


# Filename of the recording
filename = "recording.ogg"
# Bitrate of the recording in kbps
bitrate = 192

import os

# Get a list of pulseaudio objects
objects = os.popen('pactl list').read().split('\n\n')
# Form dictionaries containing the details of the 
# inputs
streams = {}
for object in objects:
    if "Sink Input" in object:
        object = object.replace('\t','').split('\n')
        # Get the stream id
        id = object[0].split('#')[-1]
        # Get the stream's name and app to identify it
        for info in object:
            if "media.name" in info:
                media_name = info.replace('"','').split(' = ')[-1]
            if "application.name" in info:
                app_name = info.replace('"','').split(' = ')[-1]
        # Add the details to the dictionary
        streams[id] = (app_name,media_name)

# Display the streams and ask the user to choose one to record
id = 0
stream_list = streams.keys()
for stream in stream_list:
    id += 1
    print str(id) + ") " + streams[stream][0] + ": " + streams[stream][1]
print
try:
    stream_id = int(raw_input("ID of stream to record: "))
except:
    stream_id = -1
while stream_id not in range(1,id+1):
    print stream_id,range(1,id+1)
    try:
        stream_id = int(raw_input("ID of stream to record: "))
    except:
        stream_id = -1
# Get the PA id of the stream to record
stream_id = stream_list[stream_id-1]
# Load a null sink
print "Loading a null sink..."
null_id = os.popen('pactl load-module module-null-sink').read()

# Start recorder and get its pid to kill it later. We need to use threads here to background it.
print "Starting recorder..."
import threading
class Recorder(threading.Thread):
    def run(self):
        try:
            os.popen('arecord -f cd -t raw | oggenc -b %s -o %s --raw -'%(bitrate,filename))
        except KeyboardInterrupt:
            print "I'm not quitting!"
Recorder().start()

# Wait for arecord to load
import time
time.sleep(2)
objects = os.popen('pactl list').read().split('\n\n')

for object in objects:
    # Get name of the null sink
    if "Sink #" in object and "Owner Module: " + null_id in object:
        object = object.replace('\t','').split('\n')
        for info in object:
            if "Name: null" in info:
                null_name = info.replace('Name: ','')
    # Get recorder id (Assume that it is the last Source Output)
    if "ALSA Capture" in object:
        object = object.replace('\t','').split('\n')
        recorder_id = object[0].split('#')[-1]

# Move stream to null sink
print "Moving %s to %s..."%(streams[stream_id][1],null_name)
os.popen('pactl move-sink-input %s %s'%(stream_id,null_name))

# Move recorder to null monitor
print "Moving recorder to %s..."%null_name
os.popen('pactl move-source-output %s %s'%(recorder_id,null_name+".monitor"))

print "Stream recording to %s!"%filename
