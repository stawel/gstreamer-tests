
# Description

Catch deadlock in gstreamers queue2 when activate_pull(..., false) is called

# Setup

- raspbery pi 400 (Debian GNU/Linux 11 (bullseye), 64 bit version), Ubuntu 20.04 x86_64
- gstreamer: 1.21.0 (GIT) branch: main (0151d621afbde1e267c64f2697da0146b72d7f6a), 1.18.3
- build command line: meson builddir -Dgst-plugins-base:gl=disabled

# Reproduction

1. in terminal 1 run:
pi@raspberrypi:~/queue2_deactivate_pull_deadlock $ python2 serve_http.py  # run a http server with "range" - any should do

2. in terminal 2 run:
[main] pi@raspberrypi:~/queue2_deactivate_pull_deadlock $ ./deadlock.sh
after a while (5 minuts) you should se:
Mon 22 Aug 2022 07:36:49 PM BST ............ Test: 91
[...]
0:00:00.178975027 13507   0x7f980086a0 DEBUG                 queue2 gstqueue2.c:1300:update_in_rates:<queue2-0> rates: in 0.000000, time 0:00:00.000000000
0:00:00.179027581 13507   0x7f980086a0 LOG                   queue2 gstqueue2.c:1033:get_buffering_level:<queue2-0> Cur level bytes/time/rate-time/buffers 0/0:00:00.000000000/0:00:00.000000000/0
0:00:00.179074710 13507   0x7f980086a0 DEBUG                 queue2 gstqueue2.c:1071:get_buffering_level:<queue2-0> buffering 1, level 0
0:00:00.182656692 13507   0x55bed11c00 DEBUG                 queue2 gstqueue2.c:2744:gst_queue2_handle_sink_event:<queue2-0> refusing event, we are flushing
0:00:00.183046351 13507   0x55bed11c00 DEBUG                 queue2 gstqueue2.c:2744:gst_queue2_handle_sink_event:<queue2-0> refusing event, we are flushing
0:00:00.183098535 13507   0x55bed11c00 DEBUG                 queue2 gstqueue2.c:2744:gst_queue2_handle_sink_event:<queue2-0> refusing event, we are flushing
[deadlock]

callstack: see gdb_deadlock.log
full queue2 logs: see queue2.log




# Reproduction on Ubuntu 20.04

1. as above

2. in terminal 2 run:
[main] pi@raspberrypi:~/queue2_deactivate_pull_deadlock $ ./deadlock-quit-random.sh
(reproduction time less 3 minuts)
