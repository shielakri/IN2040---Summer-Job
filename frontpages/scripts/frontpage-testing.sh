#!/bin/bash

# This file will not run. It is just an accumulation of the different methods,
# for adding frontpages, that I have tested.

ORIGINAL19=/home/shiela/Documents/Jobs/week1/week1/3-syntaks-og-semantikk.mp4

ffmpeg -i /home/shiela/Documents/Jobs/week1/in2040-2019-01.mp4 -ss 00:51:06 -c copy -to 01:06:03 3-syntaks-og-semantikk-test.mp4
echo $'file frontpage.mp4\nfile 3-syntaks-og-semantikk-test.mp4' > test.txt

# Try 1 - Audio is okay, but picture is not changing -> impossible to fast forward without crashing
# deprecated pixel format used
ffmpeg -y -loop 1 -framerate 15 -t 10 -i frontpages/frontpage-01-02.jpg -f lavfi -t 10 -i aevalsrc=0 -vf settb=1/15,scale=1920/1080,setsar=1/1,setdar=16/9 -video_track_timescale 30000 -c:v libx264 -pix_fmt yuv420p -color_primaries 1 -color_trc 1 -colorspace 1 -b:v 152k -b:a 54k -ar 22050 -brand mp42 frontpage.mp4
ffmpeg -f concat -safe 0 -i test.txt -c copy test.mp4


# Try 2

ffmpeg -i $ORIGINAL19 -vf trim=0:3,geq=0:128:128,settb=1/15,scale=1920:1080,setsar=1/1,setdar=16/9 -af atrim=0:3,volume=0 -video_track_timescale 30000 -c:v libx264 -pix_fmt yuv420p -color_primaries 1 -color_trc 1 -colorspace 1 -b:v 152k -b:a 54k -ar 22050 frontpage.mp4
#ffmpeg -i $ORIGINAL19 -c copy -video_track_timescale 30000 $ORIGINAL19
ffmpeg -f concat -safe 0 -i test1.txt -c copy merged.mp4


# Try 3

# Try concat segments from lectures 1 and 3 - SUCCESS
# It is possible to concatonate different lectures (tried with 1 and 3)
#echo $'file /home/shiela/Documents/Jobs/week3/week3/1-intro.mp4\nfile /home/shiela/Documents/Jobs/week1/week1/3-syntaks-og-semantikk.mp4' > test2.txt
#ffmpeg -f concat -safe 0 -i test2.txt -c copy test2.mp4


# Early testing
#testing
echo $'file testing.mp4\nfile /home/shiela/Documents/Jobs/week1/week1/4-prosedyrer.mp4' > del2.txt
ffmpeg -f concat -safe 0 -i del2.txt -c copy test.mp4

ffmpeg -y -loop 1 -framerate 15 -t 5 -i in2040-01-02.jpg -f lavfi -t 5 -i aevalsrc=0 -vf scale=1920:1080 -video_track_timescale 30000 -c:v libx264 -pix_fmt yuv420p out.mp4

ffmpeg -loop 1 -y -i in2040-01-02.jpg -t 5 -i /home/shiela/Documents/Jobs/week1/week1/4-prosedyrer.mp4 -acodec copy -vcodec mjpeg testing.mp4

ffmpeg -r 1 -loop 1 -i ep1.jpg -i ep1.wav -acodec copy -r 1 -shortest -vf scale=1920:1080 ep1.flv

ffmpeg -loop 1 -framerate 15 -i in2040-01-02.jpg -c:v libx264 -preset slow -tune stillimage -crf 24 -vf "format=yuv420p, scale=1920:1080" -t 10 -movflags +faststart output.mp4


ffmpeg -loop 1 -i in2040-01-02.jpg -c:v libx264 -t 5 -pix_fmt yuv420p -vf scale=1920:1080 -r 15 out.mp4
ffmpeg -loop 1 -i in2040-01-02.jpg -t 5 -vf scale=1920:1080 -r 1 out.mp4
echo $'file out.mp4\nfile /home/shiela/Documents/Jobs/week1/week1/3-syntaks-og-semantikk.mp4' > del2.txt
ffmpeg -f concat -safe 0 -i del2.txt -c copy test.mp4

