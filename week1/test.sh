#!/bin/bash

DIR=week1
ORIGINAL19=in2040-2019-01.mp4
FPIMAGE=/home/shiela/Documents/Jobs/week1/frontpages/frontpage-01-03.jpg
FPVIDEO=frontpage.mp4
TIME=5
SEGMENT=5-predikater.mp4
FPS=15
OUTPUT=in2040-2020-01-04.mp4


ffmpeg -y -i $ORIGINAL19 -ss 00:00:00 -c copy -to 00:03:00 -an out.mp4
ffmpeg -y -i $ORIGINAL19 -ss 00:13:56 -c copy -to 00:20:02.5 $DIR/$SEGMENT

#ffmpeg -y -loop 1 -t 10 -i in2040-01-02.jpg -f lavfi -t 10 -i aevalsrc=0 -vf settb=1/15,scale=1920/1080,setsar=1/1,setdar=16/9 -video_track_timescale 30000 -c:v libx264 -pix_fmt yuv420p -color_primaries 1 -color_trc 1 -colorspace 1 -b:v 152k -b:a 54k -ar 22050 frontpage.mp4

ffmpeg -y -loop 1 -t $TIME -framerate 15 -i $FPIMAGE -f lavfi -t $TIME -i aevalsrc=0 -vf settb=1/15,scale=1920/1080,setsar=1/1,setdar=16/9 -video_track_timescale 30000 -c:v libx264 -pix_fmt yuv420p -color_primaries 1 -color_trc 1 -colorspace 1 -b:v 152k -b:a 54k -ar 22050 $FPVIDEO

# Video options:
-b:v 152k #208k ?
-c:v h264 #libx264 ?
-pix_fmt yuv420p -colorspace bt709 -color_range tv -color_trc bt709 -color_primaries bt709
-r #?
-s 1920/1080
-vf settb=1/15,setsar=1/1,setdar=16/9 #?
-video_track_timescale 30k
-vf scale=1920/1080


-qscale:v 2
-crf 0

# Audio options:
-b:a 54k
-c:a #?
-ar 22050

ffmpeg -f lavfi -i aevalsrc=0:duration=3:sample_rate=16000

ffmpeg -y -loop 1 -t $TIME -framerate 15 -i $FPIMAGE -f lavfi -t $TIME -i aevalsrc=0 -ar 22050 -vf scale=1920/1080,setsar=1/1 -pix_fmt yuv420p -colorspace bt709 -color_range tv -color_trc bt709 -color_primaries bt709 -video_track_timescale 30k -c:v h264 $FPVIDEO

# Check specifications:
ffprobe $FPVIDEO
ffprobe $ORIGINAL19

# Trying to merge only audio: WORKS
ffmpeg -f lavfi -t $TIME -i aevalsrc=0 -ar 22050 audio.mp4
ffmpeg -i $DIR/$SEGMENT -vn -c:a copy videoaudio.mp4
echo $'file audio.mp4\nfile videoaudio.mp4' > audio.txt

# had to do this for audio + video: -f lavfi -i anullsrc=channel_layout=mono:sample_rate=22050

ffmpeg -f concat -safe 0 -i audio.txt -c copy concataudio.mp4

# Trying to merge only video:
ffmpeg -y -loop 1 -framerate 15 -i image.jpg -c:v libx264 -t $TIME -pix_fmt yuv420p image.mp4

ffmpeg -y -loop 1 -t $TIME -framerate 15 -i $FPIMAGE -video_track_timescale 30k -pix_fmt yuv420p -colorspace bt709 -color_range tv -color_trc bt709 -color_primaries bt709 -vf setdar=16/9,scale=1920x1080 -qscale:v 0 image.mp4
ffmpeg -y -i $DIR/$SEGMENT -an -video_track_timescale 30k -qscale:v 0 -c:v copy videoimage.mp4
echo $'file image.mp4\nfile videoimage.mp4' > video.txt

ffmpeg -y -auto_convert 1 -f concat -safe 0 -i video.txt -c copy concatvideo.mp4

# New options to try: WORKED!!!  :D:D:D
-brand mp42
# Trying:
ffmpeg -y -loop 1 -t $TIME -framerate 15 -i $FPIMAGE -brand mp42 -video_track_timescale 30k -pix_fmt yuv420p -colorspace bt709 -color_range tv -color_trc bt709 -color_primaries bt709 -vf setdar=16/9,scale=1920x1080 -qscale:v 0 image.mp4
ffmpeg -y -i $DIR/$SEGMENT -an -video_track_timescale 30k -qscale:v 0 -c:v copy videoimage.mp4
echo $'file image.mp4\nfile videoimage.mp4' > video.txt
ffmpeg -y -auto_convert 1 -f concat -safe 0 -i video.txt -c copy concatvideo.mp4


