#!/bin/bash

NUM=3
LECTURE=0$NUM
DIR=week$NUM
ORIGINAL19=in2040-2019-$LECTURE.mp4
ORIGINAL18=inf2810-2018-04.mp4

if [ ! -f $DIR]; then
  mkdir $DIR
fi

part=0

ffmpeg -y -i $ORIGINAL19 -ss 00:00:40 -c copy -to 00:08:26  $DIR/$LECTURE-0$((part+=1)).mp4
ffmpeg -y -i $ORIGINAL19 -ss 00:08:37 -c copy -to 00:28:36 $DIR/$LECTURE-0$((part+=1)).mp4
ffmpeg -y -i $ORIGINAL19 -ss 00:28:52.3 -c copy -to 00:41:22 $DIR/$LECTURE-0$((part+=1)).mp4

$((part+=1))
ffmpeg -y -i $ORIGINAL19 -ss 00:41:22 -c copy -to 00:46:26 $part-a.mp4
ffmpeg -y -i $ORIGINAL19 -ss 00:47:32.5 -c copy -to 00:51:31 $part-b.mp4
echo -e "file $part-a.mp4\nfile $part-b.mp4" > del$part.txt
ffmpeg -y -f concat -safe 0 -i del$part.txt -c copy $DIR/$LECTURE-0$part.mp4

$((part+=1))
ffmpeg -y -i $ORIGINAL19 -ss 00:51:32 -c copy -to 01:09:24 $part-a.mp4
ffmpeg -y -i $ORIGINAL19 -ss 01:10:22.5 -c copy -to 01:16:01 $part-b.mp4
ffmpeg -y -i $ORIGINAL19 -ss 01:16:39 -c copy -to 01:18:33 $part-c.mp4
echo -e "file $part-a.mp4\nfile $part-b.mp4\nfile $part-c.mp4" > del$part.txt
ffmpeg -y -f concat -safe 0 -i del$part.txt -c copy $DIR/$LECTURE-0$part.mp4

$((part+=1))
ffmpeg -y -i $ORIGINAL19 -ss 01:18:34 -c copy -to 01:19:54 $part-a.mp4
ffmpeg -y -i $ORIGINAL19 -ss 01:20:12.5 -c copy -to 01:22:48 $part-b.mp4
ffmpeg -y -i $ORIGINAL19 -ss 01:23:39.1 -c copy -to 01:25:20 $part-c.mp4
echo -e "file $part-a.mp4\nfile $part-b.mp4\nfile $part-c.mp4" > del$part.txt
ffmpeg -y -f concat -safe 0 -i del$part.txt -c copy $DIR/$LECTURE-0$part.mp4

$((part+=1))
ffmpeg -y -i $ORIGINAL19 -ss 01:25:30 -c copy -to 01:28:54.5 $part-a.mp4
ffmpeg -y -i $ORIGINAL18 -ss 00:15:28 -c copy -to 00:23:11 $part-b.mp4
ffmpeg -y -i $part-b-un.mp4 -filter:a "volume=0.1" -c:v copy $part-b-v01.mp4
echo -e "file $part-a.mp4\nfile $part-b-v01.mp4" > del$part.txt
ffmpeg -y -f concat -safe 0 -i del$part.txt -c copy $DIR/$LECTURE-0$part.mp4

ffmpeg -y -i $ORIGINAL19 -ss 01:29:55 -c copy -to 01:32:43 $DIR/$LECTURE-0$((part+=1)).mp4

# exit # Uncomment to keep intermediate files.

GLOBIGNORE=$ORIGINAL19:$ORIGINAL18
rm *.txt *.mp4
unset GLOBIGNORE

# exit # Uncomment to not add frontpages.

# Adding frontpages (takes time as the videos will be reencoded)
cd ../frontpages/scripts
./add-frontpages.sh $NUM
