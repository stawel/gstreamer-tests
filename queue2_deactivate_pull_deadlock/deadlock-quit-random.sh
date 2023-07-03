#!/bin/bash

#tested on ubuntu 20.04 x86_64, CPU: intel i7-2630QM 2GHz

URI=http://localhost:8000/file_example_MP3_5MG.mp3

QUIT_START=0.08
QUIT_GAP=0.04
# QUIT_TIME = random value from [QUIT_START, QUIT_START + QUIT_GAP]
# it is set based on:
#   [main] pi@raspberrypi:~/queue2_deactivate_pull_deadlock $ ./deadlock.sh 2>&1 | grep -i 'wait\|Test'
#   wto, 23 sie 2022, 18:01:05 CEST ............ Test: 1
#   0:00:00.090358344 570067 0x7f5f8c008920 DEBUG                 queue2 gstqueue2.c:1616:gst_queue2_create_read:<queue2-0> waiting for add
#   0:00:00.097794516 570067 0x7f5f78007640 DEBUG                 queue2 gstqueue2.c:1616:gst_queue2_create_read:<queue2-0> waiting for add
#
# we are trying to hit near 0:00:00.097794516 - the second "waiting for add"



for i in {1..10000}
do
    QUIT_TIME=$(python -c "import random ; print($QUIT_START+random.random()*$QUIT_GAP)")
    echo "$(date) ............ Test: $i  quit time: $QUIT_TIME"
    ( sleep $QUIT_TIME ; killall -2 gst-launch-1.0 ) &
    #GST_DEBUG=queue2:7 
    gst-launch-1.0 urisourcebin buffer-size=5242880 ring-buffer-max-size=20971520 uri=$URI ! decodebin3 ! audioconvert  ! autoaudiosink
done
