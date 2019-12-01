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

DIR=$(dirname $1)
FILE=$(basename $1)

cd $DIR
mkdir ${FILE}_cuts

ffmpeg -i ${FILE} -codec copy ${FILE}_tmp.mp3
ffmpeg -i $FILE 2>&1 | grep "Chapter" | tail -n+2 | awk ' NR>1 {printf ","}{printf "%.1f", $4}' 1> ${FILE}_tmp 
ffmpeg -i ${FILE}_tmp.mp3 -f segment -segment_times `cat ${FILE}_tmp` -c copy ${FILE}_cuts/%03d_part.mp3 >/dev/null

echo "Adding meta data to the files"

cd ${FILE}_cuts
for f in `ls *.mp3`; do
	echo "Adding metadata to $f"
	eyeD3 --add-image "../cover.jpg:FRONT_COVER" --title="Chapter ${f%_part.*}" $f >/dev/null
done;
cd ..

# cleaning up
rm ${FILE}_tmp ${FILE}_tmp.mp3



