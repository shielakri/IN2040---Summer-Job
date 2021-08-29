#!/bin/bash

NUM=7
DIR=week$NUM
LECTURE=0$NUM
ORIGINAL19=in2040-2019-08.mp4

if [ ! -f $DIR]; then
  mkdir $DIR
fi

part=0

# Intro og repetisjon
$((part+=1))
ffmpeg -y -i $ORIGINAL19 -ss 00:00:23 -c copy -to 00:02:20 $part-a.mp4
ffmpeg -y -i $ORIGINAL19 -ss 00:11:29 -c copy -to 00:20:12 $part-b.mp4
echo -e "file $part-a.mp4\nfile $part-b.mp4" > del$part.txt
ffmpeg -y -f concat -safe 0 -i del$part.txt -c copy $DIR/$LECTURE-0$part.mp4

# Intro
# ffmpeg -y -i $ORIGINAL19 -ss 00:01:21 -c copy -to 00:02:20 $DIR/$LECTURE-0$((part+=1)).mp4

# Kort om parallelitet
ffmpeg -y -i $ORIGINAL19 -ss 00:20:25 -c copy -to 00:37:29 $DIR/$LECTURE-0$((part+=1)).mp4

# Likhet
$((part+=1))
ffmpeg -y -i $ORIGINAL19 -ss 00:37:35 -c copy -to 00:42:33 $part-a.mp4
ffmpeg -y -i $ORIGINAL19 -ss 00:42:56.7 -c copy -to 00:45:25 $part-b.mp4
echo -e "file $part-a.mp4\nfile $part-b.mp4" > del$part.txt
ffmpeg -y -f concat -safe 0 -i del$part.txt -c copy $DIR/$LECTURE-0$part.mp4

# Destruktive listeoperasjoner
ffmpeg -y -i $ORIGINAL19 -ss 00:45:27.8 -c copy -to 00:55:44 $DIR/$LECTURE-0$((part+=1)).mp4

# Funksjonell listekonkatenasjon
ffmpeg -y -i $ORIGINAL19 -ss 00:55:48.5 -c copy -to 01:02:33 $DIR/$LECTURE-0$((part+=1)).mp4

# Destruktiv listekonkatenasjon
ffmpeg -y -i $ORIGINAL19 -ss 01:02:35 -c copy -to 01:11:05 $DIR/$LECTURE-0$((part+=1)).mp4

# Egendefinerte datatyper – Køer
ffmpeg -y -i $ORIGINAL19 -ss 01:11:51 -c copy -to 01:23:07 $DIR/$LECTURE-0$((part+=1)).mp4

# Sammendrag
ffmpeg -y -i $ORIGINAL19 -ss 01:23:14 -c copy -to 01:25:11 $DIR/$LECTURE-0$((part+=1)).mp4

# exit # Uncomment to keep intermediate files.

GLOBIGNORE=$ORIGINAL19
rm *.txt *.mp4
unset GLOBIGNORE

# exit # Uncomment to not add frontpages.

# Adding frontpages (takes time as the videos will be reencoded)
cd ../frontpages/scripts
./add-frontpages.sh $NUM
