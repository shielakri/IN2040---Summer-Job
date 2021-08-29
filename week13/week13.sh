#!/bin/bash

NUM=13
LECTURE=$NUM
DIR=week$NUM
ORIGINAL18=inf2810-2018-14.mp4
ORIGINAL19=in2040-2019-14.mp4

if [ ! -f $DIR]; then
  mkdir $DIR
fi

part=0

# Oppsummering
$((part+=1))
ffmpeg -y -i $ORIGINAL18 -ss 00:00:59.2 -c copy -to 00:13:56 $part-a.mp4
ffmpeg -y -i $ORIGINAL18 -ss 00:14:07.2 -c copy -to 00:30:57 $part-b.mp4
echo -e "file $part-a.mp4\nfile $part-b.mp4" > del$part.txt
ffmpeg -y -f concat -safe 0 -i del$part.txt -c copy $DIR/$LECTURE-0$part.mp4

# Prøveeksamen: omgivelser og kallstatistikk
$((part+=1))
ffmpeg -y -i $ORIGINAL18 -ss 00:42:50 -c copy -to 00:46:55 $part-a.mp4
ffmpeg -y -i $ORIGINAL18 -ss 00:47:09 -c copy -to 00:59:22.45 $part-b.mp4
ffmpeg -y -i $ORIGINAL18 -ss 01:00:04 -c copy -to 01:09:57 $part-c.mp4
ffmpeg -y -i $ORIGINAL18 -ss 01:11:06 -c copy -to 01:11:43 $part-d.mp4
ffmpeg -y -i $ORIGINAL18 -ss 01:12:45 -c copy -to 01:12:57 $part-e.mp4
ffmpeg -y -i $ORIGINAL18 -ss 01:13:22 -c copy -to 01:14:12 $part-f.mp4
ffmpeg -y -i $ORIGINAL18 -ss 01:14:23 -c copy -to 01:20:24 $part-g.mp4
echo -e "file $part-a.mp4\nfile $part-b.mp4\nfile $part-c.mp4\nfile $part-d.mp4\nfile $part-e.mp4\nfile $part-f.mp4\nfile $part-g.mp4" > del$part.txt
ffmpeg -y -f concat -safe 0 -i del$part.txt -c copy $DIR/$LECTURE-0$part.mp4

# Prøveeksamen: same-fringe
ffmpeg -y -i $ORIGINAL19 -ss 01:20:35 -c copy -to 01:31:33 $DIR/$LECTURE-0$((part+=1)).mp4

# Prøveeksamen: omgivelser og kallstatistikk + same-fringe (sammenslått)
echo -e "file in2040-2020-13/in2040-2020-13-02.mp4\nfile in2040-2020-13/in2040-2020-13-03.mp4" > prove_eksamen.txt
ffmpeg -y -f concat -safe 0 -i prove_eksamen.txt -c copy in2040-2020-13/in2040-2020-13-04.mp4

# exit # Uncomment to keep intermediate files.

GLOBIGNORE=$ORIGINAL19:$ORIGINAL18
rm *.txt *.mp4
unset GLOBIGNORE

# exit # Uncomment to not add frontpages.

# Adding frontpages (takes time as the videos will be reencoded)
cd ../frontpages/scripts
./add-frontpages.sh $NUM
