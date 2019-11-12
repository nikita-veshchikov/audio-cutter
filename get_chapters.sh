#!/bin/bash

# this script finds silence in an mp3 file and cuts it into parts of ~30 minutes

if [ $# -eq 0 ]
then
	echo "Error: No arguments supplied"
	echo "Use example:"
	echo $0 filename.aa
	exit
fi

echo "Extracting silence"

echo "Cuting the mp3"
mkdir $1_cuts

ffmpeg -i $1 -codec copy $1_tmp.mp3
ffmpeg -i $1 2>&1 | grep "Chapter" | tail -n+2 | awk ' NR>1 {printf ","}{printf "%.1f", $4}' 1> $1_tmp
ffmpeg -i $1_tmp.mp3 -f segment -segment_times `cat $1_tmp` -c copy $1_cuts/%03d_part.mp3

rm $1_tmp $1_tmp.mp3



