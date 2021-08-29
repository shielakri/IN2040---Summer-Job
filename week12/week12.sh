#!/bin/bash

NUM=12
LECTURE=$NUM
DIR=week$NUM
ORIGINAL18=inf2810-2018-13.mp4

if [ ! -f $DIR]; then
  mkdir $DIR
fi

part=0

# Intro og repetisjon
$((part+=1))
ffmpeg -y -i $ORIGINAL18 -ss 00:01:00 -c copy -to 00:18:07.7 $part-a.mp4
ffmpeg -y -i $ORIGINAL18 -ss 00:18:14 -c copy -to 00:22:50 $part-b.mp4
echo -e "file $part-a.mp4\nfile $part-b.mp4" > del$part.txt
ffmpeg -y -f concat -safe 0 -i del$part.txt -c copy $DIR/$LECTURE-0$part.mp4

# Representasjon av uttrykk
$((part+=1))
ffmpeg -y -i $ORIGINAL18 -ss 00:23:22 -c copy -to 00:36:29 $part-a.mp4
ffmpeg -y -i $ORIGINAL18 -ss 00:36:40.8 -c copy -to 00:39:13 $part-b.mp4
echo -e "file $part-a.mp4\nfile $part-b.mp4" > del$part.txt
ffmpeg -y -f concat -safe 0 -i del$part.txt -c copy $DIR/$LECTURE-0$part.mp4

# Lazy metasirkulær evaluator
$((part+=1))
ffmpeg -y -i $ORIGINAL18 -ss 00:39:43 -c copy -to 00:49:33 $part-a.mp4
ffmpeg -y -i $ORIGINAL18 -ss 00:51:02.7 -c copy -to 01:11:29.5 $part-b.mp4
echo -e "file $part-a.mp4\nfile $part-b.mp4" > del$part.txt
ffmpeg -y -f concat -safe 0 -i del$part.txt -c copy $DIR/$LECTURE-0$part.mp4

# Strømmer som late lister
$((part+=1))
ffmpeg -y -i $ORIGINAL18 -ss 01:11:54 -c copy -to 01:13:25 $part-a.mp4
ffmpeg -y -i $ORIGINAL18 -ss 01:13:30 -c copy -to 01:13:39 $part-b.mp4
echo -e "file $part-a.mp4\nfile $part-b.mp4" > del$part.txt
ffmpeg -y -f concat -safe 0 -i del$part.txt -c copy $DIR/$LECTURE-0$part.mp4

# Lazy evaluation og destruktive operasjoner
ffmpeg -y -i $ORIGINAL18 -ss 01:13:40 -c copy -to 01:16:38 $DIR/$LECTURE-0$((part+=1)).mp4

# exit # Uncomment to keep intermediate files.

GLOBIGNORE=$ORIGINAL18
rm *.txt *.mp4
unset GLOBIGNORE

# exit # Uncomment to not add frontpages.

# Adding frontpages (takes time as the videos will be reencoded)
cd ../frontpages/scripts
./add-frontpages.sh $NUM
