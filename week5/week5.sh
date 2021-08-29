#!/bin/bash

NUM=5
LECTURE=0$NUM
DIR=week$NUM
ORIGINAL19=in2040-2019-$LECTURE.mp4

if [ ! -f $DIR]; then
  mkdir $DIR
fi

part=0

# Intro og repetisjon
ffmpeg -y -i $ORIGINAL19 -ss 00:00:07 -c copy -to 00:03:34 $DIR/$LECTURE-0$((part+=1)).mp4

# Repetisjon - Lister som trær
ffmpeg -y -i $ORIGINAL19 -ss 00:04:04.1 -c copy -to 00:08:24 $DIR/$LECTURE-0$((part+=1)).mp4

# Intro til og oppfriskning av mengder
ffmpeg -y -i $ORIGINAL19 -ss 00:08:37.85 -c copy -to 00:12:19.5 $DIR/$LECTURE-0$((part+=1)).mp4

# Mengder – Uordnet og ordnet liste
$((part+=1))
ffmpeg -y -i $ORIGINAL19 -ss 00:12:20 -c copy -to 00:13:50 $part-a.mp4
ffmpeg -y -i $ORIGINAL19 -ss 00:13:59 -c copy -to 00:23:26 $part-b.mp4
echo -e "file $part-a.mp4\nfile $part-b.mp4" > del$part.txt
ffmpeg -y -f concat -safe 0 -i del$part.txt -c copy $DIR/$LECTURE-0$part.mp4

# # Mengder – Uordnet liste
# $((part+=1))
# ffmpeg -y -i $ORIGINAL19 -ss 00:08:40 -c copy -to 00:13:47 $part-a.mp4
# ffmpeg -y -i $ORIGINAL19 -ss 00:14:04 -c copy -to 00:17:48 $part-b.mp4
# echo $'file 2-a.mp4\nfile 2-b.mp4' > del2.txt
# ffmpeg -y -f concat -safe 0 -i del2.txt -c copy $DIR/$LECTURE-0$part.mp4
#
# # Mengder – Ordnet liste
# $((part+=1))
# ffmpeg -y -i $ORIGINAL19 -ss 00:17:53 -c copy -to 00:21:28 $part-a.mp4
# ffmpeg -y -i $ORIGINAL19 -ss 00:21:39 -c copy -to 00:23:27 $part-b.mp4
# echo $'file 3-a.mp4\nfile 3-b.mp4' > del3.txt
# ffmpeg -y -f concat -safe 0 -i del3.txt -c copy $DIR/$LECTURE-0$part.mp4

# Mengder – Binærtrær
$((part+=1))
ffmpeg -y -i $ORIGINAL19 -ss 00:23:28 -c copy -to 00:29:20 $part-a.mp4
ffmpeg -y -i $ORIGINAL19 -ss 00:29:34 -c copy -to 00:32:11 $part-b.mp4
echo -e "file $part-a.mp4\nfile $part-b.mp4" > del$part.txt
ffmpeg -y -f concat -safe 0 -i del$part.txt -c copy $DIR/$LECTURE-0$part.mp4

# Mengder – Abstraksjonsbarrieren, egenskaper og svakheter til binærtrær
ffmpeg -y -i $ORIGINAL19 -ss 00:32:13 -c copy -to 00:40:25.5 $DIR/$LECTURE-0$((part+=1)).mp4
# $((part+=1))
# ffmpeg -y -i $ORIGINAL19 -ss 00:32:13 -c copy -to 00:35:40 $part-a.mp4
# ffmpeg -y -i $ORIGINAL19 -ss 00:36:38 -c copy -to 00:40:29 $part-b.mp4
# echo -e "file $part-a.mp4\nfile $part-b.mp4" > del$part.txt
# ffmpeg -y -f concat -safe 0 -i del$part.txt -c copy $DIR/$LECTURE-0$part.mp4

# Bakgrunn til Huffman-koding og kodeboken
$((part+=1))
ffmpeg -y -i $ORIGINAL19 -ss 00:41:05 -c copy -to 00:42:20.5 $part-a.mp4
ffmpeg -y -i $ORIGINAL19 -ss 00:43:52 -c copy -to 00:58:01 $part-b.mp4
echo -e "file $part-a.mp4\nfile $part-b.mp4" > del$part.txt
ffmpeg -y -f concat -safe 0 -i del$part.txt -c copy $DIR/$LECTURE-0$part.mp4

# Introduksjon til Huffman-koding/trær
ffmpeg -y -i $ORIGINAL19 -ss 00:58:09 -c copy -to 01:06:37.5 $DIR/$LECTURE-0$((part+=1)).mp4

# Generere Huffman-trær
ffmpeg -y -i $ORIGINAL19 -ss 01:06:43 -c copy -to 01:15:57 $DIR/$LECTURE-0$((part+=1)).mp4

#Huffman-trær – Abstraksjonsbarrieren
ffmpeg -y -i $ORIGINAL19 -ss 01:16:03.5 -c copy -to 01:26:02 $DIR/$LECTURE-0$((part+=1)).mp4

# exit # Uncomment to keep intermediate files.

GLOBIGNORE=$ORIGINAL19
rm *.txt *.mp4
unset GLOBIGNORE

# exit # Uncomment to not add frontpages.

# Adding frontpages (takes time as the videos will be reencoded)
cd ../frontpages/scripts
./add-frontpages.sh $NUM
