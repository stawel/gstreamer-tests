#!/bin/bash

## tested commit b09ae1d63557987340992760cfa8291ecec79fe7 on raspberry pi 400


### in terminal 1, run:
# python -m http.server


### in terminal 2, run:

## for raspberry pi 400
KILL_START=5.1
KILL_GAP=0.8

## alternatively
#KILL_START=5
#KILL_GAP=2

IP=localhost
HLS1=http://$IP:8000/resolution_change.m3u8

ulimit -c unlimited
[ -f core ] && mv core "core_$RANDOM"

for((i=0;i<200;i++)); do
    SLEEP_TIME=$(python -c "import random ; print($KILL_START+random.random()*$KILL_GAP)")
    echo "################################### $(date) #### test $i, sleep time $SLEEP_TIME"
    gst-launch-1.0 --no-fault souphttpsrc location="$HLS1" ! hlsdemux ! parsebin ! v4l2h264dec ! autovideosink &
    sleep $SLEEP_TIME                        # this time is crucial
    pkill -2 gst-launch-1.0                  # stop gstreamer
    wait
    [ -f core ] && break
done

## you should get after ~20 iterations:
## ./readme.txt: line 30: 12861 Segmentation fault      (core dumped) gst-launch-1.0 --no-fault souphttpsrc location="$HLS1" ! hlsdemux ! parsebin ! v4l2h264dec ! autovideosink
