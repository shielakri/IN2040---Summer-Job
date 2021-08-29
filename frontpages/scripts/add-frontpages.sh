#!/bin/bash

# TO USE:
#
# 1. In the terminal, navigate to the frontpages/scripts folder and type:
# -----------------------------------------------------------------------
# ./add_frontpages <week number>
# -----------------------------------------------------------------------
#
# 2. Or place this line at the end of your weekX.sh script:
# -----------------------------------------------------------------------
# cd ../frontpages/scripts
# ./add-frontpages.sh X
# -----------------------------------------------------------------------
#
# NOTE:
# This script assumes this file structure:
#
# ParentFolder
#     |____frontpages
#     |        |____frontpages-01
#     |        |____frontpages-02
#     |        ... (directories that contain the frontpages for each week)
#     |        |____frontpages-$LECTURE
#     |        ...
#     |        |____scripts
#     |                 |____add-frontpages.sh (this script)
#     |____week1
#     |        |____week1
#     |        |____in2040-2019-01.mp4 (the video used to make a silent 5 second video from)_
#     ... (directories for the lecture each week)
#     |____week$NUM
#     |        |____week$NUM
#     |                 |____$LECTURE-01.mp4
#     |                 |____$LECTURE-02.mp4
#     |                 ... (the videos to place front pages on)
#     |                 |____$LECTURE-0X.mp4
#     ...

if [ "$#" == "0" ]; then
  echo "Please insert week number." >&2
  exit
else
  NUM=$1
fi

# Variables
WEEK=week$NUM

if ((NUM < 10)); then
  LECTURE=0$NUM
else
  LECTURE=$NUM
fi

DURATION=5

# Directories
FRONTPAGEDIR=../frontpages-$LECTURE
WEEKDIR=../../$WEEK
OUTDIR=$WEEKDIR/in2040-2020-$LECTURE

# Frontpage pdf
FRONTPAGES=$FRONTPAGEDIR/frontpages-$LECTURE.pdf
FP_PREFIX=$WEEKDIR/frontpages/frontpage-$LECTURE

if [ ! -d $WEEKDIR/frontpages ]; then
  mkdir $WEEKDIR/frontpages
fi


ORIGINAL19=../../week1/in2040-2019-01.mp4

CV=libx264 # video codec
CA=aac # audio codec
OPT=nostdin # no standard input interaction - did not work (maybe you have to run as script?)

# Get number of pages from: https://gist.github.com/bencholmes/3c9279d9f24758a0bbf084eecf836b2d
NUMPAGES=$(pdfinfo "$FRONTPAGES" | grep Pages | sed 's/[^0-9]*//')

# Funcion for generating frontpage images from the latex pdf.
# Creates one image per page.
generate_frontpages() {
  for i in $( seq 0 $(($NUMPAGES-1)) );
  do
    vips copy $FRONTPAGES[dpi=300,page=$i] $FP_PREFIX-0$(($i+1)).jpg
  done
}

# Adding front page - involves re-encoding the video in the last step.
# Usage: add_frontpage "FRONTPAGEFOLDER" "PART" "VIDEO")
# duration and where new video with frontpage is stored are global variables
add_frontpage() {
  local frontpage=$1-$2
  # 1. Scaling the image to have height=1080, and keeping widt as is.
  ffmpeg -$OPT -y -i $frontpage.jpg -vf scale="-1:1080" $frontpage-resized.jpg
  # 2. Placing the image in the middle of the silent video -> finished front page
  ffmpeg -$OPT -y -i $WEEKDIR/$DURATION-sec.mp4 -i $frontpage-resized.jpg -an -filter_complex "overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2" -c:v $CV $frontpage.mp4
  # 3. Adding the frontpage to the video - takes a couple of minutes as it re-encodes
  ffmpeg -y -i $frontpage.mp4 -i $3.mp4 -f lavfi -t $DURATION -i aevalsrc=0 -filter_complex "[0:v] [2:a] [1:v] [1:a] concat=n=2:v=1:a=1 [v] [a]" -c:v $CV -c:a $CA -strict -2 -map "[v]" -map "[a]" $OUTDIR/in2040-2020-$LECTURE-$2.mp4
}

# Creating front page images from the pdf
generate_frontpages

if [ ! -d $OUTDIR ]; then
  mkdir $OUTDIR
fi

# Create a 5 second silent video. Only necessary once.
ffmpeg -y -i $ORIGINAL19 -ss 00:05:00 -t $DURATION -c:v copy -an $WEEKDIR/$DURATION-sec.mp4

# Assumes part number (number of pages in frontpage pdf) < 10 (single digit)
for i in $( seq 1 $NUMPAGES );
do
  add_frontpage "$FP_PREFIX" "0$i" "$WEEKDIR/$WEEK/$LECTURE-0$i"
done

# For a specific part/range of parts
#for i in 2 3;
#do
#  add_frontpage "$FP_PREFIX" "0$i" "$WEEKDIR/$WEEK/$LECTURE-0$i"
#done

rm $WEEKDIR/$DURATION-sec.mp4 $FP_PREFIX*.mp4