# Trying to merge both audio and video: -acodec aac -strict -2
ffmpeg -y -f lavfi -t $TIME -i anullsrc=channel_layout=mono:sample_rate=22050 -loop 1 -t $TIME -framerate 15 -i $FPIMAGE -brand mp42 -video_track_timescale 30k -pix_fmt yuv420p -colorspace bt709 -color_range tv -color_trc bt709 -color_primaries bt709 -vf setdar=16/9,scale=1920x1080 video1.mp4
#ffmpeg -y -i video1.mp4 -f lavfi -t $TIME -i anullsrc=channel_layout=mono:sample_rate=22050 -video_track_timescale 30k -c:v copy -c:a libfdk_aac videovideo.mp4
#ffmpeg -y -i $DIR/$SEGMENT -video_track_timescale 30k -c copy video4.mp4
ffmpeg -y -loop 1 -t $TIME -framerate 15 -i $FPIMAGE -f lavfi -i anullsrc=channel_layout=mono:sample_rate=22050 -shortest -brand mp42 -video_track_timescale 30k -pix_fmt yuv420p -colorspace bt709 -color_range tv -color_trc bt709 -color_primaries bt709 -vf setdar=16/9,scale=1920x1080 -qscale:v 0 image.mp4
ffmpeg -i image.mp4 -f lavfi -i aevalsrc=0 -shortest imageaudio.mp4
echo $'file image.mp4\nfile video4.mp4' > videovideo.txt
ffmpeg -y -f concat -safe 0 -i videovideo.txt -c copy concatvideovideo.mp4

# ffprobe -show_streams (some differences )
codec_time_base=181267/5438000
has_b_frames=0
avg_frame_rate=2719000/181267
start_pts=119640

# creating a black screen
ffmpeg -y -f lavfi -i color=black:s=1920x1080:r=15 -f lavfi -i anullsrc -ar 22050 -t 10 -c:v h264 -video_track_timescale 30k -aspect 16/9 black.avi
echo $'file week1/0-oversikt.mp4\nfile videoimage.mp4' > blackvideo.txt

ffmpeg -y -f concat -safe 0 -i blackvideo.txt -c copy concatblackvideo.mp4

ffmpeg -i $ORIGINAL19 -ss 00:01:00 -c copy -t $TIME shortclip.mp4

# Placing image in the middle =(W-w)/2:(H-h)/2
ffmpeg -y -i shortclip.mp4 -i $FPIMAGE -filter_complex "overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2" -c:v h264 -c:a copy 10 -b 208k -b:v out.mp4
echo $'file out.mp4\nfile week1/0-oversikt.mp4' > shortclipvideo.txt

ffmpeg -y -f concat -safe 0 -i shortclipvideo.txt -c copy shortclipvideo.mp4

ffmpeg -y -i $DIR/$SEGMENT -i $FPIMAGE -filter_complex "overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2:enable" -c:v h264 -c:a copy 10 -b 208k -b:v out.mp4

# Trying with re-encoding (-ar 22050)
ffmpeg -y -f lavfi -i anullsrc=channel_layout=mono:sample_rate=22050 -loop 1 -framerate $FPS -t $TIME -i $FPIMAGE -pix_fmt yuv420p -colorspace bt709 -color_range tv -color_trc bt709 -color_primaries bt709 -s 1920x1080 -c:v copy -c:a aac -shortest picture.mp4
#ffmpeg -f lavfi -i anullsrc=channel_layout=mono:sample_rate=22050 -i picture.mp4 -c:v copy -c:a aac -shortest output1.mp4
ffmpeg -i picture.mp4 \
       -i $DIR/$SEGMENT \
       -filter_complex '[0:0] [1:0] [2:0] [2:1] concat=n=2:v=1:a=1' \
       -c:v h264 \
       -pix_fmt yuv420p -colorspace bt709 -color_range tv -color_trc bt709 -color_primaries bt709 $OUTPUT

ffmpeg -loop 1 -framerate FPS -t SECONDS -i IMAGE \
      -i INPUTVIDEO \
      -filter_complex '[0:0] [1:0] concat=n=2:v=1:a=0' \
      [OPTIONS] OUTPUT

# Trying without re-encoding again
ffmpeg -i "concat:picture.mp4|week1/0-oversikt.mp4" output.mp4

# Trying with re-encoding

# Resizing image
ffmpeg -framerate $FPS -loop 1 -t $TIME -i $FPIMAGE -vf scale=1920/1080,setsar=1/1,setdar=16/9 test.mp4
# Adding frontpage
ffmpeg -i test.mp4 -i $DIR/$SEGMENT -f lavfi -t $TIME -i aevalsrc=0 -filter_complex "[0:v] [2:a] [1:v] [1:a] concat=n=2:v=1:a=1 [v] [a]" -c:v libx264 -c:a aac -strict -2 -map "[v]" -map "[a]" $OUTPUT
