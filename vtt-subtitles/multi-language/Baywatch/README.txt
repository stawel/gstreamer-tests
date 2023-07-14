
Description:
gst-play-1.0 playback freezes when switching on/off subtitles

Reproduction:
in terminal 1 run:
gstreamer-tests/vtt-subtitles/multi-language/Baywatch$ python3 -m http.server
Serving HTTP on 0.0.0.0 port 8000 (http://0.0.0.0:8000/) ...

in terminal 2 run:
$ gst-play-1.0 http://localhost:8000/playlistEng.m3u8 --use-playbin3
[press s]
[press s] - video should freeze






