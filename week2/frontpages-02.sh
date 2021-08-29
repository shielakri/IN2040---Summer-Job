#!/bin/bash

cd /home/shiela/Documents/Jobs/frontpages

# Change these two. The rest stays the same
DIR=week2
LECTURE=02

DURATION=5

FRONTPAGES=frontpages-$LECTURE.pdf
FPIMAGE=frontpages/frontpage-$LECTURE #-xx
OUTDIR=in2040-2020-$LECTURE
mkdir $OUTDIR

ORIGINAL19=/home/shiela/Documents/Jobs/week1/in2040-2019-01.mp4

CV=libx264 # video codec
CA=aac # audio codec
OPT=nostdin # no standard input interaction - did not work (maybe you have to run as script?)

# 0. Create a 5 second silent video. Only necessary once.
ffmpeg -y -i $ORIGINAL19 -ss 00:05:00 -t $DURATION -c:v copy -an $DURATION-sec.mp4

# Get number of pages from: https://gist.github.com/bencholmes/3c9279d9f24758a0bbf084eecf836b2d
NUMPAGES=$(pdfinfo "$FRONTPAGES" | grep Pages | sed 's/[^0-9]*//')

generate_frontpages() {
  for i in $( seq 0 $(($NUMPAGES-1)) );
  do
    vips copy $FRONTPAGES[dpi=300,page=$i] ../$DIR/frontpages/frontpage-$LECTURE-0$(($i+1)).jpg
  done
}

# Adding front page - involves re-encoding the video in the last step.
#add_frontpage(FRONTPAGEFOLDER PART VIDEO)
# duration and where new video with frontpage is stored are global variables
add_frontpage() {
  local frontpage=$1-$2
  ffmpeg -$OPT -y -i $frontpage.jpg -vf scale="-1:1080" $frontpage-resized.jpg
  ffmpeg -$OPT -y -i $DURATION-sec.mp4 -i $frontpage-resized.jpg -an -filter_complex "overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2" -c:v $CV $frontpage.mp4
  ffmpeg -y -i $frontpage.mp4 -i $3.mp4 -f lavfi -t $DURATION -i aevalsrc=0 -filter_complex "[0:v] [2:a] [1:v] [1:a] concat=n=2:v=1:a=1 [v] [a]" -c:v $CV -c:a $CA -strict -2 -map "[v]" -map "[a]" $OUTDIR/$OUTDIR-$2.mp4
}


generate_frontpages
cd ../$DIR

# Assumes part number < 10 (single digit)
for i in $( seq 1 $NUMPAGES );
do
  add_frontpage "$FPIMAGE" "0$i" "$DIR/$LECTURE-0$i"
done