ffmpeg -i out.mp4 -c copy -bsf:v h264_mp4toannexb -f mpegts intermediate1.ts
ffmpeg -i /home/shiela/Documents/Jobs/week1/week1/3-syntaks-og-semantikk.mp4 -c copy -bsf:v h264_mp4toannexb -f mpegts intermediate2.ts

ffmpeg -loop 1 -i in2040-01-03.jpg -c:v libx264 -t 5 -pix_fmt yuv420p -bsf:v h264 -vf scale=1920:1080 out.mp4


ffmpeg -i /home/shiela/Documents/Jobs/week1/week1/3-syntaks-og-semantikk.mp4 -vf trim=0:3,geq=0:128:128 -af atrim=0:3,volume=0 -video_track_timescale 600 3sec.mp4
echo $'file blck-snd.mp4\nfile 3-syntaks-og-semantikk-test.mp4' > del2.txt
ffmpeg -i /home/shiela/Documents/Jobs/week1/week1/3-syntaks-og-semantikk.mp4 -c copy -video_track_timescale 600 3-syntaks-og-semantikk-test.mp4
ffmpeg -f concat -safe 0 -i del2.txt -c copy test.mp4

ffmpeg -loop 1 -i in2040-01-02.jpg -t 5 -r 1 -vf scale=1920:1080 -c:v libx264 -c:a libfdk_aac -pix_fmt yuvj422p -vbr 3 blck.mp4
ffmpeg -f lavfi -i anullsrc=r=48000 -i blck.mp4 -t 5 -c:v copy -c:a aac -strict experimental blck-snd.mp4

ffmpeg -loop 1 -i in2040-01-02.jpg -f lavfi -i anullsrc=r=48000 -t 5 -r 1 -vf scale=1920:1080 -c:a aac -pix_fmt yuvj422p -vbr 3 blck.mp4

ffmpeg -i blck.mp4 -c copy -bsf h264_mp4toannexb temp1.ts
ffmpeg -i 3-syntaks-og-semantikk-test.mp4 -c copy -bsf h264_mp4toannexb temp2.ts
ffmpeg -i "concat:temp1.ts|temp2.ts" -c copy -absf aac_adtstoasc output.mp4

ffmpeg -loop 1 -i in2040-01-02.jpg -s 1920:1080 -t 5 frontpage.mp4

cd ../frontpages
vips copy in2040-01.pdf[dpi=249,page=2] ../week1/frontpage-01-03.jpg
cd -
ffmpeg -loop 1 -i frontpage-01-03.jpg -vf scale=1920:1080,setsar=1:1,setdar=16:9 -pix_fmt yuv420p -t 5 frontpage1.mp4
ffmpeg -f lavfi -i anullsrc=r=1024 -i frontpage1.mp4 -t 5 -c:v copy -c:a aac -strict experimental frontpage.mp4

echo $'file frontpage.mp4\nfile 3-syntaks-og-semantikk-test.mp4' > del3.txt
ffmpeg -f concat -safe 0 -i del3.txt -c copy 3-test.mp4

ffmpeg -i frontpage.mp4 -i 3-syntaks-og-semantikk-test.mp4 -filter_complex "[0:v:0][0:a:0][1:v:0][1:a:0]concat=n=2:v=1:a=1[outv][outa]" -map "[outv]" -map "[outa]" output.mp4

# generate black screen

ffmpeg -f lavfi -i color=black:s=1920x1080:r=24000/1001 -f lavfi -i anullsrc \
       -ar 48000 -ac 2 -t 5 empty.mp4

echo $'file empty.mp4\nfile  3-syntaks-og-semantikk-test.mp4' > del3.txt
ffmpeg -f concat -safe 0 -i del3.txt -c copy 3-test.mp4

ffmpeg -i frontpage.mp4 -vcodec libx264 -acodec aac frontpage.mp4

