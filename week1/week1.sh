#!/bin/bash

NUM=1
LECTURE=0$NUM
DIR=week$NUM
ORIGINAL19=in2040-2019-$LECTURE.mp4

if [ ! -f $DIR]; then
  mkdir $DIR
fi

part=0

# adding -y as global option always overwrites the output file

# Tatt live - Ikke inkludert i opptak.
ffmpeg -y -i $ORIGINAL19 -ss 00:13:56 -c copy -to 00:20:02.5 $DIR/$LECTURE-oversikt.mp4
ffmpeg -y -i $ORIGINAL19 -ss 00:20:21 -c copy -to 00:26:51 $DIR/$LECTURE-egenskaper.mp4

# 1.1 - Scheme, Lisp og DrRacket
$((part+=1))
ffmpeg -y -i $ORIGINAL19 -ss 00:41:20 -c copy -to 00:48:07 $part-a.mp4
ffmpeg -y -i $ORIGINAL19 -ss 00:48:13.5 -c copy -to 00:50:07.7 $part-b.mp4
ffmpeg -y -i $ORIGINAL19 -ss 00:50:18 -c copy -to 00:51:02 $part-c.mp4
echo -e "file $part-a.mp4\nfile $part-b.mp4\nfile $part-c.mp4" > del$part.txt
ffmpeg -y -f concat -safe 0 -i del2.txt -c copy $DIR/$LECTURE-0$part.mp4

# 1.2 - Syntaks og semantikk
$((part+=1))
ffmpeg -y -i $ORIGINAL19 -ss 00:51:06 -c copy -to 01:06:03 3-a.mp4
ffmpeg -y -i $ORIGINAL19 -ss 01:06:17 -c copy -to 01:07:35.5 3-b.mp4
echo $'file 3-a.mp4\nfile 3-b.mp4' > del3.txt
ffmpeg -y -f concat -safe 0 -i del3.txt -c copy $DIR/$LECTURE-0$part.mp4

# 1.3 - Opprette prosedyrer
ffmpeg -y -i $ORIGINAL19 -ss 01:07:40.7 -c copy -to 01:11:08 $DIR/$LECTURE-0$((part+=1)).mp4

# 1.4 - Predikater og kondisjonale uttrykk
$((part+=1))
ffmpeg -y -i $ORIGINAL19 -ss 01:11:43 -c copy -to 01:20:21 5-a.mp4
ffmpeg -y -i $ORIGINAL19 -ss 01:21:34 -c copy -to 01:24:42.3 5-b.mp4
echo $'file 5-a.mp4\nfile 5-b.mp4' > del5.txt
ffmpeg -y -f concat -safe 0 -i del5.txt -c copy $DIR/$LECTURE-0$part.mp4

# Tatt live - Ikke inkludert i opptak.
ffmpeg -y -i $ORIGINAL19 -ss 00:41:20 -c copy -to 01:11:08 $DIR/$LECTURE-0$((part+=1)).mp4

# exit # Uncomment to keep intermediate files.

GLOBIGNORE=$ORIGINAL19
rm *.txt *.mp4
unset GLOBIGNORE

# exit # Uncomment to not add frontpages.

# Adding frontpages (takes time as the videos will be reencoded)
cd ../frontpages/scripts
./add-frontpages.sh $NUM
