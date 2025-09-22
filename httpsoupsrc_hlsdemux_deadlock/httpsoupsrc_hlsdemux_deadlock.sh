#!/bin/bash


# stop pipeline after ~9 seconds
( sleep 10 ; pkill -SIGINT gst-launch-1.0 ; echo 'stop stream' ; sleep 1; echo -n 'We have a DEADLOCK!!!' ) &

gst-launch-1.0 souphttpsrc location=http://localhost:8000/The_Jack_Hanna_Channel.m3u8 ! hlsdemux

wait
echo -e '\r Gstreamer exited witout issues, try again!!'

