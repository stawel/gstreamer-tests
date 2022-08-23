#!/bin/bash

#tested on raspbery pi 400

URI=http://localhost:8000/file_example_MP3_5MG.mp3
QUIT_TIME=0.14
# QUIT_TIME may need adjustments
# it is set based on:
#   [main] pi@raspberrypi:~/queue2_deactivate_pull_deadlock $ ./deadlock.sh 2>&1 | grep -i 'wait\|Test'
#   Mon 22 Aug 2022 07:47:48 PM BST ............ Test: 1
#   0:00:00.118510516 13739   0x7fb4008520 DEBUG                 queue2 gstqueue2.c:1616:gst_queue2_create_read:<queue2-0> waiting for add
#   0:00:00.139924009 13739   0x7fb40221e0 DEBUG                 queue2 gstqueue2.c:1616:gst_queue2_create_read:<queue2-0> waiting for add
#
# we are trying to hit near  0:00:00.139924009 - the second "waiting for add"



for i in {1..1000}
do
    echo "$(date) ............ Test: $i"
    ( sleep $QUIT_TIME ; killall -2 gst-launch-1.0 ) &
    GST_DEBUG=queue2:7 gst-launch-1.0 urisourcebin buffer-size=5242880 ring-buffer-max-size=20971520 uri=$URI ! decodebin3 ! audioconvert  ! autoaudiosink
done
