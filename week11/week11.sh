#!/bin/bash

NUM=11
LECTURE=$NUM
DIR=week$NUM
ORIGINAL19=in2040-2019-12.mp4

if [ ! -f $DIR]; then
  mkdir $DIR
fi

# Øker volum:
ffmpeg -y -i $ORIGINAL19 -filter:a "volume=4.0" -c:v copy $ORIGINAL19-vol4.mp4
ORIGINAL19=$ORIGINAL19-vol4.mp4

part=0

# Intro og repetisjon
ffmpeg -y -i $ORIGINAL19 -ss 00:02:07.2 -c copy -to 00:13:23 $DIR/$LECTURE-0$((part+=1)).mp4

# Repetisjon av omgivelsesmodellen
#ffmpeg -y -i $ORIGINAL19 -ss 00:13:33.2 -c copy -to 00:21:16.2 $DIR/$LECTURE-0$((part+=1)).mp4

# Omgivelser og rammer i evaluatoren
ffmpeg -y -i $ORIGINAL19 -ss 00:13:33.2 -c copy -to 00:42:37 $DIR/$LECTURE-0$((part+=1)).mp4

# Evaluatorens 5 hoveddeler
$((part+=1))
ffmpeg -y -i $ORIGINAL19 -ss 00:42:50 -c copy -to 00:43:21.4 $part-a.mp4
ffmpeg -y -i $ORIGINAL19 -ss 00:43:23.7 -c copy -to 00:45:35.5 $part-b.mp4
echo -e "file $part-a.mp4\nfile $part-b.mp4" > del$part.txt
ffmpeg -y -f concat -safe 0 -i del$part.txt -c copy $DIR/$LECTURE-0$part.mp4

# Syntaks til uttrykk
ffmpeg -y -i $ORIGINAL19 -ss 00:46:53.2 -c copy -to 00:54:08.2 $DIR/$LECTURE-0$((part+=1)).mp4

# mc-eval  og mc-apply
$((part+=1))
ffmpeg -y -i $ORIGINAL19 -ss 00:54:25 -c copy -to 00:55:27.65 $part-a.mp4
ffmpeg -y -i $ORIGINAL19 -ss 00:55:32 -c copy -to 01:00:40 $part-b.mp4
ffmpeg -y -i $ORIGINAL19 -ss 01:00:47 -c copy -to 01:07:47.3 $part-c.mp4
ffmpeg -y -i $ORIGINAL19 -ss 01:07:49.3 -c copy -to 01:18:17 $part-d.mp4
ffmpeg -y -i $ORIGINAL19 -ss 01:18:20 -c copy -to 01:18:51 $part-e.mp4
echo -e "file $part-a.mp4\nfile $part-b.mp4\nfile $part-c.mp4\nfile $part-d.mp4\nfile $part-e.mp4" > del$part.txt
ffmpeg -y -f concat -safe 0 -i del$part.txt -c copy $DIR/$LECTURE-0$part.mp4

# REPL
ffmpeg -y -i $ORIGINAL19 -ss 01:18:52 -c copy -to 01:22:02.5 $DIR/$LECTURE-0$((part+=1)).mp4

# Veiledning i hvordan lese kapittel 4
$((part+=1))
ffmpeg -y -i $ORIGINAL19 -ss 01:22:05 -c copy -to 01:24:50.7 $part-a.mp4
ffmpeg -y -i $ORIGINAL19 -ss 01:24:58 -c copy -to 01:25:43 $part-b.mp4
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
