#!/bin/bash

NUM=9
LECTURE=0$NUM
DIR=week$NUM
ORIGINAL19=in2040-2019-10.mp4

if [ ! -f $DIR]; then
  mkdir $DIR
fi

part=0

# Intro og repetisjon
$((part+=1))
ffmpeg -y -i $ORIGINAL19 -ss 00:00:38.3 -c copy -to 00:01:23 $part-a.mp4
ffmpeg -y -i $ORIGINAL19 -ss 00:01:37.9 -c copy -to 00:03:24 $part-b.mp4
ffmpeg -y -i $ORIGINAL19 -ss 00:03:47 -c copy -to 00:04:28 $part-c.mp4
ffmpeg -y -i $ORIGINAL19 -ss 00:04:52 -c copy -to 00:08:49 $part-d.mp4
ffmpeg -y -i $ORIGINAL19 -ss 00:09:40 -c copy -to 00:12:32 $part-e.mp4
echo -e "file $part-a.mp4\nfile $part-b.mp4\nfile $part-c.mp4\nfile $part-d.mp4\nfile $part-e.mp4" > del$part.txt
ffmpeg -y -f concat -safe 0 -i del$part.txt -c copy $DIR/$LECTURE-0$part.mp4

# Inkrementell beregning vs sekvensoperasjoner
ffmpeg -y -i $ORIGINAL19 -ss 00:13:08.5 -c copy -to 00:19:41.8 $DIR/$LECTURE-0$((part+=1)).mp4

# Strømmer - Introduksjon og grensesnitt
ffmpeg -y -i $ORIGINAL19 -ss 00:19:42.2 -c copy -to 00:27:43 $DIR/$LECTURE-0$((part+=1)).mp4

# Strømmer - Sekvensoperasjoner
$((part+=1))
ffmpeg -y -i $ORIGINAL19 -ss 00:28:43 -c copy -to 00:30:02 $part-a.mp4
ffmpeg -y -i $ORIGINAL19 -ss 00:30:23 -c copy -to 00:35:10 $part-b.mp4
ffmpeg -y -i $ORIGINAL19 -ss 00:36:44 -c copy -to 00:36:58 $part-c.mp4
echo -e "file $part-a.mp4\nfile $part-b.mp4\nfile $part-c.mp4" > del$part.txt
ffmpeg -y -f concat -safe 0 -i del$part.txt -c copy $DIR/$LECTURE-0$part.mp4

# Evalueringsstrategier
ffmpeg -y -i $ORIGINAL19 -ss 00:37:02 -c copy -to 00:41:05 $DIR/$LECTURE-0$((part+=1)).mp4

# Strømmer - Implementasjon
$((part+=1))
ffmpeg -y -i $ORIGINAL19 -ss 00:41:05 -c copy -to 00:43:31 $part-a.mp4
ffmpeg -y -i $ORIGINAL19 -ss 00:43:50.2 -c copy -to 00:44:56 $part-b.mp4
ffmpeg -y -i $ORIGINAL19 -ss 00:45:07 -c copy -to 00:49:00.6 $part-c.mp4
ffmpeg -y -i $ORIGINAL19 -ss 00:49:29 -c copy -to 00:54:38 $part-d.mp4
echo -e "file $part-a.mp4\nfile $part-b.mp4\nfile $part-c.mp4\nfile $part-d.mp4" > del$part.txt
ffmpeg -y -f concat -safe 0 -i del$part.txt -c copy $DIR/$LECTURE-0$part.mp4

# Strømmer - Memoisering
$((part+=1))
ffmpeg -y -i $ORIGINAL19 -ss 00:55:05.1 -c copy -to 00:57:33.6 $part-a.mp4
ffmpeg -y -i $ORIGINAL19 -ss 00:57:36.6 -c copy -to 01:01:30 $part-b.mp4
ffmpeg -y -i $ORIGINAL19 -ss 01:01:48.5 -c copy -to 01:03:57 $part-c.mp4
ffmpeg -y -i $ORIGINAL19 -ss 01:04:00 -c copy -to 01:04:05 $part-d.mp4
ffmpeg -y -i $ORIGINAL19 -ss 01:04:18.9 -c copy -to 01:06:05 $part-e.mp4
echo -e "file $part-a.mp4\nfile $part-b.mp4\nfile $part-c.mp4\nfile $part-d.mp4\nfile $part-e.mp4" > del$part.txt
ffmpeg -y -f concat -safe 0 -i del$part.txt -c copy $DIR/$LECTURE-0$part.mp4

# Utsatt evaluering og destruktive operasjoner
$((part+=1))
ffmpeg -y -i $ORIGINAL19 -ss 01:06:08 -c copy -to 01:07:02 $part-a.mp4
ffmpeg -y -i $ORIGINAL19 -ss 01:07:34 -c copy -to 01:09:33.9 $part-b.mp4
echo -e "file $part-a.mp4\nfile $part-b.mp4" > del$part.txt
ffmpeg -y -f concat -safe 0 -i del$part.txt -c copy $DIR/$LECTURE-0$part.mp4

# Uendelige strømmer
$((part+=1))
ffmpeg -y -i $ORIGINAL19 -ss 01:13:07 -c copy -to 01:21:45 $part-a.mp4
ffmpeg -y -i $ORIGINAL19 -ss 01:21:49 -c copy -to 01:28:37 $part-b.mp4
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
