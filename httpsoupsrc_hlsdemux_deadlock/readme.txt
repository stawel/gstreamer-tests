
This test reproduces a deadlock in gstreamer in souphttpsrc and hlsdemux,
The provided http_server.py will pause for 2 seconds when a file is missing,
all *.ts files are missing.

reproduced in commit: cb2299466b (origin/main)  (near tag: 1.27.2)
reproduced in commit: 4dd10d1aa8 (origin/1.24)  (near tag: 1.24.13)

# Reproduction

run in terminal 1 (http server):
```
httpsoupsrc_hlsdemux_deadlock$ python3 http_server.py
port: 8000
```

run in terminal 2:
```
httpsoupsrc_hlsdemux_deadlock$ ./httpsoupsrc_hlsdemux_deadlock.sh
Setting pipeline to PAUSED ...
Got context from element 'souphttpsrc0': gst.soup.session=context, session=(GstSoupSession)NULL;
Pipeline is PREROLLED ...
Setting pipeline to PLAYING ...
New clock: GstSystemClock
Got context from element 'souphttpsrc2': gst.soup.session=context, session=(GstSoupSession)NULL;
Got context from element 'souphttpsrc2': gst.soup.session=context, session=(GstSoupSession)NULL;
Got context from element 'souphttpsrc2': gst.soup.session=context, session=(GstSoupSession)NULL;
handling interrupt.
stop stream
Interrupt: Stopping pipeline ...
Execution ended after 0:00:09.986798669
Setting pipeline to NULL ...
We have a DEADLOCK!!!
```
if you don't see "We have a DEADLOCK!!!" try again.


# Alternative to ./httpsoupsrc_hlsdemux_deadlock.sh

You can run gst-launch-1.0 maually:
```
[main] gstreamer$ gst-launch-1.0 souphttpsrc location=http://localhost:8000/The_Jack_Hanna_Channel.m3u8 ! hlsdemux

[wait ~11 seconds, press CTRL-C]

Interrupt: Stopping pipeline ...
Execution ended after 0:00:09.986798669
Setting pipeline to NULL ...
```
repeat the above until you get a deadlock (gst-launch-1.0 will not exit)




