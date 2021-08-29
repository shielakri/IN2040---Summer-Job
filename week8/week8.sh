#!/bin/bash

NUM=8
LECTURE=0$NUM
DIR=week$NUM
ORIGINAL19=in2040-2019-09.mp4

if [ ! -f $DIR]; then
  mkdir $DIR
fi

part=0

# Intro og repetisjon
$((part+=1))
ffmpeg -y -i $ORIGINAL19 -ss 00:00:14 -c copy -to 00:05:07 $part-a.mp4
ffmpeg -y -i $ORIGINAL19 -ss 00:05:12 -c copy -to 00:06:54 $part-b.mp4
ffmpeg -y -i $ORIGINAL19 -ss 00:08:21.3 -c copy -to 00:09:42 $part-c.mp4
ffmpeg -y -i $ORIGINAL19 -ss 00:09:42 -c copy -to 00:10:15 $part-d.mp4
echo -e "file $part-a.mp4\nfile $part-b.mp4\nfile $part-c.mp4\nfile $part-d.mp4" > del$part.txt
ffmpeg -y -f concat -safe 0 -i del$part.txt -c copy $DIR/$LECTURE-0$part.mp4

# Aritet og variadiske prosedyrer
$((part+=1))
ffmpeg -y -i $ORIGINAL19 -ss 00:10:23 -c copy -to 00:15:29.7 $part-a.mp4
ffmpeg -y -i $ORIGINAL19 -ss 00:15:33.31 -c copy -to 00:16:56 $part-b.mp4
ffmpeg -y -i $ORIGINAL19 -ss 00:16:59 -c copy -to 00:21:00 $part-c.mp4
ffmpeg -y -i $ORIGINAL19 -ss 00:21:06 -c copy -to 00:25:49 $part-d.mp4
ffmpeg -y -i $ORIGINAL19 -ss 00:25:56 -c copy -to 00:28:35 $part-e.mp4
echo -e "file $part-a.mp4\nfile $part-b.mp4\nfile $part-c.mp4\nfile $part-d.mp4\nfile $part-e.mp4" > del$part.txt
ffmpeg -y -f concat -safe 0 -i del$part.txt -c copy $DIR/$LECTURE-0$part.mp4

# Repetisjon køer
ffmpeg -y -i $ORIGINAL19 -ss 00:28:42 -c copy -to 00:31:42 $DIR/$LECTURE-0$((part+=1)).mp4

# Memoisering 1
$((part+=1))
ffmpeg -y -i $ORIGINAL19 -ss 00:33:11 -c copy -to 00:34:51 $part-a.mp4
ffmpeg -y -i $ORIGINAL19 -ss 00:35:11 -c copy -to 00:36:00 $part-b.mp4
ffmpeg -y -i $ORIGINAL19 -ss 00:36:01 -c copy -to 00:41:29 $part-c.mp4
echo -e "file $part-a.mp4\nfile $part-b.mp4\nfile $part-c.mp4" > del$part.txt
ffmpeg -y -f concat -safe 0 -i del$part.txt -c copy $DIR/$LECTURE-0$part.mp4

# Assosiative tabeller
$((part+=1))
ffmpeg -y -i $ORIGINAL19 -ss 00:41:34 -c copy -to 00:45:16 $part-a.mp4
ffmpeg -y -i $ORIGINAL19 -ss 00:45:25.5 -c copy -to 00:51:29 $part-b.mp4
ffmpeg -y -i $ORIGINAL19 -ss 00:52:27 -c copy -to 00:56:11 $part-c.mp4
ffmpeg -y -i $ORIGINAL19 -ss 00:56:15 -c copy -to 00:57:17 $part-d.mp4
echo -e "file $part-a.mp4\nfile $part-b.mp4\nfile $part-c.mp4\nfile $part-d.mp4" > del$part.txt
ffmpeg -y -f concat -safe 0 -i del$part.txt -c copy $DIR/$LECTURE-0$part.mp4

# Refleksjon rundt tabeller
$((part+=1))
ffmpeg -y -i $ORIGINAL19 -ss 00:57:23 -c copy -to 00:58:04 $part-a.mp4
ffmpeg -y -i $ORIGINAL19 -ss 00:58:11 -c copy -to 00:58:58 $part-b.mp4
ffmpeg -y -i $ORIGINAL19 -ss 00:59:05 -c copy -to 00:59:51 $part-c.mp4
ffmpeg -y -i $ORIGINAL19 -ss 00:59:57 -c copy -to 01:00:15 $part-d.mp4
ffmpeg -y -i $ORIGINAL19 -ss 01:00:20 -c copy -to 01:01:39.8 $part-e.mp4
ffmpeg -y -i $ORIGINAL19 -ss 01:01:50 -c copy -to 01:04:03 $part-f.mp4
ffmpeg -y -i $ORIGINAL19 -ss 01:04:12 -c copy -to 01:09:51 $part-g.mp4
echo -e "file $part-a.mp4\nfile $part-b.mp4\nfile $part-c.mp4\nfile $part-d.mp4\nfile $part-e.mp4\nfile $part-f.mp4\nfile $part-g.mp4" > del$part.txt
ffmpeg -y -f concat -safe 0 -i del$part.txt -c copy $DIR/$LECTURE-0$part.mp4

# Bindinger, navn og prosedyrer
$((part+=1))
ffmpeg -y -i $ORIGINAL19 -ss 01:10:03 -c copy -to 01:14:28 $part-a.mp4
ffmpeg -y -i $ORIGINAL19 -ss 01:14:33 -c copy -to 01:15:44 $part-b.mp4
ffmpeg -y -i $ORIGINAL19 -ss 01:15:48 -c copy -to 01:21:08 $part-c.mp4
ffmpeg -y -i $ORIGINAL19 -ss 01:21:13 -c copy -to 01:25:17 $part-d.mp4
echo -e "file $part-a.mp4\nfile $part-b.mp4\nfile $part-c.mp4\nfile $part-d.mp4" > del$part.txt
ffmpeg -y -f concat -safe 0 -i del$part.txt -c copy $DIR/$LECTURE-0$part.mp4


# Rekursjon med anonyme prosedyrer
ORIGINAL19_04=in2040-2019-04.mp4
ffmpeg -y -i $ORIGINAL19_04 -ss 00:10:03.49 -c copy -to 00:20:27 $DIR/$LECTURE-0$((part+=1)).mp4

# Memoisering 2
$((part+=1))
ffmpeg -y -i $ORIGINAL19 -ss 01:25:29 -c copy -to 01:26:07 $part-a.mp4
ffmpeg -y -i $ORIGINAL19 -ss 01:26:46 -c copy -to 01:28:47 $part-b.mp4
echo -e "file $part-a.mp4\nfile $part-b.mp4" > del$part.txt
ffmpeg -y -f concat -safe 0 -i del$part.txt -c copy $DIR/$LECTURE-0$part.mp4

# exit # Uncomment to keep intermediate files.

GLOBIGNORE=$ORIGINAL19
rm *.txt *.mp4
unset GLOBIGNORE

# exit # Uncomment to not add frontpages.

# Adding frontpages (takes time as the videos will be reencoded)
cd ../frontpages/scripts
./add-frontpages.sh $NUM
