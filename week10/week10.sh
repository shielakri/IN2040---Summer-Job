#!/bin/bash

NUM=10
LECTURE=$NUM
DIR=week$NUM
ORIGINAL18=inf2810-2018-11.mp4

if [ ! -f $DIR]; then
  mkdir $DIR
fi

part=0

# Intro og repetisjon
$((part+=1))
ffmpeg -y -i $ORIGINAL18 -ss 00:02:08.5 -c copy -to 00:06:18 $part-a.mp4
ffmpeg -y -i $ORIGINAL18 -ss 00:06:33 -c copy -to 00:13:00 $part-b.mp4
echo -e "file $part-a.mp4\nfile $part-b.mp4" > del$part.txt
ffmpeg -y -f concat -safe 0 -i del$part.txt -c copy $DIR/$LECTURE-0$part.mp4

# Å definere special forms: Makroer
ffmpeg -y -i $ORIGINAL18 -ss 00:13:04.6 -c copy -to 00:24:00 $DIR/$LECTURE-0$((part+=1)).mp4

# Strømmer via utsatt evaluering: repetisjon og makro.
$((part+=1))
ffmpeg -y -i $ORIGINAL18 -ss 00:24:30 -c copy -to 00:24:51 $part-a.mp4
ffmpeg -y -i $ORIGINAL18 -ss 00:25:08.25 -c copy -to 00:27:07 $part-b.mp4
ffmpeg -y -i $ORIGINAL18 -ss 00:27:16 -c copy -to 00:28:33 $part-c.mp4
echo -e "file $part-a.mp4\nfile $part-b.mp4\nfile $part-c.mp4" > del$part.txt
ffmpeg -y -f concat -safe 0 -i del$part.txt -c copy $DIR/$LECTURE-0$part.mp4

# Strømmer og sekvensmanipulasjon
ffmpeg -y -i $ORIGINAL18 -ss 00:51:56 -c copy -to 00:54:12.1 $DIR/$LECTURE-0$((part+=1)).mp4

# Uendelige strømmer: repetisjon og fallgruver
$((part+=1))
ffmpeg -y -i $ORIGINAL18 -ss 00:54:18 -c copy -to 00:58:55 $part-a.mp4
ffmpeg -y -i $ORIGINAL18 -ss 00:58:58 -c copy -to 01:00:28.7 $part-b.mp4
ffmpeg -y -i $ORIGINAL18 -ss 01:07:05.6 -c copy -to 01:09:26.4 $part-c.mp4
ffmpeg -y -i $ORIGINAL18 -ss 01:09:30 -c copy -to 01:13:18.9 $part-d.mp4
ffmpeg -y -i $ORIGINAL18 -ss 01:13:23 -c copy -to 01:14:41 $part-e.mp4
ffmpeg -y -i $ORIGINAL18 -ss 01:15:41.6 -c copy -to 01:16:55 $part-f.mp4
echo -e "file $part-a.mp4\nfile $part-b.mp4\nfile $part-c.mp4\nfile $part-d.mp4\nfile $part-e.mp4\nfile $part-f.mp4" > del$part.txt
ffmpeg -y -f concat -safe 0 -i del$part.txt -c copy $DIR/$LECTURE-0$part.mp4

# Strømmer vs. Lister
# ffmpeg -y -i $ORIGINAL18 -ss 01:16:55 -c copy -to 01:19:10 $DIR/$LECTURE-0$((part+=1)).mp4

# Strømmer: tid og tilstand
$((part+=1))
ffmpeg -y -i $ORIGINAL18 -ss 01:16:55 -c copy -to 01:21:40 $part-a.mp4
ffmpeg -y -i $ORIGINAL18 -ss 01:22:09 -c copy -to 01:23:43 $part-b.mp4
echo -e "file $part-a.mp4\nfile $part-b.mp4" > del$part.txt
ffmpeg -y -f concat -safe 0 -i del$part.txt -c copy $DIR/$LECTURE-0$part.mp4

# Et anvendt eksempel: CMA
ffmpeg -y -i in2040-2019-11.mp4 -filter:a "volume=4.0" -c:v copy -ss 01:00:40 -to 01:06:29.7 $DIR/$LECTURE-0$((part+=1)).mp4

# exit # Uncomment to keep intermediate files.

GLOBIGNORE=$ORIGINAL18
rm *.txt *.mp4
unset GLOBIGNORE

# exit # Uncomment to not add frontpages.

# Adding frontpages (takes time as the videos will be reencoded)
cd ../frontpages/scripts
./add-frontpages.sh $NUM
