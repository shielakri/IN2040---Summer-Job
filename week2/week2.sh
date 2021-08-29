#!/bin/bash

NUM=2
LECTURE=0$NUM
DIR=week$NUM
ORIGINAL19=in2040-2019-$LECTURE.mp4
ORIGINAL18=inf2810-2018-$LECTURE.mp4

if [ ! -f $DIR]; then
  mkdir $DIR
fi

part=0

# 1.1 - Repitisjon og Intro
$((part+=1))
ffmpeg -y -i $ORIGINAL18 -ss 00:01:55 -c copy -to 00:05:41.5 $part-a.mp4
ffmpeg -y -i $ORIGINAL18 -ss 00:05:58.7 -c copy -to 00:06:24 $part-b.mp4
echo -e "file $part-a.mp4\nfile $part-b.mp4" > del$part.txt
ffmpeg -y -f concat -safe 0 -i del$part.txt -c copy $DIR/$LECTURE-0$part.mp4

# 1.2 - Substitusjonsmodell og evaluering
ffmpeg -y -i $ORIGINAL18 -ss 00:06:31 -c copy -to 00:15:06 $DIR/$LECTURE-0$((part+=1)).mp4

# 1.3 - Prosedyrer og blokkstruktur
$((part+=1))
ffmpeg -y -i $ORIGINAL18 -ss 00:15:20 -c copy -to 00:23:13 $part-a.mp4
ffmpeg -y -i $ORIGINAL18 -ss 00:23:32 -c copy -to 00:23:57.5 $part-b.mp4
ffmpeg -y -i $ORIGINAL18 -ss 00:24:54.5 -c copy -to 00:29:52.5 $part-c.mp4
echo -e "file $part-a.mp4\nfile $part-b.mp4\nfile $part-c.mp4" > del$part.txt
ffmpeg --y f concat -safe 0 -i del$part.txt -c copy $DIR/$LECTURE-0$part.mp4

# 1.4 - Mangler i funksjonell programmering
$((part+=1))
ffmpeg -y -i $ORIGINAL18 -ss 00:29:53 -c copy -to 00:30:34 $part-a.mp4
ffmpeg -y -i $ORIGINAL18 -ss 00:30:43 -c copy -to 00:34:28 $part-b.mp4
echo -e "file $part-a.mp4\nfile $part-b.mp4" > del$part.txt
ffmpeg -y -f concat -safe 0 -i del$part.txt -c copy $DIR/$LECTURE-0$part.mp4

# 1.5 - Rekursjon
$((part+=1))
ffmpeg -y -i $ORIGINAL18 -ss 00:37:00 -c copy -to 00:39:32.4 $part-a.mp4
ffmpeg -y -i $ORIGINAL18 -ss 00:40:50 -c copy -to 00:44:44 $part-b.mp4
ffmpeg -y -i $ORIGINAL18 -ss 00:44:44.9 -c copy -to 00:45:11 $part-c.mp4
ffmpeg -y -i $ORIGINAL18 -ss 00:45:50 -c copy -to 00:48:05 $part-d.mp4
echo -e "file $part-a.mp4\nfile $part-b.mp4\nfile $part-c.mp4\nfile $part-d.mp4" > del$part.txt
ffmpeg -y -f concat -safe 0 -i del$part.txt -c copy $DIR/$LECTURE-0$part.mp4

# 1.6 - Funksjon, prosedyre og prosess
$((part+=1))
ffmpeg -y -i $ORIGINAL18 -ss 00:48:09.2 -c copy -to 00:59:20 $part-a.mp4
ffmpeg -y -i $ORIGINAL18 -ss 01:00:02 -c copy -to 01:02:10 $part-b.mp4
echo -e "file $part-a.mp4\nfile $part-b.mp4" > del$part.txt
ffmpeg -y -f concat -safe 0 -i del$part.txt -c copy $DIR/$LECTURE-0$part.mp4

# 1.7 - Trerekursjon
$((part+=1))
ffmpeg -y -i $ORIGINAL18 -ss 01:02:11 -c copy -to 01:14:44 $part-a.mp4
ffmpeg -y -i $ORIGINAL18 -ss 01:14:49 -c copy -to 01:15:54 $part-b.mp4
echo -e "file $part-a.mp4\nfile $part-b.mp4" > del$part.txt
ffmpeg -y -f concat -safe 0 -i del$part.txt -c copy $DIR/$LECTURE-0$part.mp4

# 1.8 - Eksponentialfunksjon
ffmpeg -i $ORIGINAL19 -ss 01:18:18 -c copy -to 01:24:57 $DIR/$LECTURE-0$((part+=1)).mp4

# 1.9 - Konvensjon og god stil
$((part+=1))
ffmpeg -y -i $ORIGINAL18 -ss 01:16:53 -c copy -to 01:17:04.3 $part-a.mp4
ffmpeg -y -i $ORIGINAL18 -ss 01:18:55 -c copy -to 01:21:49 $part-b.mp4
echo -e "file $part-a.mp4\nfile $part-b.mp4" > del$part.txt
ffmpeg -y -f concat -safe 0 -i del$part.txt -c copy $DIR/$LECTURE-0$part.mp4

#echo $'file 3-mangler-funksjonell.mp4\nfile 4-rekursjon.mp4\nfile 5-funksjon-prosedyre-prosess.mp4\nfile 6-trerekursjon.mp4\nfile 7-eksponentialfunksjon.mp4' > del02.txt
#ffmpeg -f concat -safe 0 -i del4.txt -c copy $DIR/4-rekursjon.mp4

# exit # Uncomment to keep intermediate files.

GLOBIGNORE=$ORIGINAL19:$ORIGINAL18
rm *.txt *.mp4
unset GLOBIGNORE

# exit # Uncomment to not add frontpages.

# Adding frontpages (takes time as the videos will be reencoded)
cd ../frontpages/scripts
./add-frontpages.sh $NUM
