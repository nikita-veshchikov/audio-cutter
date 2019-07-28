#!/bin/bash

# this script finds silence in an mp3 file and cuts it into parts of ~30 minutes

if [ $# -eq 0 ]
then
	echo "Error: No arguments supplied"
	echo "Use example:"
	echo $0 filename.mp3
	exit
fi

echo "Extracting silence"
ffmpeg -i $1 -af silencedetect=n=-50dB:d=3.0 -f null - 2> log.txt

sed '1,49 d' log.txt | sed '/size\|video\|start/d' | awk '{print int($5)}' > silence.txt

echo "Choosing cuts"
python3 extract_cuts.py silence.txt 1800

echo "Cuting the mp3"
mkdir $1_cuts

ffmpeg -i $1 -f segment -segment_times `cat cuts.txt` -c copy $1_cuts/%03d_part.mp3

rm {log,silence,cuts}.txt
