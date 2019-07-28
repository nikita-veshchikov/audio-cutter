#!/bin/bash

# this script converts a sound (music) file .aa to an .mp3 format

#USE:
#./convert.sh FILE_NAME


#ffmpeg use
#ffmpeg -i ORIG.aa -codec copy NEW.mp3

ffmpeg -i $1 -codec copy $1_converted.mp3