ffmpeg -i frontpage.mp4 -s 1920:1080 -b:v 145k output_video.mp4
echo $'file output_video.mp4\nfile  3-syntaks-og-semantikk-test.mp4' > del3.txt


# THIS WORKS - SOMETIMES...
DIR=week1
ORIGINAL19=in2040-2019-01.mp4
FPIMAGE=/home/shiela/Documents/Jobs/week1/frontpages/frontpage-01-03.jpg
FPVIDEO=frontpage.mp4
TIME=5
SEGMENT=1-egenskaper.mp4
FPS=15
OUTPUT=in2040-2020-01-04.mp4

ffmpeg -y -loop 1 -t $TIME -framerate $FPS -i $FPIMAGE -f lavfi -i anullsrc=channel_layout=mono:sample_rate=22050 -t $TIME -brand mp42 -video_track_timescale 30k -pix_fmt yuv420p -colorspace bt709 -color_range tv -color_trc bt709 -color_primaries bt709 -vf setdar=16/9,scale=1920x1080 -r $FPS image.mp4
#ffmpeg -y -loop 1 -t $TIME -framerate $FPS -i $FPIMAGE -f lavfi -i anullsrc=channel_layout=mono:sample_rate=22050 -shortest -brand mp42 -video_track_timescale 30k -pix_fmt yuv420p -colorspace bt709 -color_range tv -color_trc bt709 -color_primaries bt709 -vf setdar=16/9,scale=1920x1080 -qscale:v 0 image.mp4
ffmpeg -y -i $DIR/$SEGMENT -video_track_timescale 30k -c copy video4.mp4 #Isn't necessary
#echo $'file image.mp4\nfile video4.mp4' > videovideo.txt # can put the video straight here. See next line
echo $'file image.mp4\nfile video4.mp4' > videovideo.txt
ffmpeg -y -f concat -safe 0 -i videovideo.txt -c copy concatvideovideo1.mp4



# THIS IS FROM THE week1.sh SCRIPT
# Specifications
# -general
BRAND=mp42 #is this format?
DURATION=5

# - video
SIZE=1920/1080
SAR=1/1
DAR=16/9
FPS=15
CV=libx264
VTT=30k #timebase
PIX_FMT=yuv420p
COLOR=bt709
COLORR=tv

# - audio
CA=aac # not necessary for "without encoding"
CHL=mono
SA=22050


# Files
FPIMAGE=frontpages/frontpage-01 #/home/shiela/Documents/Jobs/week1/frontpages/frontpage-01
OUTDIR=in2040-2020-01
I_FILE_EXT=jpg
V_FILE_EXT=mp4

# Variables
#imagenumber INUM
#videonumber VNUM
INUM=00
VNUM=01
VIDEO=in2040-2019-01.mp4



# Without re-encoding - DOES NOT ALWAYS WORK
# Generating front page video
ffmpeg -y -loop 1 -t $TIME -framerate $FPS \
  -i $FPIMAGE-$INUM.$I_FILE_EXT \
  -f lavfi -i anullsrc=channel_layout=$CHL:sample_rate=$SA -shortest \
  -brand $BRAND -video_track_timescale $VTT \
  -pix_fmt $PIX_FMT \
  -colorspace $COLOR -color_range $COLORR -color_trc $COLOR -color_primaries $COLOR \
  -vf setdar=$DAR,scale=$SIZE $FPIMAGE-$VNUM.$V_FILE_EXT

# -e flag enables interpretation of backslash escapes- e.g newline: \n
echo -e "file $FPIMAGE-$VNUM.$V_FILE_EXT\nfile $DIR/$VIDEO" > concat-list.txt
ffmpeg -y -auto_convert 1 -f concat -safe 0 -i concat-list.txt -c copy $OUTDIR/$OUTDIR-$VNUM.$V_FILE_EXT


# With re-encoding

