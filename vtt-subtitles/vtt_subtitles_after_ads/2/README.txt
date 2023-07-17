
Description:
No subtitles after #EXT-X-DISCONTINUITY

in terminal 1 run:
gstreamer-tests/vtt-subtitles/vtt_subtitles_after_ads/2$ python2 serve_http.py
serving at port 8000

in terminal 2 run:
F=http://localhost:8000/subtitles/vtt_subtitles_after_ads/2/playlist.m3u8
$ gst-play-1.0 http://localhost:8000/playlist.m3u8 --use-playbin3



----------------------------------------------
testing in hls.js player, in firefox (note: use localhost as ip):
1. enable mixed-content in firefox: https://experienceleague.adobe.com/docs/target/using/experiences/vec/troubleshoot-composer/mixed-content.html?lang=en
2. open in firefox: https://hls-js.netlify.app/demo/
   - select: '.... enter custom URL below'
   - enter url: http://localhost:8000/playlist.m3u8
3. start video
4. select: "[cc]->English[VTT]" - left bottom corner



----------------------------------------
Expected subtitles (in ~00:02:01.019):
[TEST1] All right.\nHold up.
[TEST2] [Exhales]
[TEST3] Hop on.
[TEST4] -Are you serious?\n-Yeah.
[TEST5] This is a serious piggyback.\nJump up.
[TEST6 END] You're heavier\nthan you look.
