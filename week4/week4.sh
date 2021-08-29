#!/bin/bash

NUM=4
LECTURE=0$NUM
DIR=week$NUM
ORIGINAL19=in2040-2019-$LECTURE.mp4

if [ ! -f $DIR]; then
  mkdir $DIR
fi

part=0

# Intro og repetisjon
ffmpeg -y -i $ORIGINAL19 -ss 00:00:59.5 -c copy -to 00:09:49 $DIR/$LECTURE-0$((part+=1)).mp4

# Rekursjon med anonyme prosedyrer
ffmpeg -y -i $ORIGINAL19 -ss 00:09:56 -c copy -to 00:20:27 $DIR/$LECTURE-0$((part+=1)).mp4

# Lokale variabler, let  og lambda
$((part+=1))
ffmpeg -y -i $ORIGINAL19 -ss 00:20:52 -c copy -to 00:27:06 $part-a.mp4
ffmpeg -y -i $ORIGINAL19 -ss 00:27:30 -c copy -to 00:39:15.5 $part-b.mp4
echo -e "file $part-a.mp4\nfile $part-b.mp4" > del$part.txt
ffmpeg -y -f concat -safe 0 -i del$part.txt -c copy $DIR/$LECTURE-0$part.mp4

# Dataabstraksjon
$((part+=1))
ffmpeg -y -i $ORIGINAL19 -ss 00:39:34.8 -c copy -to 00:41:26 $part-a.mp4
ffmpeg -y -i $ORIGINAL19 -ss 00:41:47.5 -c copy -to 00:44:09 $part-b.mp4
ffmpeg -y -i $ORIGINAL19 -ss 00:44:50.1 -c copy -to 00:59:39.5 $part-c.mp4
echo -e "file $part-a.mp4\nfile $part-b.mp4\nfile $part-c.mp4" > del$part.txt
ffmpeg -y -f concat -safe 0 -i del$part.txt -c copy $DIR/$LECTURE-0$part.mp4

# Hierarkiske datastrukturer – lister som trær
$((part+=1))
ffmpeg -y -i $ORIGINAL19 -ss 00:59:43 -c copy -to 01:07:18.8 $part-a.mp4
ffmpeg -y -i $ORIGINAL19 -ss 01:07:23 -c copy -to 01:10:22.7 $part-b.mp4
ffmpeg -y -i $ORIGINAL19 -ss 01:10:44.2 -c copy -to 01:17:15 $part-c.mp4
ffmpeg -y -i $ORIGINAL19 -ss 01:17:28 -c copy -to 01:19:23 $part-d.mp4
ffmpeg -y -i $ORIGINAL19 -ss 01:19:48.2 -c copy -to 01:20:30.7 $part-e.mp4
ffmpeg -y -i $ORIGINAL19 -ss 01:20:31.6 -c copy -to 01:23:02.4 $part-f.mp4
echo -e "file $part-a.mp4\nfile $part-b.mp4\nfile $part-c.mp4\nfile $part-d.mp4\nfile $part-e.mp4\nfile $part-f.mp4" > del$part.txt
ffmpeg -y -f concat -safe 0 -i del$part.txt -c copy $DIR/$LECTURE-0$part.mp4

# Veien videre
ffmpeg -y -i $ORIGINAL19 -ss 01:23:03.8 -c copy -to 01:26:56 $DIR/$LECTURE-0$((part+=1)).mp4

# exit # Uncomment to keep intermediate files.

GLOBIGNORE=$ORIGINAL19
rm *.txt *.mp4
unset GLOBIGNORE

# exit # Uncomment to not add frontpages.

# Adding frontpages (takes time as the videos will be reencoded)
cd ../frontpages/scripts
./add-frontpages.sh $NUM
