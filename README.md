# Audio Cutter
Set of scripts that allows to conert an audio file to a set of short .mp3 files
This set of script can be used to cut long audio files such as audio books into short 
.mp3 files. It is very uefull for listening audio books in a car from a USB key.
Short audio parts allow fast an easy way to fast forward in the book.
Cuts are mostly made at the moments of silence in the audio thus, 
most of the time the script cuts in between chapters.

Key words: cut audio book, cut long audio into short parts, convert audio books from audible

# get_chapters.sh
Script that uses ffmpeg to cut an audio book into chapters.
It will create a folder that contains chapters of the book.
This script is easy to use.
Example: 
./get_chapters.sh path/to/file.aa

# Other scripts
can be used if some additional audio edditing is needed.
# convert.sh
Script that uses ffmpeg to convert a file to a .mp3 file

Example use:
./convert.sh path/to/audio/file.aa

# extract_cuts.py
Script that tries to filter a list of silences into a shorter list
in such way that each interval is aproximately N minutes (30 minutes by default)

Example use: 
python3 extract_cuts.py silence.txt 1800

silence.txt is created using ffmpeg exapmle:
ffmpeg -i $1 -af silencedetect=n=-50dB:d=3.0 -f null - 2> log.txt # finds silence in audio
sed '1,49 d' log.txt | sed '/size\|video\|start/d' | awk '{print int($5)}' > silence.txt # extracts oments of silence

1800 : number of seconds for one interval

# cut.sh
Script that uses extract_cuts.py and ffmpeg to find silence in an audio file.
It then uses ffmpeg to split the file at posisitons found by extract_cuts.py
The results are stored in a folder that is created in the same folder where the
original file is situated

Example use: 
./cut.sh path/to/audio/file.mp3