# Commands 1 - For original front page
# 1. Creating a 5 second video of front page
ffmpeg -framerate $FPS -loop 1 -t $DURATION -i $FPIMAGE-$INUM.jpg -vf scale=$SIZE,setsar=$SAR,setdar=$DAR $FPIMAGE-$VNUM.mp4
# 2. Adding front page (re-encodes)
ffmpeg -i $FPIMAGE-$VNUM.mp4 -i $DIR/$VIDEO -f lavfi -t $DURATION -i aevalsrc=0 -filter_complex "[0:v] [2:a] [1:v] [1:a] concat=n=2:v=1:a=1 [v] [a]" -c:v $CV -c:a $CA -strict -2 -map "[v]" -map "[a]" $OUTDIR/$OUTDIR-$VNUM.mp4



# USE COMMANDS 2


# Commands 2 - For LaTex front page - NEW LATEX FRONT PAGE ONLY WORKS WITH STEP 0 AS WELL
# 0. Creating a 5 second silent video. Only necessary once.
ffmpeg -y -i $ORIGINAL19 -ss 00:05:00 -t $DURATION -c:v copy -an $DURATION-sec.mp4
# 1. Scaling the image to have height=1080, and keeping widt as is.
#    Remove "-resized" from step 2 if you choose not to resize
ffmpeg -y -i $FPIMAGE-$INUM.jpg -vf scale="-1:1080" $FPIMAGE-$INUM-resized.jpg
# 2. Placing in the middle
ffmpeg -y -i $DURATION-sec.mp4 -i $FPIMAGE-$INUM-resized.jpg -an -filter_complex "overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2" -c:v $CV $FPIMAGE-$VNUM.mp4
# 3. Adding frontpage
ffmpeg -i $FPIMAGE-$VNUM.mp4 -i $DIR/$VIDEO -f lavfi -t $DURATION -i aevalsrc=0 -filter_complex "[0:v] [2:a] [1:v] [1:a] concat=n=2:v=1:a=1 [v] [a]" -c:v $CV -c:a $CA -strict -2 -map "[v]" -map "[a]" $OUTDIR/$OUTDIR-$VNUM.mp4


# TEST
# Test med nytt bilde
VIDEO=4-prosedyrer.mp4
# loop metoden funker best
ffmpeg -framerate $FPS -loop 1 -t $DURATION -i title.png -vf scale=$SIZE,setsar=$SAR,setdar=$DAR test.mp4
#ffmpeg -y -i $DURATION-sec.mp4 -i title.jpg -an -s 1920x1080 -filter_complex "overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2" -c:v $CV test.mp4
ffmpeg -i test.mp4 -i $DIR/$VIDEO -f lavfi -t $DURATION -i aevalsrc=0 -filter_complex "[0:v] [2:a] [1:v] [1:a] concat=n=2:v=1:a=1 [v] [a]" -c:v $CV -c:a $CA -strict -2 -map "[v]" -map "[a]" testout.mp4

# Explanation

# 5 second clip without audio
ffmpeg -y -i $ORIGINAL19 -ss 00:05:00 -t $DURATION -c:v copy -an $DURATION-sec.mp4
# Placing in the middle
ffmpeg -y -i $DURATION-sec.mp4 -i $FPIMAGE-$INUM.jpg -an -filter_complex "overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2" -c:v $CV $FPIMAGE-$VNUM.mp4
# Adding frontpage
ffmpeg -i $FPIMAGE-$VNUM.mp4 -i $DIR/$VIDEO -f lavfi -t $DURATION -i aevalsrc=0 -filter_complex "[0:v] [2:a] [1:v] [1:a] concat=n=2:v=1:a=1 [v] [a]" -c:v $CV -c:a $CA -strict -2 -map "[v]" -map "[a]" $OUTDIR/$OUTDIR-$VNUM.mp4
# Resizing and creating a 10 second clip with front page. NOT USED. WEIRD DIMENSIONS
#ffmpeg -framerate $FPS -loop 1 -t $DURATION -i $FPIMAGE-$INUM.jpg -vf scale=$SIZE,setsar=$SAR,setdar=$DAR $FPIMAGE-$VNUM.mp4


# From week1/test.sh script:

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
