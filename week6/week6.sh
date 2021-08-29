#!/bin/bash

NUM=6
LECTURE=0$NUM
DIR=week$NUM
ORIGINAL19=in2040-2019-$LECTURE.mp4

if [ ! -f $DIR]; then
  mkdir $DIR
fi

part=0

# Increasing volume
ffmpeg -y -i $ORIGINAL19 -filter:a "volume=8.0" -c:v copy in2040-2019-$LECTURE-vol8.mp4

ORIGINAL19=in2040-2019-$LECTURE-vol8.mp4

# Intro og repetisjon
$((part+=1))
ffmpeg -y -i $ORIGINAL19 -ss 00:00:41 -c copy -to 00:05:49 $part-a.mp4
ffmpeg -y -i $ORIGINAL19 -ss 00:06:12.3 -c copy -to 00:07:48.5 $part-b.mp4
echo -e "file $part-a.mp4\nfile $part-b.mp4" > del$part.txt
ffmpeg -y -f concat -safe 0 -i del$part.txt -c copy $DIR/$LECTURE-0$part.mp4

# Tilstand og verditilordning
$((part+=1))
ffmpeg -y -i $ORIGINAL19 -ss 00:08:10 -c copy -to 00:16:22 $part-a.mp4
ffmpeg -y -i $ORIGINAL19 -ss 00:17:27 -c copy -to 00:19:54 $part-b.mp4
ffmpeg -y -i $ORIGINAL19 -ss 00:19:56 -c copy -to 00:23:35 $part-c.mp4
ffmpeg -y -i $ORIGINAL19 -ss 00:23:48 -c copy -to 00:27:45.17 $part-d.mp4
ffmpeg -y -i $ORIGINAL19 -ss 00:28:35 -c copy -to 00:39:55 $part-e.mp4
echo -e "file $part-a.mp4\nfile $part-b.mp4\nfile $part-c.mp4\nfile $part-d.mp4\nfile $part-e.mp4" > del$part.txt
ffmpeg -y -f concat -safe 0 -i del$part.txt -c copy $DIR/$LECTURE-0$part.mp4

# Fra substitusjonsmodellen til omgivelsesmodellen
$((part+=1))
ffmpeg -y -i $ORIGINAL19 -ss 00:40:01 -c copy -to 00:40:14 $part-a.mp4
ffmpeg -y -i $ORIGINAL19 -ss 00:40:24 -c copy -to 00:50:50 $part-b.mp4
ffmpeg -y -i $ORIGINAL19 -ss 00:51:03 -c copy -to 00:56:06 $part-c.mp4
ffmpeg -y -i $ORIGINAL19 -ss 00:56:14 -c copy -to 00:59:32 $part-d.mp4
echo -e "file $part-a.mp4\nfile $part-b.mp4\nfile $part-c.mp4\nfile $part-d.mp4" > del$part.txt
ffmpeg -y -f concat -safe 0 -i del$part.txt -c copy $DIR/$LECTURE-0$part.mp4

# Innkapsling
$((part+=1))
ffmpeg -y -i $ORIGINAL19 -ss 00:59:35 -c copy -to 01:07:56 $part-a.mp4
ffmpeg -y -i $ORIGINAL19 -ss 01:08:12 -c copy -to 01:10:26 $part-b.mp4
echo -e "file $part-a.mp4\nfile $part-b.mp4" > del$part.txt
ffmpeg -y -f concat -safe 0 -i del$part.txt -c copy $DIR/$LECTURE-0$part.mp4

# Prosedyrebasert objektorientering
ffmpeg -y -i $ORIGINAL19 -ss 01:14:58 -c copy -to 01:22:22 $DIR/$LECTURE-0$((part+=1)).mp4

# Likhet
ffmpeg -y -i $ORIGINAL19 -ss 01:22:50.5 -c copy -to 01:26:39 $DIR/$LECTURE-0$((part+=1)).mp4

# exit # Uncomment to keep intermediate files.

GLOBIGNORE=$ORIGINAL19:$ORIGINAL18
rm *.txt *.mp4
unset GLOBIGNORE

# exit # Uncomment to not add frontpages.

# Adding frontpages (takes time as the videos will be reencoded)
cd ../frontpages/scripts
./add-frontpages.sh $NUM
