####################
### missing sequence

Description:
gst-play-1.0 playback freezes when playing a *.m3u8 with missing sequence

NOTE: file playlist_384_216_500k_6553215.ts in 3/3-*.m3u8 is commented out,
the intention is to simulate a server choking

Reproduction:
in terminal 1 run:
$ cd gstreamer-tests/vtt-subtitles/missing-sequence/1026_cheddar_news/
gstreamer-tests/vtt-subtitles/missing-sequence/1026_cheddar_news$ python3 -m http.server
Serving HTTP on 0.0.0.0 port 8000 (http://0.0.0.0:8000/) ...

in terminal 2 run:
$ gst-play-1.0 http://localhost:8000/playlist-missing-sequence-ts.m3u8 --use-playbin3
[playback freezes]
$ gst-play-1.0 http://localhost:8000/playlist-missing-sequence-ts-vtt.m3u8 --use-playbin3
[playback freezes]

Other scenarios:
$ gst-play-1.0 http://localhost:8000/playlist-origin.m3u8 --use-playbin3
[WORKS - m3u8 with no modifications]
$ gst-play-1.0 http://localhost:8000/playlist-missing-sequence-ts-vtt-with-discontinuity.m3u8 --use-playbin3
[WORKS]
$ gst-play-1.0 http://localhost:8000/playlist-missing-sequence-vtt.m3u8 --use-playbin3
[WORKS]

Expected behavior:
It's hard to say so I assume the behavior of hls.js and vlc is correct/desirable:
the playback should play the whole *.m3u8 with a still image in the middle lasting for 6 seconds.


----------------------------------------------
testing in hls.js player, in firefox:
1. enable mixed-content in firefox: https://experienceleague.adobe.com/docs/target/using/experiences/vec/troubleshoot-composer/mixed-content.html?lang=en
   or install https://addons.mozilla.org/en-US/firefox/addon/access-control-allow-origin/
2. open in firefox: https://hlsjs.video-dev.org/demo/
   - select: '.... enter custom URL below'
   - enter url: http://localhost:8000/playlist-missing-sequence-ts.m3u8
3. start video




################
### missing file

[to be continued]

Observed behavior:
immediately exits with an error

Expected behavior:
should behave as above?? or similar to vlc?







